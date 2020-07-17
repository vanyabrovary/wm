Debian


apt-get install 
apache2 
apache2-bin 
apache2-data 
apache2-dev 
apache2-utils 
libapreq2-3 
libapache2-mod-perl2 
libapache2-mod-perl2-dev 
libapache2-mod-apreq2
libaprutil1-dbd-pgsql
libapache2-request-perl
libdigest-sha-perl
mcrypt
postgresql
postgresql-contrib 


CentOS7

yum install 
httpd
httpd-tools
mod_session
perl-libapreq2
httpd-devel
libapreq2-devel
mod_perl


Apache enabled modules 

LoadModule alias_module       modules/mod_alias.so

LoadModule authn_dbd_module   modules/mod_authn_dbd.so

LoadModule authz_dbd_module   modules/mod_authz_dbd.so

LoadModule perl_module        modules/mod_perl.so

LoadModule apreq_module       modules/mod_apreq2.so

LoadModule dbd_module         modules/mod_dbd.so

LoadModule authn_dbd_module   modules/mod_authn_dbd.so

LoadModule authz_dbd_module   modules/mod_authz_dbd.so

LoadModule auth_form_module   modules/mod_auth_form.so
