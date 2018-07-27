export BUILDBOT_DIR=/var/lib/buildbot
export BUILDBOT_SERVER=build.rsyslog.com

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



sudo rm -rf $BUILDBOT_DIR
sudo mkdir $BUILDBOT_DIR
cd $BUILDBOT_DIR
echo buildslave create-slave slave $BUILDBOT_SERVER $BUILDBOT_NAME $BUILDBOT_PWD
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


sudo chown -R buildbot $BUILDBOT_DIR

cd $CURR_DIR

echo "[Unit]
Description=Buildbot Slave
After=network.target

[Service]
WorkingDirectory=$BUILDBOT_DIR
User=buildbot
PIDFile=$BUILDBOT_DIR/slave/twistd.pid
ExecStart=/usr/bin/bash -c \"buildslave start slave\"
ExecStop=/usr/bin/bash -c \"buildslave stop slave\"
Type=forking

[Install]
WantedBy=multi-user.target" > /tmp/buildslave.service

sudo mv /tmp/buildslave.service /etc/systemd/system
sudo systemctl enable buildslave.service

