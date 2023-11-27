Set oShell = CreateObject("WScript.Shell")
tempdir=oShell.ExpandEnvironmentStrings("%temp%")
temp1=tempdir & "\temp_server_status_1221_1"
temp2=tempdir & "\temp_server_status_1221_2"

set fso = CreateObject("Scripting.FileSystemObject")

status = ""
CreateObject("WScript.Shell").Run "cmd /c start """" /min /b wmic process where ""commandline like '%%httpd.exe%%' and not name like 'wmic.exe'"" get name,processid | findstr httpd > """ & temp1 & """", 0, true
Set file1 = fso.OpenTextFile(temp1, 1)
if(Not file1.AtEndOfStream) then    
    if(0 < len(trim(file1.ReadAll))) then
        status = status & vbCrLf & vbCrLf & "Httpd is Running"
    end if
else
    status = status & vbCrLf & vbCrLf & "Httpd is Nothing"
end if
file1.close

If fso.FileExists(temp1) Then
    fso.DeleteFile(temp1)
end if

CreateObject("WScript.Shell").Run "cmd /c start """" /min /b wmic process where ""commandline like '%%mysqld.exe%%' and not name like 'wmic.exe'"" get name,processid | findstr mysqld > """ & temp2 & """", 0, true
Set file2 = fso.OpenTextFile(temp2, 1)
if(Not file2.AtEndOfStream) then    
    if(0 < len(trim(file2.ReadAll))) then
        status = status & vbCrLf & vbCrLf & "MariaDB is Running"
    end if
else
    status = status & vbCrLf & vbCrLf & "MariaDB is Nothing"
end if
file2.close

If fso.FileExists(temp2) Then
    fso.DeleteFile(temp2)
end if

CreateObject("WScript.Shell").popup trim(status), 1, "status"