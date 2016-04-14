set -v
#set -x
if [ ! -e ~/proj ]; then
    mkdir ~/proj
fi
cd ~/proj

if [ ! -e libestr ]; then
	git clone https://github.com/rsyslog/libestr.git
fi
cd libestr
git pull
autoreconf -fvi && ./configure && make || exit $?
sudo make install || exit $?

cd ~/proj
if [ ! -e libgt ]; then
	git clone https://github.com/rsyslog/libgt.git
fi
cd libgt
git pull
autoreconf -fvi && ./configure && make || exit $?
sudo make install || exit $?

cd ~/proj
if [ ! -e libksi ]; then
	git clone https://github.com/rsyslog/libksi
fi
cd libksi
git pull
autoreconf -fvi && ./configure && make || exit $?
sudo make install || exit $?

cd ~/proj
if [ ! -e libfastjson ]; then
	git clone https://github.com/rsyslog/libfastjson.git
fi
cd libfastjson
git pull
autoreconf -fvi && ./configure && make || exit $?
sudo make install || exit $?


cd ~/proj
if [ ! -e liblogging ]; then
	git clone https://github.com/rsyslog/liblogging.git
fi
cd liblogging
git pull
autoreconf -fvi && ./configure --disable-journal && make || exit $?
sudo make install || exit $?

cd ~/proj
if [ ! -e liblognorm ]; then
	git clone https://github.com/rsyslog/liblognorm.git
fi
cd liblognorm
git pull
autoreconf -fvi && ./configure && make || exit $?
sudo make install || exit $?

cd ~/proj
if [ ! -e librelp ]; then
	git clone https://github.com/rsyslog/librelp.git
fi
cd librelp
git pull
autoreconf -fvi && ./configure && make || exit $?
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
echo "./configure -enable-testbench --enable-imdiag --enable-imfile --enable-impstats --enable-imptcp --enable-mmanon --enable-mmaudit --enable-mmfields --enable-mmjsonparse --enable-mmpstrucdata --enable-mmsequence --enable-mmutf8fix --enable-mail --enable-omprog --enable-omruleset --enable-omstdout --enable-omuxsock --enable-pmaixforwardedfrom --enable-pmciscoios --enable-pmcisconames --enable-pmlastmsg --enable-pmsnare --enable-libgcrypt --enable-mmnormalize --disable-omudpspoof --enable-relp --disable-snmp --disable-mmsnmptrapd --enable-gnutls --enable-mysql --enable-mysql-tests --enable-usertools=no --enable-gt-ksi --enable-libdbi --enable-pgsql --enable-omhttpfs --enable-elasticsearch --enable-valgrind --enable-ommongodb --enable-omamqp1 --enable-imjournal --enable-omjournal" > utils/conf
chmod +x utils/conf

autoreconf -fvi && utils/conf && make || exit $?
