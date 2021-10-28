Issue #1: (Status: Resolved)
running PS scripts in Win10 by double clicking failed with permission error.
being a local administrator is not enough, join the user to the Hyper-V administrators.

Issue #2: (Status: Unknown)
It Seems the script of the machines other from the DC is not always working
the machine did not join the domain, require checking
first aproach should be to add a pause before restarting to the script to actually see the error.

Issue #3: (Certificates are not Trusted)
need to try and make a template with read permissions