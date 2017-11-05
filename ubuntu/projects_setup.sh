# includes rsyslog projects as well as third-party dependencies which
# cannot be installed fom package
set -v
#set -x
if [ ! -e ~/proj ]; then
    mkdir ~/proj
fi
cd ~/proj


# THIRD-PARTY DEPENDENCIES
echo librdkafka
sudo apt-get install -qq liblz4-dev
git clone https://github.com/edenhill/librdkafka
./configure
make -j2
sudo make install


# FROM HERE ON RSYSLOG ONLY
if [ ! -e libestr ]; then
	git clone https://github.com/rsyslog/libestr.git
fi
cd libestr
git pull
autoreconf -fvi && ./configure && make  make -j2 || exit $?
sudo make install || exit $?

# Adiscon-Guardtime components are no longer needed
#cd ~/proj
#if [ ! -e libgt ]; then
	#git clone https://github.com/rsyslog/libgt.git
#fi
#cd libgt
#git pull
#autoreconf -fvi && ./configure && make  make -j2 || exit $?
#sudo make install || exit $?
#
#cd ~/proj
#if [ ! -e libksi ]; then
	#git clone https://github.com/rsyslog/libksi
#fi
#cd libksi
#git pull
#autoreconf -fvi && ./configure && make  make -j2 || exit $?
#sudo make install || exit $?

cd ~/proj
if [ ! -e libfastjson ]; then
	git clone https://github.com/rsyslog/libfastjson.git
fi
cd libfastjson
git pull
autoreconf -fvi && ./configure && make  make -j2 || exit $?
sudo make install || exit $?


cd ~/proj
if [ ! -e liblogging ]; then
	git clone https://github.com/rsyslog/liblogging.git
fi
cd liblogging
git pull
autoreconf -fvi && ./configure --disable-journal && make  make -j2 || exit $?
sudo make install || exit $?

cd ~/proj
if [ ! -e liblognorm ]; then
	git clone https://github.com/rsyslog/liblognorm.git
fi
cd liblognorm
git pull
autoreconf -fvi && ./configure --enable-compile-warnings=yes && make  make -j2 || exit $?
sudo make install || exit $?

cd ~/proj
if [ ! -e librelp ]; then
	git clone https://github.com/rsyslog/librelp.git
fi
cd librelp
git pull
autoreconf -fvi && ./configure && make  make -j2 || exit $?
sudo make install || exit $?

cd ~/proj
if [ ! -e rsyslog-doc ]; then
	git clone https://github.com/rsyslog/rsyslog-doc.git
fi
cd rsyslog-doc
git pull


### main project ###
# This is primarily built to make sure that the helper
# projects are correctly built and installed

cd ~/proj
if [ ! -e rsyslog ]; then
	git clone https://github.com/rsyslog/rsyslog.git
fi
cd rsyslog
git pull
if [ ! -e utils ]; then
	mkdir utils
fi
echo "./configure -enable-testbench --enable-imdiag --enable-imfile --enable-impstats --enable-imptcp --enable-mmanon --enable-mmaudit --enable-mmfields --enable-mmjsonparse --enable-mmpstrucdata --enable-mmsequence --enable-mmutf8fix --enable-mail --enable-omprog --enable-omruleset --enable-omstdout --enable-omuxsock --enable-pmaixforwardedfrom --enable-pmciscoios --enable-pmcisconames --enable-pmlastmsg --enable-pmsnare --enable-libgcrypt --enable-mmnormalize --disable-omudpspoof --enable-relp --disable-snmp --disable-mmsnmptrapd --enable-gnutls --enable-mysql --enable-mysql-tests --enable-usertools=no --enable-gt-ksi --enable-libdbi --enable-pgsql --enable-omhttpfs --enable-elasticsearch --enable-valgrind --enable-ommongodb --enable-omamqp1=no --enable-imjournal --enable-omjournal --enable-compile-warnings=yes" > utils/conf
chmod +x utils/conf

autoreconf -fvi && utils/conf && make  make -j2 || exit $?
