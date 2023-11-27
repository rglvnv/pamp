Set fso = CreateObject("Scripting.FileSystemObject")

serverdir = fso.GetParentFolderName(WScript.ScriptFullName)

ExistFlag = 0
Set objEnv = CreateObject("WScript.Shell").Environment("User")
If 0 < InStr(objEnv("Path"), serverdir & "\dynamic\php") Then
    ExistFlag = 1
end if
Set objEnv = CreateObject("WScript.Shell").Environment("System")
If 0 < InStr(objEnv("Path"), serverdir & "\dynamic\php") Then
    ExistFlag = 1
end if

Set oShell = CreateObject("WScript.Shell")
tempdir=oShell.ExpandEnvironmentStrings("%temp%")
tempbat=tempdir & "\temp_httpd_1221_3.bat"

batcontent=""
If 0 = ExistFlag then
    batcontent=batcontent & "set Path=%Path%;" & serverdir & "\dynamic\php" & vbCrLf
End if
batcontent=batcontent & serverdir & "\dynamic\httpd\bin\httpd.exe"

set outputFile = CreateObject("Scripting.FileSystemObject").OpenTextFile(tempbat, 2, true)
outputFile.Write batcontent
outputFile.Close

if(fso.FolderExists(serverdir & "\dynamic\mariadb") and fso.FolderExists(serverdir & "\dynamic\httpd")) then
    CreateObject("WScript.Shell").Run "cmd /c start """" /b """ & serverdir & "\dynamic\mariadb\bin\mysqld.exe"" --defaults-file=""" & serverdir & "\dynamic\mariadb\my.ini""", 0, true
    CreateObject("WScript.Shell").Run "cmd /c start """" /b """ & tempbat & """", 0, true

    if Wscript.Arguments.count = 0 then 
        CreateObject("WScript.Shell").popup "start done", 1
    end if
end if

If fso.FileExists(tempbat) Then
    fso.DeleteFile(tempbat)
end if