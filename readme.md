PAMP - Portable Apache MariaDB PHP
=================================================================

Introduction
----------------------------

It's portable web server for php development.

It focues on <u>fully portable</u> and <u>modificable</u>.

It helps to <u>speedly setup or switch</u> development environments for projects on windows. 

Features
----------------------------

- Fast
- Switch between versions
- Portable fully
- Modificable fully
- Small size
- Manually server management

## Requirement

- Microsoft Visual C++ Redistributable, both x86 and x64 versions
  
  - https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist

- The ports `80` `443` `3306` free
  
  - Check: Resource Monitor → Network → Listening Ports

Installation
----------------------------

1. Run `tools\init-dir.bat`
   
   - Note: the directories `db-data`, `project` is created outside of this software

2. Download zip files and move them into `dynamic\fresh`
   
   - Apache: https://www.apachelounge.com/download
   
   - PHP: https://windows.php.net/downloads/releases
   
   - MariaDB: https://mariadb.org/download

3. Run `tools\expand-archive.bat`

4. Run `ssl\trust.bat` (optionally)

5. Run `versions\{version}.bat` for Apache MariaDB PHP

6. Run `start.vbs`

7. Browse http://test.dev.win or https://test.dev.win

## How to switch between versions

- [ ] Repeat step 5,6

## Portable: How to move to new location

- [ ] If it's on new machine
  
  - [ ] Check requirement again 
  
  - [ ] Repeat step 4

- [ ] Repeat step 5,6

## Fully modificable

All files are plain text

## How to add new versions

### Apache

- Download zip file and move it into `dynamic\fresh`
  - Link https://www.apachelounge.com/download
  - Architecture: 32 bit or 64 bit
  - MSVC version: VCx
- Run `tools\expand-archive.bat`
- Create `versions\{version}.bat`

### PHP

- Download zip file and move it into `dynamic\fresh`
  - Link https://windows.php.net/downloads/releases
  - Architecture: 32 bit or 64 bit
  - MSVC version: VCx
  - Thread Safe: ts or nts
- Run `tools\expand-archive.bat`
- Create `versions\{version}.bat`

### MariaDB

- Download zip file and move it into `dynamic\fresh`
  - Link https://mariadb.org/download
  - Architecture: 32 bit or 64 bit
- Run `tools\expand-archive.bat`
- Create `versions\{version}.bat`
- Upgrade database
  + in-place: mysql_upgrade
  + dump: mysqldump

License
----------------------------

This software is licensed under the MIT license.
