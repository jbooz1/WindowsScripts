This is a crazy spell that will somehow disable PSExec due to some Windows magic.
Credit to [John Lambert's tweet](https://twitter.com/johnlatwc/status/802218490404798464?lang=en) for telling me how to do this

Below is an sc query and the expected output when PSExec is ENABLED
```
sc.exe \\targethost
D:(A;;CC;;;AU)(A;;CCLCRPRC;;;IU)(A;;CCLCRPRC;;;SU)(A;;CCLCRPWPRC;;;SY)(A;;KA;;;BA)(A;;CC;;;AC)
```

Run this command in a CMD shell (not Powershell) to disable psexec on the target
```
sc.exe \\targethost sdset scmanager D:(D;;GA;;;NU)(A;;CC;;;AU)(A;;CCLCRPRC;;;IU)(A;;CCLCRPRC;;;SU)(A;;CCLCRPWPRC;;;SY)(A;;KA;;;BA)(A;;CC;;;AC)
```