unit lzss;

interface

const
  _EOF=-1;

type

  fn_getc=function : Integer;
  fn_putc=procedure (c: Integer);

  procedure Encode;
  procedure Decode;

var
  getc: fn_getc;
  putc: fn_putc;

implementation


//#include <stdio.h>
//#include <stdlib.h>
//#include <string.h>
//#include <ctype.h>

type AByte=Array[0..0] of byte;
     PByte=^AByte;
const
  N = 4096;       // size of ring buffer
  F = 18  ;       // upper limit for match_length
  THRESHOLD = 2; // encode string into position and length
		// if match_length is greater than this
  _NIL=N ;	// index for root of binary search trees

var
  text_buf: Array[0..N + F - 1] of byte;
     // ring buffer of size N,
    //  with extra F-1 bytes to facilitate string comparison
    match_position, match_length: Integer; // of longest match.  These are
                                          //  set by the InsertNode() procedure.
    lson: Array [0..N + 1] of Integer;
    rson: Array [0..N + 257] of Integer;
    dad:  Array [0.. N + 1] of Integer;
    // left & right children & parents -- These constitute binary search trees.

procedure InitTree; // initialize trees
var i: Integer;
begin

	{ For i = 0 to N - 1, rson[i] and lson[i] will be the right and
	   left children of node i.  These nodes need not be initialized.
	   Also, dad[i] is the parent of node i.  These are initialized to
	   NIL (= N), which stands for 'not used.'
	   For i = 0 to 255, rson[N + i + 1] is the root of the tree
	   for strings that begin with character i.  These are initialized
	   to NIL.  Note there are 256 trees. }

  for i := N + 1 to N + 256 do rson[i] := _NIL;
  for i := 0 to N-1 do dad[i] := _NIL;
end;

procedure InsertNode(r: Integer);
	{ Inserts string of length F, text_buf[r..r+F-1], into one of the
	   trees (text_buf[r]'th tree) and returns the longest-match position
	   and length via the global variables match_position and match_length.
	   If match_length = F, then removes the old node in favor of the new
	   one, because the old one will be deleted sooner.
	   Note r plays double role, as tree node and position in buffer. }
var  i, p, cmp: Integer;
     key: PByte;
begin
  cmp := 1;
  key := @text_buf[r];
  p := N + 1 + key[0];
  rson[r] := _NIL; lson[r] := _NIL;  match_length := 0;
  while true do begin
    if cmp >= 0 then begin
      if (rson[p] <> _NIL) then p := rson[p]
      else begin
        rson[p] := r;
        dad[r] := p;
        Exit
      end;
    end
    else begin
      if lson[p] <> _NIL then p := lson[p]
      else begin
        lson[p] := r;
        dad[r] := p;
        Exit;
      end;
    end;
    for i := 1 to F-1 do begin
      cmp := key[i] - text_buf[p + i];
      if cmp <> 0 then  break;
    end;
    if i > match_length then begin
      match_position := p;
      match_length := i;
      if match_length >= F then break;
    end;
  end;
  dad[r] := dad[p];
  lson[r] := lson[p];
  rson[r] := rson[p];
  dad[lson[p]] := r;
  dad[rson[p]] := r;
  if rson[dad[p]] = p then  rson[dad[p]] := r
  else lson[dad[p]] := r;
  dad[p] := _NIL;  // remove p
end;

procedure DeleteNode(p: Integer);  // deletes node p from tree
var q: Integer;
begin
  if dad[p] = _NIL then Exit; // not in tree
  if rson[p] = _NIL then q := lson[p]
  else
    if lson[p] = _NIL then q := rson[p]
    else begin
      q := lson[p];
      if rson[q] <> _NIL then begin
	repeat q := rson[q]  until rson[q] = _NIL;
	rson[dad[q]] := lson[q];
        dad[lson[q]] := dad[q];
	lson[q] := lson[p];
        dad[lson[p]] := q;
      end;
      rson[q] := rson[p];
      dad[rson[p]] := q;
    end;
  dad[q] := dad[p];
  if rson[dad[p]] = p then rson[dad[p]] := q  else lson[dad[p]] := q;
  dad[p] := _NIL;
end;

procedure Encode;
var i,c,len,r,s,last_match_length,code_buf_ptr: Integer;
    code_buf: Array[0..17] of byte;
    mask: byte;
begin
  InitTree;  // initialize trees
  code_buf[0] := 0;
    { code_buf[1..16] saves eight units of code, and
		code_buf[0] works as eight flags, "1" representing that the unit
		is an unencoded letter (1 byte), "0" a position-and-length pair
		(2 bytes).  Thus, eight units require at most 16 bytes of code. }
	code_buf_ptr := 1;
        mask := 1;
	s := 0;
        r := N - F;
//	for i := s to r-1 do text_buf[i] := $20;  // Clear the buffer with
                                		 // any character that will appear often.
        FillChar(text_buf[s],r-s,0);
	for len := 0 to F-1 do begin
          c := getc;
          if c=_EOF then break;
   	  text_buf[r + len] := c;  // Read F bytes into the last F bytes of the buffer
        end;
	if len = 0 then Exit;  // text of size zero
	for i := 1 to F-1 do InsertNode(r - i);
             {  Insert the F strings,
		each of which begins with one or more 'space' characters.  Note
		the order in which these strings are inserted.  This way,
		degenerate trees will be less likely to occur. }
	InsertNode(r);
             {  Finally, insert the whole string just read.  The
		global variables match_length and match_position are set. }
	repeat
		if match_length > len then match_length := len;
                     { match_length
                       may be spuriously long near the end of text. }
		if match_length <= THRESHOLD then begin
 		  match_length := 1;  // Not long enough match.  Send one byte.
		  code_buf[0] := code_buf[0] or mask;  // 'send one byte' flag
		  code_buf[code_buf_ptr] := text_buf[r];  // Send uncoded.
                  Inc(code_buf_ptr);
                end
		else begin
		  code_buf[code_buf_ptr] := match_position;
                  Inc(code_buf_ptr);
		  code_buf[code_buf_ptr] :=
                    ((match_position shr  4) and $f0) or
		     (match_length - (THRESHOLD + 1));
                  Inc(code_buf_ptr);
                       { Send position and
		       	length pair. Note match_length > THRESHOLD. }
		end;
                mask := mask shl 1; // Shift mask left one bit.
		if mask = 0 then begin
		  for i := 0 to code_buf_ptr-1 do   // Send at most 8 units of
                    putc(code_buf[i]);    // code together
                  code_buf[0] := 0;
                  code_buf_ptr := 1;
                  mask := 1;
		end;
		last_match_length := match_length;
		for i := 0 to last_match_length-1 do begin
                  c := getc;
                  if c = _EOF then break;
  		  DeleteNode(s);		// Delete old strings and
  		  text_buf[s] := c;	// read new bytes
		  if s < F - 1 then text_buf[s + N] := c;
                            {   If the position is
				near the end of buffer, extend the buffer to make
				string comparison easier. }
		  s := (s + 1) and (N - 1);
                  r := (r + 1) and (N - 1);
				{ Since this is a ring buffer, increment the position
				   modulo N. }
		  InsertNode(r);	// Register the string in text_buf[r..r+F-1]
		end;
		while true do begin
                  Inc(i);
                  if i>last_match_length then break;
                                            // After the end of text,
  		  DeleteNode(s);            // no need to read, but
		  s := (s + 1) and (N - 1);
                  r := (r + 1) and (N - 1);
                  Dec(len);
		  if len>0 then InsertNode(r); // buffer may not be empty.
		end;
	until len <=0;	// until length of string to be processed is zero
	if code_buf_ptr > 1  then 	// Send remaining code.
	   for i := 0 to code_buf_ptr-1 do putc(code_buf[i]);
end;

procedure Decode;	//* Just the reverse of Encode().
var  i, j, k, r, c: Integer;
     flags: Cardinal;
begin
//  for i := 0 to N - F-1 do text_buf[i] := $20;
  FillChar(text_buf,N-F,0);
  r := N - F;
  flags := 0;
  while true do begin
   flags := flags shr 1;
   if flags and 256 = 0 then begin
     c := getc;
     if c = _EOF then break;
     flags := c or $ff00; // uses higher byte cleverly
   end;	// to count eight
   if flags and 1<>0 then begin
     c := getc;
     if c = _EOF then break;
     putc(c);
     text_buf[r] := c;
     Inc(r);
     r := r and (N - 1);
   end
   else begin
     i := getc;
     if i = _EOF then break;
     j := getc;
     if j = _EOF then break;
     i := i or ((j and $f0) shl 4);
     j := (j and  $0f) + THRESHOLD;
     for k := 0 to j do begin
       c := text_buf[(i + k) and (N - 1)];
       putc(c);
       text_buf[r] := c;
       Inc(r);
       r := r and (N - 1);
     end;
   end;
  end;
end;

initialization

end.
