# wherelogin

> [!NOTE]
> This doesn't actually work and can easily mislead you. But it was fun to make, so I'll leave it here.

Trying to trace users to computers based on `lastLogon` in Active Directory.

This script basically asks Active Directory, "What computers last authenticated at least X minutes/hours before
this user logged on, but not after they logged on?" and gives back results.

It works under the assumption that the `lastLogon` time for a user and their computer are similar, otherwise you
get no results.

# How to use

Edit the script to choose your domain controller (because one might have better times than the other), then:

```
./where-login.ps1 username-here
```

You'll need to edit the script if you want more advanced filtering.
