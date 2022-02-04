# SQL-Projects 
These are all projects that I have created and completed.

MaintenenceConfiguration_DeployScript.sql: The data from this config table is turned into XML and sent to a repository. This Deploy script creates the Tables, Stored Procedure, View, and Job to process and store the data.
  
AlertingSync_DeployScript.sql: This project syncs the data for a custom alert system from one server to another in a DAG.

BackupHistory_DeployScript.sql: This creates everything needed to collect the databases that are missing backups, and missing backup count. It also has a Stored Procedure to send a custom alert.

VerifyBackupMovement.ps1: This powershell collects the servers, databases, and missing backup counts.



  
