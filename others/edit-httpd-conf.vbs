If Wscript.Arguments.count <> 1 then
    WScript.Quit
End if

configPath = Wscript.Arguments(0)

Set inputFile = CreateObject("Scripting.FileSystemObject").OpenTextFile(configPath, 1)
configContent = inputFile.ReadAll
inputFile.Close

If InStr(configContent, "##Edited##") > 0 Then
    WScript.Quit
End If

' mark for edited
configContent="##Edited##" & vbCrLf & configContent

' enable and edit
configContent=Replace(configContent,"ServerRoot ""","#ServerRoot """)
configContent=Replace(configContent,"DocumentRoot ""","#DocumentRoot """)
configContent=Replace(configContent,"#LoadModule access_compat_module","LoadModule access_compat_module")
configContent=Replace(configContent,"#LoadModule expires_module","LoadModule expires_module")
configContent=Replace(configContent,"#LoadModule lbmethod_byrequests_module","LoadModule lbmethod_byrequests_module")
configContent=Replace(configContent,"#LoadModule proxy_module","LoadModule proxy_module")
configContent=Replace(configContent,"#LoadModule proxy_balancer_module","LoadModule proxy_balancer_module")
configContent=Replace(configContent,"#LoadModule proxy_http_module","LoadModule proxy_http_module")
configContent=Replace(configContent,"#LoadModule proxy_http2_module","LoadModule proxy_http2_module")
configContent=Replace(configContent,"#LoadModule proxy_wstunnel_module","LoadModule proxy_wstunnel_module")
configContent=Replace(configContent,"#LoadModule rewrite_module","LoadModule rewrite_module")
configContent=Replace(configContent,"#LoadModule slotmem_shm_module","LoadModule slotmem_shm_module")
configContent=Replace(configContent,"#LoadModule ssl_module","LoadModule ssl_module")
configContent=Replace(configContent,"DirectoryIndex index.html","DirectoryIndex index.html index.php")

' add new
configContent=configContent & vbCrLf & "AddType application/x-httpd-php .php"
configContent=configContent & vbCrLf & "Include conf/httpd-need/*.conf"
configContent=configContent & vbCrLf & "Include ""${serverdir}\dynamic\php\httpd-php.conf"""
configContent=configContent & vbCrLf & "ServerName localhost"
configContent=configContent & vbCrLf & "Listen 443"
configContent=configContent & vbCrLf & "Include conf/httpd-vhosts/*.conf"

' end with new line
configContent=configContent & vbCrLf

set outputFile = CreateObject("Scripting.FileSystemObject").OpenTextFile(configPath, 2)
outputFile.Write configContent
outputFile.Close