include $(PQ_FACTORY)/factory.mk

pq_part_name := net-snmp-5.7.3
pq_part_file := $(pq_part_name).tar.gz

pq_net_snmp_configuration_flags += --prefix=$(part_dir)
pq_net_snmp_configuration_flags += --sbindir=$(part_dir)/sbin
pq_net_snmp_configuration_flags += --with-defaults
pq_net_snmp_configuration_flags += --disable-embedded-perl
pq_net_snmp_configuration_flags += --without-perl-modules
pq_net_snmp_configuration_flags += --with-default-snmp-version=3
pq_net_snmp_configuration_flags += --with-sys-contact=@@no.where
pq_net_snmp_configuration_flags += --with-sys-location=""
pq_net_snmp_configuration_flags += --with-logfile="none"
pq_net_snmp_configuration_flags += --with-persistent-directory=/var/snmpd
pq_net_snmp_configuration_flags += --with-openssl=$(pq-openssl-dir)

build-stamp: stage-stamp
	$(MAKE) -j1 -C $(pq_part_name) mkinstalldirs=$(part_dir)
	$(MAKE) -j1 -C $(pq_part_name) mkinstalldirs=$(part_dir) DESTDIR=$(stage_dir) install
	touch $@

stage-stamp: configure-stamp

configure-stamp: patch-stamp
	cd $(pq_part_name) && ./configure $(pq_net_snmp_configuration_flags)
	touch $@

patch-stamp: unpack-stamp
	touch $@

unpack-stamp: $(pq_part_file)
	tar xf $(source_dir)/$(pq_part_file)
	touch $@
