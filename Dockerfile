FROM telegraf:latest

RUN echo "deb http://ftp.us.debian.org/debian bookworm main non-free" >> /etc/apt/sources.list \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
  iputils-ping \
  snmp \
  procps \
  snmp-mibs-downloader \
  unzip \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /etc/apt/sources.list.d/* \
  &&curl -sL https://global.download.synology.com/download/Document/MIBGuide/Synology_MIB_File.zip -o Synology_MIB_File.zip \
  && unzip -j -d /usr/share/snmp/mibs Synology_MIB_File.zip \
  && rm -rf Synology_MIB_File.zip \
  && echo mibdirs +/usr/share/snmp/mibs >> /etc/snmp/snmp.conf

COPY telegraf.conf /etc/telegraf/telegraf.conf