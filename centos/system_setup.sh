yum -y update
yum -y install \
	autoconf \
	autoconf-archive \
	automake \
	bison \
	clang \
	clang-analyzer \
	libstdc++ \
	compat-libstdc++-33 \
	curl \
	cyrus-sasl-devel \
	cyrus-sasl-lib \
	flex \
	gcc \
	gcc-c++ \
	gdb \
	git \
	gnutls-devel \
	hiredis-devel \
	java-1.8.0-openjdk \
	java-1.8.0-openjdk-devel \
	libcurl-devel \
	libdbi-dbd-mysql \
	libdbi-devel \
	libfaketime \
	libgcrypt-devel \
	libmaxminddb-devel \
	libnet libnet-devel \
	libstdc++ \
	libtool \
	libuuid-devel \
	lsof \
	mysql-devel \
	nc \
	net-snmp-devel \
	net-tools \
	openssl-devel \
	postgresql-devel \
	python-devel \
	python-docutils \
	python-sphinx \
	qpid-proton-c-devel \
	redhat-rpm-config \
	snappy-devel \
	sudo \
	systemd-devel \
	tcl-devel \
	valgrind \
	wget \
	yum -y install \
	zlib-devel

yum -y install epel-release
yum -y install \
	czmq-devel \
	hiredis \
	hiredis-devel \
	libmaxminddb \
	libmaxminddb-devel \
	mongo-c-driver \
	mongo-c-driver-devel

yum -y install  \
   python-dev \
   python-pip

pip install buildbot-worker buildbot-slave

groupadd -r buildbot
useradd -r -g buildbot buildbot
usermod -aG systemd-journal buildbot

mkdir /worker && chown buildbot:buildbot /worker
