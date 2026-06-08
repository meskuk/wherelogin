# wherelogin
Trying to trace users to computers based on `lastLogonTimestamp` in Active Directory.

This script basically asks Active Directory, "What computers last authenticated at least 4 hours before
this user logged on, but not after they logged on?" and gives back results.

The usecase is for networks where computers in AD are in fixed locations, letting you narrow down which
computers a user probably logged into* and therefore what room they're in!

This isn't very accurate, because the meaning of `lastLogonTimestamp` for a computer and a user
is quite big. I use a range of 4 hours ago to the user's `lastLogonTimestamp`, which has gotten me
down to 20 computers for myself.

*As a non-privileged user too. Admin access doesn't count.

# How to use

`./where-login.ps1 username-here`

You'll need to edit the script if you want more advanced filtering.
