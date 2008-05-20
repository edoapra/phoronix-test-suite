#!/bin/sh

cd $1

THIS_DIR=$(pwd)
mkdir $THIS_DIR/libxml2

tar -xvf libxml2-2.6.31.tar.gz

cd libxml2-2.6.31/
./configure --prefix=$THIS_DIR/libxml2
make -j $NUM_CPU_JOBS
make install
cd ..
rm -rf libxml2-2.6.31/

echo "#!/bin/sh

if [ ! -f php-5.2.5.tar.bz2 ]
  then
	echo \"PHP5 Not Downloaded... Build Fails.\"
	exit
fi

rm -rf php-5.2.5/
tar -xjf php-5.2.5.tar.bz2
cd php-5.2.5/
./configure --with-libxml-dir=$THIS_DIR/libxml2 > /dev/null
sleep 3
time -f \"PHP Build Time: %e Seconds\" make -s -j \$NUM_CPU_JOBS 2>&1 | grep Seconds" > time-compile-php

chmod +x time-compile-php
