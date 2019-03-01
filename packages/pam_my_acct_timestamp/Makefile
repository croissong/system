install:
	mkdir -p /usr/local/lib/security
	gcc -fPIC -DPIC -shared -rdynamic -o /usr/local/lib/security/pam_my_acct_timestamp.so pam_my_acct_timestamp.c -L/lib/security -l:pam_timestamp.so
