mkdir ~/proj
cd ~/proj
git clone https://github.com/rsyslog/libestr.git
cd libestr
git pull
autoreconf -fvi && ./configure && make || exit $?
sudo make install || exit $?

cd ~/proj
git clone https://github.com/rsyslog/libgt.git
cd libgt
git pull
autoreconf -fvi && ./configure && make || exit $?
sudo make install || exit $?

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

cd ~/proj
git clone https://github.com/rsyslog/rsyslog.git
cd rsyslog
git pull
mkdir utils
echo "./configure " > utils/conf
chmod +x utils/conf

autoreconf -fvi && utils/conf && make || exit $?
