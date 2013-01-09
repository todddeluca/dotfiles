#!/usr/bin/python

import subprocess

# include '--dry-run' arg to test what rsync would do.
args = ['rsync', '-avz', '--delete', '--exclude', '*~', '--exclude', '.DS_Store', '--delete-excluded', '/Users/td23/Documents/www/public_html', '/Users/td23/Documents/www/support', 'heylucac@heyluca.com:']
print subprocess.check_call(args)

