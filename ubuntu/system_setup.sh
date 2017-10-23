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




sudo add-apt-repository ppa:qpid/released -y
sudo apt-get update -q -y
sudo apt-get install -q -y  \
     mysql-server \
     pkg-config \
     libtool \
     autoconf \
     autoconf-archive \
     autotools-dev \
     automake \
     libtool \
     gdb \
     valgrind \
     libdbi-dev \
     libzcmq-dev \
     libsnmp-dev \
     libmysqlclient-dev \
     postgresql-client postgresql-server-dev-9.5 \
     libglib2.0-dev \
     libtokyocabinet-dev \
     zlib1g-dev \
     uuid-dev \
     libgcrypt11-dev \
     bison \
     flex \
     libcurl4-gnutls-dev \
     python-docutils  \
     wget \
     libgnutls-dev \
     libsystemd-dev \
     libhiredis-dev \
     librdkafka-dev  \
     libgrok1 libgrok-dev \
     faketime libdbd-mysql libmongo-client-dev autoconf-archive
# openjdk-7-jdk




# some extras
sudo apt-get install -y install gvim

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

# note: the following script is NOT needed for systemd deployments!
# but we still generate it as convenience for operators
echo "#!/bin/bash
cd $BUILDBOT_DIR
sudo -u buildbot buildslave \$1 slave" > /tmp/runslave.sh
sudo mv /tmp/runslave.sh runslave.sh
chmod +x runslave.sh
echo "Andre Lorbach <alorbach@adiscon.com>" >/tmp/admin
sudo mv /tmp/admin /var/lib/buildbot/slave/info

# systemd steals our core dumps, so let us correct this...
sudo bash -c "echo \"core\" > /proc/sys/kernel/core_pattern"

sudo chown -R buildbot $BUILDBOT_DIR

cd $CURR_DIR

echo "[Unit]
Description=Buildbot Slave
After=network-online.target

[Service]
WorkingDirectory=$BUILDBOT_DIR
User=buildbot
PIDFile=$BUILDBOT_DIR/slave/twistd.pid
ExecStart=/usr/bin/bash -c \"buildslave start slave\"
ExecStop=/usr/bin/bash -c \"buildslave stop slave\"
Type=forking
Restart=always

[Install]
Wants=network-online.target
WantedBy=multi-user.target" > /tmp/buildslave.service
sudo mv /tmp/buildslave.service /etc/systemd/system
sudo systemctl enable buildslave.service

#./projects_setup.sh
