If Wscript.Arguments.count <> 2 then
    WScript.Quit
End if

inputPath = Wscript.Arguments(0)
outputPath = Wscript.Arguments(1)

If (CreateObject("Scripting.FileSystemObject").FileExists(outputPath)) Then
   WScript.Quit
End If

Set inputFile = CreateObject("Scripting.FileSystemObject").OpenTextFile(inputPath, 1)
configContent = inputFile.ReadAll
inputFile.Close

' enable and edit
configContent=Replace(configContent,"; extension_dir = ""ext""","extension_dir = ""ext""")
configContent=Replace(configContent,";extension_dir = ""ext""","extension_dir = ""ext""")
configContent=Replace(configContent,";extension=curl","extension=curl")
configContent=Replace(configContent,";extension=fileinfo","extension=fileinfo")
configContent=Replace(configContent,";extension=gd","extension=gd")
configContent=Replace(configContent,";extension=mbstring","extension=mbstring")
configContent=Replace(configContent,";extension=openssl","extension=openssl")
configContent=Replace(configContent,";extension=pdo_mysql","extension=pdo_mysql")
configContent=Replace(configContent,";extension=php_curl","extension=php_curl")
configContent=Replace(configContent,";extension=php_fileinfo","extension=php_fileinfo")
configContent=Replace(configContent,";extension=php_gd","extension=php_gd")
configContent=Replace(configContent,";extension=php_mbstring","extension=php_mbstring")
configContent=Replace(configContent,";extension=php_openssl","extension=php_openssl")
configContent=Replace(configContent,";extension=php_pdo_mysql","extension=php_pdo_mysql")
configContent=Replace(configContent,";date.timezone =","date.timezone = Asia/HO_CHI_MINH")
configContent=Replace(configContent,";session.save_path = ""/tmp""","session.save_path = ""dynamic\temp\session""")

' add new
configContent=configContent & vbCrLf & "[xdebug]"
configContent=configContent & vbCrLf & "xdebug.remote_enable = on"
configContent=configContent & vbCrLf & "xdebug.remote_connect_back = on"
configContent=configContent & vbCrLf & "xdebug.remote_handler = dbgp"
configContent=configContent & vbCrLf & "xdebug.remote_port = 9000"
configContent=configContent & vbCrLf & "xdebug.remote_autostart = on"
configContent=configContent & vbCrLf & "xdebug.profiler_enable = on "
configContent=configContent & vbCrLf & "xdebug.profiler_enable_trigger = off "
configContent=configContent & vbCrLf & "xdebug.profiler_output_dir = ""dynamic\temp\profiler"""
configContent=configContent & vbCrLf & "xdebug.default_enable = off"

' end with new line
configContent=configContent & vbCrLf

set outputFile = CreateObject("Scripting.FileSystemObject").OpenTextFile(outputPath, 2, true)
outputFile.Write configContent
outputFile.Close