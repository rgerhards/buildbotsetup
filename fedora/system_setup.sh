echo "install a buildbot slave. The following environenment
variables need to be set:
BUILDBOT_NAME   name of this buildbot slave on master
BUILDBOT_PWD    its password to connect to master"

if [ "x$BUILDBOT_NAME" == "x" ]
then
    echo "error: BUILDBOT_NAME is not defined"
    exit 1
fi
if [ "x$BUILDBOT_PWD" == "x" ]
then
    echo "error: BUILDBOT_PWD is not defined"
    exit 1
fi

source envvars


sudo dnf -y install clang git valgrind libtool autoconf automake flex bison python-docutils python-sphinx json-c-devel libuuid-devel libgcrypt-devel zlib-devel openssl-devel libcurl-devel gnutls-devel mysql-devel postgresql-devel libdbi-dbd-mysql libdbi-devel net-snmp-devel systemd-devel libmongo-client-devel hiredis-devel qpid-proton-c-devel redhat-rpm-config python-devel

# some extras
sudo dnf -y install gvim

echo installing buildbot slave
sudo userdel buildbot &> /dev/null
sudo adduser --shell /bin/false  buildbot
# see http://unix.stackexchange.com/questions/56765/creating-an-user-without-a-password
rm -rf /tmp/buildbot-slave
mkdir /tmp/buildbot-slave
tar zxf ~/buildbotsetup/software/buildbot-slave.tar.gz -C /tmp/buildbot-slave
CURR_DIR=`pwd`
cd /tmp/buildbot-slave/*
python setup.py build
sudo python setup.py install

sudo rm -rf $BUILDBOT_DIR
sudo mkdir $BUILDBOT_DIR
cd $BUILDBOT_DIR
sudo buildslave create-slave slave $BUILDBOT_SERVER $BUILDBOT_NAME $BUILDBOT_PWD

echo "#!/bin/bash
cd $BUILDBOT_DIR
sudo -u buildbot buildslave \$1 slave" > /tmp/runslave.sh
sudo mv /tmp/runslave.sh runslave.sh
chmod +x runslave.sh
echo "Andre Lorbach <alorbach@adiscon.com>" >/tmp/admin
sudo mv /tmp/admin /var/lib/buildbot/slave/info


sudo chown -R buildbot $BUILDBOT_DIR

cd $CURR_DIR

echo "[Unit]
Description=Buildbot Slave
After=network.target

[Service]
ExecStart=$BUILDBOT_DIR/runslave.sh start
ExecStop=$BUILDBOT_DIR/runslave.sh stop
Type=forking

[Install]
WantedBy=multi-user.target" > /tmp/buildslave.service
sudo cp /tmp/buildslave.service /etc/systemd/system
./projects_setup.sh
