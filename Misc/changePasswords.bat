:: Batch File for changing all user names in a domain except one called scorebot or krbtgt
:: Used this for a competition so scorebot password needed to remain the same
:: Changing Krbtgt password can be ok sometimes, but also might be dangerous.

FOR /F "usebackq tokens=2 delims=,,=" %i IN (`dsquery user -name *`) DO (IF %i == scorebot (echo pass) ELSE IF %i == krbtgt (echo pass) ELSE (net user %i Passord1!)