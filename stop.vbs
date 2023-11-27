Set fso = CreateObject("Scripting.FileSystemObject")

serverdir = fso.GetParentFolderName(WScript.ScriptFullName)

if(fso.FolderExists(serverdir & "\dynamic\mariadb")) then
    CreateObject("WScript.Shell").Run "cmd /c start """" /b wmic process where ""commandline like '%%httpd.exe%%' and not name like 'wmic.exe'"" call terminate", 0, true
    CreateObject("WScript.Shell").Run "cmd /c start """" /b """ & serverdir & "\dynamic\mariadb\bin\mysqladmin"" shutdown", 0, true

    if Wscript.Arguments.count = 0 then 
        CreateObject("WScript.Shell").popup "stop done", 1
    end if
end if
