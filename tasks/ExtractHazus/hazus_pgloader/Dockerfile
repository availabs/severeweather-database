FROM ubuntu:16.04

ARG PGLOADER_VERSION

RUN apt-get update

# freeTDS is a non-optional dependency
#   SEE:
#     ftp://ftp.freetds.org/pub/freetds/stable/
#     http://www.freetds.org/userguide/choosingtdsprotocol.htm
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl build-essential

RUN cd /opt/ \
  && curl ftp://ftp.freetds.org/pub/freetds/stable/freetds-1.00.91.tar.gz > freetds-1.00.91.tar.gz \
  && tar zxvf freetds-1.00.91.tar.gz \
  && cd /opt/freetds-1.00.91 \
  && ./configure --prefix=/usr/local --with-tdsver=7.4 \
  && make \
  && make install

# locales is a non-optional dependency
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y locales \
  && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
  && locale-gen

# Install SQL Server tools.
#   Note: the following line takes care of library dependencies needed for pgloader.
#   NOT OPTIONAL, even if you never directly use these tools.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --allow-unauthenticated sudo apt-transport-https software-properties-common curl \
  && add-apt-repository "$(curl https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2017.list)" \
  && add-apt-repository "$(curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list)" \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive ACCEPT_EULA='Y' apt-get install -y --allow-unauthenticated mssql-cli mssql-tools

# Build pgloader from source
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --allow-unauthenticated curl sbcl unzip libsqlite3-dev make curl gawk freetds-dev libzip-dev tzdata \
  && ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime \
  && dpkg-reconfigure --frontend noninteractive tzdata \
  && cd /opt/  \
  && curl -L "https://github.com/dimitri/pgloader/releases/download/v${PGLOADER_VERSION}/pgloader-bundle-${PGLOADER_VERSION}.tgz" \
    > "pgloader-bundle-${PGLOADER_VERSION}.tgz" \
  && tar zxvf "pgloader-bundle-${PGLOADER_VERSION}.tgz" \
  && cd "/opt/pgloader-bundle-${PGLOADER_VERSION}" \
  && make pgloader

RUN  DEBIAN_FRONTEND=noninteractive apt-get install -y postgresql-client
