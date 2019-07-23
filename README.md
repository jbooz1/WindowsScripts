# WindowsScripts  
Some scripts and things that are useful for Windows things  
Thanks to Dr. Mike O'Leary (Twitter: [@MikeOlearyTU](https://twitter.com/MikeOLearyTu) ) and his book [Cyber Operations](https://www.apress.com/us/book/9781484242933) for a lot of these  


## Misc
1. AutorunRegistryLocations -- a handful of autorun locations in registry and how to query them using PSExec
2. changePasswords.bat  -- Batch one-liner to change all the passwords in a domain
3. disable_Psexec -- Magical Spell that will turn off PSexec for you
  
## MOF
1. cmdeveryminute -- MOF file that will fire off a command prompt every minute
2. processToPayload -- MOF file that will fire off a payload or other program of your choosing each time that another program starts up

## Powershell
1. bulkaddusers  --  Add a whole bunch of users to AD from a CSV file
2. changepasswords -- Change the passwords for all the users in a domain
3. createdUserDected -- Query the event log to determine if any new users have been added
4. disableNetBiosTcpip -- Disable NetBIOS over TCP on every adapter for every system in a domain
5. newSchTaskAudit -- Query all computers on a domain for new Scheduled Tasks
6. newServicesAudit -- Query the event log to find any services that have been created on any domain computer in the the last X amount of time
7. OUmove -- Move users in and out of an Active Directory Organizational Unit
8. registryChangeAudit -- Query the domain computers for any registry values that have been changed in the last X amount of time
9. setDirectoryAuditRule -- Set the permissions of a directory on every computer in the domain
10. StartupDirectoryList -- List the files that are in each users startup directory on every computer on the domain
11. wmiDetect -- List the WMI Subscriptions for each computer on the domain
