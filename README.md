# wherelogin
Trying to trace users to computers based on `lastLogonTimestamp` in Active Directory.

My intention is that in networks where computers in AD are in fixed locations, you can narrow down which
computers a user probably logged into*.

This isn't very accurate, because the meaning of `lastLogonTimestamp` for a computer and a user
is quite big. I use a range of 4 hours ago to the user's `lastLogonTimestamp`, which has gotten me
down to 20 computers for myself.

*As a non-privileged user too. Admin access doesn't count.

# How to use

Edit the script then run it. :)
