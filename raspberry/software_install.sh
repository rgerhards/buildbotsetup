sudo apt install -q -y \
     mysql-server \
     pkg-config \
     libtool \
     autoconf \
     autoconf-archive \
     autotools-dev \
     automake \
     python-docutils \
     pkg-config \
     libtool \
     gdb \
     valgrind \
     libdbi-dev \
     libsnmp-dev \
     libmysqlclient-dev \
     postgresql-client \
     libglib2.0-dev \
     libtokyocabinet-dev \
     zlib1g-dev \
     uuid-dev \
     libgcrypt11-dev \
     bison \
     flex \
     clang \
     libcurl4-gnutls-dev \
     python-docutils  \
     wget \
     libsystemd-dev \
     libhiredis-dev \
     librdkafka-dev  \
     libnet1-dev \
     libgrok1 libgrok-dev \
     faketime libdbd-mysql autoconf-archive
#     libczmq-dev \
# postgresql-server-dev-9.5 \
#     clang-4.0 \
#     libmongoc-dev \
#     libbson-dev \
#     libgnutls-dev \
# no longer required     libmongo-client-dev 
# openjdk-7-jdk

exit
# clang 5.0 - update when newer available!
sudo echo "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-5.0 main" > /etc/apt/sources.list.d/llvm.list
wget -O - http://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
sudo apt update
sudo apt install -q -y clang-5.0 lldb-5.0 lld-5.0

