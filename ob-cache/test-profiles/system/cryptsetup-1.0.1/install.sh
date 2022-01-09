#!/bin/sh

if which cryptsetup >/dev/null 2>&1 ;
then
	echo 0 > ~/install-exit-status
else
	echo "ERROR: cryptsetup is not found on the system!"
	echo 2 > ~/install-exit-status
fi

echo "#!/bin/sh
cryptsetup benchmark > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status
" > cryptsetup
chmod +x cryptsetup


