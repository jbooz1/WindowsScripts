Use this on a domain controller to query (some) autorun registry locations on your domain
hosts.txt is a file with all hosts (one per line)
Note that these are only a few of the *many many* autorun registry locations

```
psexec.exe @hosts.txt reg query <INSERT REG KEY HERE>

HKCU\Software\Microsoft\Windows\CurrentVersion\Run
HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce
HKLM\Software\Microsoft\Windows\CurrentVersion\Run
HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce
HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon

# For 32 bit locations on 64 bit system
HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run
HKCU\Software\Wow6432Node\\Microsoft\Windows\CurrentVersion\RunOnce
HKLM\Software\Wow6432Node\\Microsoft\Windows\CurrentVersion\Run
HKLM\Software\Wow6432Node\\Microsoft\Windows\CurrentVersion\RunOnce
```