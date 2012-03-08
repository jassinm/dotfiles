#!/usr/bin/python
import re
import os


def get_authinfo_password(account):
    p = re.compile('%s:\s+(\w+)' % account)
    authinfo = os.popen("gpg -q -d ~/.secret/.passwd.gpg").read()
    return p.search(authinfo).group(1)
