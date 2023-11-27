@echo off
setlocal

PowerShell ^
    $containerdir = (get-item .).parent.fullname; ^
    Set-Location -Path "$containerdir\dynamic\fresh"; ^
    $ab = Get-Location; ^
    $list = Get-ChildItem . -Filter *.zip; ^
    foreach ($f in $list){ ^
        $type = $f.name -replace '^([^-]*)-.*','$1'; ^
        $name = $f.name -replace '^(.*)\.zip$','$1'; ^
        Write-Output $name; ^
        Switch ($type) ^
        { ^
            "httpd" { ^
                if(!(Test-Path $name)) { ^
                    Expand-Archive "$f.name" -DestinationPath "$name-temp"; ^
                    mv "$name-temp\Apache24" "$name"; ^
                    Remove-Item -LiteralPath "$name-temp" -Force -Recurse; ^
                } ^
                Break; ^
            } ^
            "mariadb" { ^
                if(!(Test-Path $name)) { ^
                    Expand-Archive "$f.name" -DestinationPath "."; ^
                } ^
                Break; ^
            } ^
            "php" { ^
                if(!(Test-Path $name)) { ^
                    Expand-Archive "$f.name" -DestinationPath "$name"; ^
                } ^
                Break; ^
            } ^
        } ^
    }

Exit