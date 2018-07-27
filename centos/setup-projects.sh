sudo ls
export SUDO=sudo
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
export LD_LIBRARY_PATH=/usr/local/lib

# end config settings
export CI_HOME=`pwd`
echo CI_HOME: $CI_HOME
mkdir $CI_HOME/proj



printf "\n\n================== librdkafka =======================\n\n"
# we need the latest librdkafka as there as always required updates
cd $CI_HOME/proj
	git clone https://github.com/edenhill/librdkafka
	cd librdkafka
	(unset CFLAGS; ./configure --prefix=/usr/local --CFLAGS="-g" ; make -j)
	sudo make install
 

printf "\n\n================== libksi =======================\n\n"
# we need Guardtime libksi here, otherwise we cannot check the KSI component	
cd $CI_HOME/proj
	git clone https://github.com/guardtime/libksi.git
	cd libksi
	autoreconf -fvi
	./configure --prefix=/usr/local 
	make -j3
	sudo make install


printf "\n\n================== libestr  =======================\n\n"
cd $CI_HOME/proj
git clone https://github.com/rsyslog/libestr.git
cd libestr
git pull
autoreconf -fvi && ./configure --prefix=/usr/local && make -j2 || exit $?
$SUDO make -j2 install || exit $?


printf "\n\n================== libfastjson =======================\n\n"
cd $CI_HOME/proj
git clone https://github.com/rsyslog/libfastjson.git
cd libfastjson
git pull
autoreconf -fvi && ./configure --prefix=/usr/local --disable-journal && make -j2 || exit $?
$SUDO make -j2 install || exit $?


printf "\n\n================== liblogging =======================\n\n"
cd $CI_HOME/proj
git clone https://github.com/rsyslog/liblogging.git
cd liblogging
git pull
autoreconf -fvi && ./configure --prefix=/usr/local --disable-journal && make -j2 || exit $?
$SUDO make -j2 install || exit $?

printf "\n\n================== liblognorm =======================\n\n"
cd $CI_HOME/proj
git clone https://github.com/rsyslog/liblognorm.git
cd liblognorm
git pull
autoreconf -fvi && ./configure --prefix=/usr/local && make -j2 || exit $?
$SUDO make -j2 install || exit $?

printf "\n\n================== liblrelp =======================\n\n"
cd $CI_HOME/proj
git clone https://github.com/rsyslog/librelp.git
cd librelp
git pull
autoreconf -fvi && ./configure --prefix=/usr/local --enable-compile-warnings=yes && make -j2 || exit $?
$SUDO make -j2 install || exit $?


### main project ###
printf "\n\n================== rsyslog =======================\n\n"
printf "This is primarily built to make sure that the helper\n"
printf "projects are correctly built and installed\n\n"

cd $CI_HOME/proj
git clone https://github.com/rsyslog/rsyslog.git
cd rsyslog
git pull
mkdir utils
echo "./configure --prefix=/usr/local $RSYSLOG_CONFIGURE_OPTIONS" --enable-compile-warnings=yes > utils/conf
chmod +x utils/conf

autoreconf -fvi && utils/conf && make -j2 || exit $?

