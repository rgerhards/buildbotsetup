source envvars

sudo dnf -y install git valgrind libtool autoconf automake flex bison python-docutils python-sphinx json-c-devel libuuid-devel libgcrypt-devel zlib-devel openssl-devel libcurl-devel gnutls-devel mysql-devel postgresql-devel libdbi-dbd-mysql libdbi-devel net-snmp-devel

# some extras
sudo dnf -y install gvim

./projects_setup.sh
