::Change Password1!
FOR /F "usebackq tokens=2 delims=,,=" %i IN (`dsquery user -name *`) DO (IF %i == scorebot (echo pass) ELSE IF %i == krbtgt (echo pass) ELSE (net user %i Passord1!)