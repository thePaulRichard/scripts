::The following command make a backup from the databases with the actual date
SqlCmd -E -Q "BACKUP DATABASE Database1 TO
DISK='C:\Backup\Database\Database1_%date:~-10,2%%date:~-7,2%%date:~-4,4%.bak'"
SqlCmd -E -Q "BACKUP DATABASE Database2 TO
DISK='C:\Backup\Database\Database2_%date:~-10,2%%date:~-7,2%%date:~-4,4%.bak'"

::Compress the backup's to "actual_date.zip"
"C:\Program Files\7-Zip\7z.exe" a -tzip
C:\Backup\Database\%date:~-10,2%%date:~-7,2%%date:~-4,4%.zip C:\Backup\Database\*.bak

::Erase all the .bak files
del D:\Backup\Database\*.bak

::Sync the .zip file to the Amazon S3 bucket
"C:\Program Files\Amazon\AWSCLI\aws.exe" s3 sync D:\Backup\Database s3://bucket --delete
--storage-class STANDARD_IA

::Erase all files older then 7 days
forfiles /p C:\Backup\Database /s /d -7 /c "cmd /c del @path"
