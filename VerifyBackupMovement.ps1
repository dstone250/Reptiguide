#Author David Stone:
#VerifyBackupMovement.ps1
#Date Created:  2021-05-10 
#Date modified: 2021-06-08 : I updated this to work on dev by matching all of the names correctly
#Date modified: 2021-06-09 : I updated this to insert a type of 1 for backups
#Date modified: 2021-06-18 : I updated this to insert a DAGID of 1 for 101 and 2 for 201
#Date modified: 2021-07-07 : I updated this to run the same program for dev test and prod.
#Date modified: 2021-09-16 : I added error handling/logging for the sql inserts
#Date modified: 2021-10-29 : This only counts .BAK filesnow. $DefaultBackupNumber was changed to 21 from 3, to work in prod.
#Date modified: 2021-11-01 : I modified this to use $_.Name -like '*.bak', and updated line 127 to update the backup count too, not just DateUpdated.
#Date modified: 2022-18-01 : This was updated to work with an extra sub folder, such as a backup folder in the wrong place, or 2019 folder.
#Date modified: 2022-18-01 : The default backup number was changed from 2 to 3.

$serverArray = @(); 
$serverArray += Invoke-Sqlcmd -ServerInstance "localhost" -Database "BackupMonitor" -Query "SELECT BackupPath FROM [BackupMonitor].[backupMonitoring].[BackupServer] WHERE CountBackupFiles = 1"

If ($serverArray.count -eq 1)
{
    $basePath1 = $serverArray[0].BackupPath
}
If ($serverArray.count -eq 2)
{
    $basePath1 = $serverArray[0].BackupPath
    $basePath2 = $serverArray[1].BackupPath
}

#Error logging
function WriteLog
{
    Param ([string]$LogString)
    $LogFile = "L:\$(gc env:computername).log"
    $DateTime = "[{0:MM/dd/yy} {0:HH:mm:ss}]" -f (Get-Date)
    $LogMessage = "$Datetime $LogString"
    Add-content $LogFile -value $LogMessage
}

$basePath = $basePath1;
$subPath1; #This gets appended to $basePath and tracks the folders inside the new path: $subpath1
$subpath2; #This gets appended to $subpath1 and tracks the files inside the new path $Subpath2
$backups=@();
$backupCounts=@();
$serverName = "Server: ";
$databaseName = "Database: ";

#set up server and database info
$SQLSERVER = "localhost";  
$database = "BackupMonitor";
$DefaultBackupNumber = 3;

#loop once for 101 and twice for 201
$loops = 0;
$loopsCount = $serverArray.count;

While($loops -lt $loopsCount)
{
    
    Get-ChildItem $basePath | Where-Object {$_.PSIsContainer} | Foreach-Object{
        
        $subpath1 = Join-Path $basePath $_.Name
        #There is a Server with backups. Add the server name to the array $backups
        $backups += $serverName + $_.Name + "`n";


        Get-ChildItem $subpath1 | Where-Object {$_.PSIsContainer} | Foreach-Object{                             
            
        $subpath2 = Join-Path $subpath1 $_.Name; 
        $Tempdbname = $_.Name;

        $folderCount = (Get-ChildItem $subpath2 | Where-Object {$_.PSIsContainer}| Measure-Object).Count;

            if($folderCount -eq 0) #this is a normal folder, count the backups inside
            {
                if((Get-ChildItem $subpath2 | WHERE {$_.Name -like "*.bak"} | Measure-Object).Count -lt $DefaultBackupNumber){
                    if(-NOT($_.Name -eq 'master' -or $_.Name -eq 'model' -or $_.Name -eq 'msdb' -or $_.Name -eq 'Utility'))
                    {   
                        #There is a database with files. Add the database name to the array $backups
                        $backups += $databaseName + $_.Name + "`n";
                        $backupCounts += (Get-ChildItem $subpath2 -recurse | WHERE {$_.Name -like "*.bak"} | Measure-Object).Count;  #record the number of backups to be inserted later                        
                    }
                }
            }
            elseif($folderCount -gt 0) #this is a folder in a folder, count the backups inside the child folder
            {
                Get-ChildItem $subpath2 | Where-Object {$_.PSIsContainer} | Foreach-Object{
                                       
                    $subpath3 = Join-Path $subpath2 $_.Name;
                    if((Get-ChildItem $subpath3 | WHERE {$_.Name -like "*.bak"} | Measure-Object).Count -lt $DefaultBackupNumber)
                    {
                        if(-NOT($_.Name -eq 'master' -or $_.Name -eq 'model' -or $_.Name -eq 'msdb' -or $_.Name -eq 'Utility'))
                        {   
                            #There is a database with files. Add the database name to the array $backups
                            $backups += $databaseName + $Tempdbname + "/" + $_.Name + "`n";
                            $backupCounts += (Get-ChildItem $subpath3 -recurse | WHERE {$_.Name -like "*.bak"}| Measure-Object).Count;  #record the number of backups to be inserted later
                        }
                    }
                }#FOREACH: subpath3
            }#ELSE              
        }#ForEach: subpath1
    }#ForEach: basepath: SQLbackups/environment/full

    Write-Host $backups

    #Insert the data into the database                                                                                          
    #The database and server names have a preface so I knew where to insert them. This gets split off before the insert         
    #The backups all end in .BAK so I sort them out that way and have nothing to split off.                                     

    $Iterator = 0;
    #loop through each item
    foreach ($line in $backups)
    {
        if($line -like 'Server: *' )
        {   
            #Split off the identifier
            $line = $line.split(" ")[1]

            #If the data doesnt exist, insert it 
            Invoke-Sqlcmd -ServerInstance $SQLSERVER -Database $database -Query "
            IF NOT EXISTS (SELECT TOP 1 1 FROM [BackupHistory].[ServerName] WHERE Name='$line')
            BEGIN INSERT INTO [BackupHistory].[ServerName] (Name)
            VALUES ('$line') END"
            
            #get the current ServerID.          
            $Temp = Invoke-Sqlcmd -ServerInstance $SQLSERVER -Database $database -Query "SELECT ServerNameID FROM [BackupMonitor].[BackupHistory].[ServerName] WHERE Name = '$line'"
            $CurrentServerID = $Temp.ServerNameID
        }
        elseif($line -like 'Database: *' )
        {   
            #Split off the identifier      
            $line = $line.split(" ")[1]
        
            #If the data doesnt exist, insert it 
            Invoke-Sqlcmd -ServerInstance $SQLSERVER -Database $database -Query "
            IF NOT EXISTS (SELECT TOP 1 1 FROM [BackupHistory].[DatabaseName] WHERE Name='$line')
            BEGIN 
                INSERT INTO [BackupHistory].[DatabaseName] (Name)
	            VALUES ('$line') 
            END"  
 
            #set the current DatabaseID
            $Temp = Invoke-Sqlcmd -ServerInstance $SQLSERVER -Database $database -Query "SELECT DatabaseNameID FROM [BackupMonitor].[BackupHistory].[DatabaseName] WHERE Name = '$line'"
            $CurrentDatabaseID = $Temp.DatabaseNameID

            #Pick the correct backupcount to insert
            $backupCount=$backupCounts[$Iterator]
            $Iterator+=1;

            #If the missing backup doesnt exist, Insert the ServerID and missing DatabaseID into the database. Else update the BackupCount
            try{
                Invoke-Sqlcmd -ServerInstance $SQLSERVER -Database $database -Query "
                IF NOT EXISTS (SELECT TOP 1 1 FROM [BackupHistory].[MissingBackup] 
                WHERE DatabaseNameID='$CurrentDatabaseID' AND ServerNameID='$CurrentServerID')
                BEGIN 
                    INSERT INTO [BackupHistory].[MissingBackup] (ServerNameID, DatabaseNameID, BackupCount) 
	                VALUES ('$CurrentServerID', '$CurrentDatabaseID', '$BackupCount')  
                END
                IF EXISTS (SELECT TOP 1 1 FROM [BackupHistory].[MissingBackup] WHERE DatabaseNameID='$CurrentDatabaseID' AND ServerNameID='$CurrentServerID')
                BEGIN
                    UPDATE [BackupHistory].[MissingBackup]                 
                    SET BackupCount = '$BackupCount' 
                    WHERE ServerNameID='$CurrentServerID' AND DatabaseNameID='$CurrentDatabaseID' 
                END" 
            }
            catch{ WriteLog "The insert/update for [BackupHistory].[MissingBackup] did not work."}
        }

    }#for loop end

#Set the variables if it loops twice for 201
$basePath = $basePath2;
$loops+=1;
Clear-Variable -Name "backups";

}#while loop end
