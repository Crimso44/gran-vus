CREATE PROCEDURE sp_MSget_setup_paths (
@sql_path	NVARCHAR(260) = NULL OUTPUT,
@data_path	NVARCHAR(260) = NULL OUTPUT )
AS
BEGIN

	DECLARE @retcode INTEGER
	DECLARE @regkey NVARCHAR(260)

	SET NOCOUNT ON

	declare @instance sysname
	select @instance = convert(sysname, SERVERPROPERTY('InstanceName'))
	select @regkey = 'SOFTWARE\Microsoft\'
	-- default installation
	if @instance is null
		SELECT @regkey = @regkey + 'MSSQLServer\Setup'
	else
		SELECT @regkey = @regkey + 'Microsoft SQL Server\' + @instance + '\Setup'

	EXECUTE @retcode = master.dbo.xp_regread 'HKEY_LOCAL_MACHINE',
		@regkey,
		'SQLPath',
		@param = @sql_path OUTPUT

	IF ( @retcode <> 0 ) or ( @@ERROR <> 0 )
		RETURN (1)

	EXECUTE @retcode = master.dbo.xp_regread 'HKEY_LOCAL_MACHINE',
		@regkey,
		'SQLDataRoot',
		@param = @data_path OUTPUT

	IF ( @retcode <> 0 ) or ( @@ERROR <> 0 )
		RETURN (1)

	RETURN (0)

END