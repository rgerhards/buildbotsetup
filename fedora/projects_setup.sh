mkdir ~/proj
cd ~/proj
git clone https://github.com/rsyslog/libestr.git
cd libestr
git pull
autoreconf -fvi && ./configure && make || exit $?
sudo make install || exit $?

# libgt is currently no longer needed (GT has done its own dev pkg)
#cd ~/proj
#git clone https://github.com/rsyslog/libgt.git
#cd libgt
##git pull
#autoreconf -fvi && ./configure && make || exit $?
#sudo make install || exit $?

# nor is KSI any longer needed (see libgt)
#cd ~/proj
#git clone https://github.com/rsyslog/libksi
#cd libksi
#git pull
#autoreconf -fvi && ./configure && make || exit $?
#sudo make install || exit $?

cd ~/proj
git clone https://github.com/rsyslog/libfastjson.git
cd libfastjson
git pull
autoreconf -fvi && ./configure --disable-journal && make || exit $?
sudo make install || exit $?


cd ~/proj
git clone https://github.com/rsyslog/liblogging.git
cd liblogging
git pull
autoreconf -fvi && ./configure --disable-journal && make || exit $?
sudo make install || exit $?

cd ~/proj
git clone https://github.com/rsyslog/liblognorm.git
cd liblognorm
git pull
autoreconf -fvi && ./configure && make || exit $?
sudo make install || exit $?

cd ~/proj
git clone https://github.com/rsyslog/librelp.git
cd librelp
git pull
autoreconf -fvi && ./configure && make || exit $?
sudo make install || exit $?


### main project ###
# This is primarily built to make sure that the helper
# projects are correctly built and installed

cd ~/proj
git clone https://github.com/rsyslog/rsyslog.git
cd rsyslog
git pull
mkdir utils
echo "./configure -enable-testbench --enable-imdiag --enable-imfile --enable-impstats --enable-imptcp --enable-mmanon --enable-mmaudit --enable-mmfields --enable-mmjsonparse --enable-mmpstrucdata --enable-mmsequence --enable-mmutf8fix --enable-mail --enable-omprog --enable-omruleset --enable-omstdout --enable-omuxsock --enable-pmaixforwardedfrom --enable-pmciscoios --enable-pmcisconames --enable-pmlastmsg --enable-pmsnare --enable-libgcrypt --enable-mmnormalize --disable-omudpspoof --enable-relp --disable-snmp --disable-mmsnmptrapd --enable-gnutls --enable-mysql --enable-mysql-tests --enable-usertools=no --enable-libdbi --enable-pgsql --enable-omhttpfs --enable-elasticsearch --enable-valgrind --enable-ommongodb --enable-omamqp1 --enable-imjournal --enable-omjournal" > utils/conf
chmod +x utils/conf

autoreconf -fvi && utils/conf && make || exit $?
