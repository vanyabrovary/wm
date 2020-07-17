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

LoadModule auth_basic_module  modules/mod_auth_basic.so

LoadModule auth_digest_module modules/mod_auth_digest.so

LoadModule authn_anon_module  modules/mod_authn_anon.so

LoadModule authn_core_module  modules/mod_authn_core.so

LoadModule authn_file_module  modules/mod_authn_file.so

LoadModule authn_dbd_module   modules/mod_authn_dbd.so

LoadModule authz_dbd_module   modules/mod_authz_dbd.so

LoadModule authz_core_module  modules/mod_authz_core.so

LoadModule authz_host_module  modules/mod_authz_host.so

LoadModule authz_owner_module modules/mod_authz_owner.so

LoadModule authz_user_module  modules/mod_authz_user.so

LoadModule cache_module       modules/mod_cache.so

LoadModule cache_disk_module  modules/mod_cache_disk.so

LoadModule deflate_module     modules/mod_deflate.so

LoadModule dir_module         modules/mod_dir.so

LoadModule env_module         modules/mod_env.so

LoadModule expires_module     modules/mod_expires.so

LoadModule ext_filter_module  modules/mod_ext_filter.so

LoadModule filter_module      modules/mod_filter.so

LoadModule headers_module     modules/mod_headers.so

LoadModule include_module     modules/mod_include.so

LoadModule log_config_module  modules/mod_log_config.so

LoadModule logio_module       modules/mod_logio.so

LoadModule mime_magic_module  modules/mod_mime_magic.so

LoadModule mime_module        modules/mod_mime.so

LoadModule negotiation_module modules/mod_negotiation.so

LoadModule remoteip_module    modules/mod_remoteip.so

LoadModule reqtimeout_module  modules/mod_reqtimeout.so

LoadModule setenvif_module    modules/mod_setenvif.so

LoadModule status_module      modules/mod_status.so

LoadModule suexec_module      modules/mod_suexec.so

LoadModule unixd_module       modules/mod_unixd.so

LoadModule vhost_alias_module modules/mod_vhost_alias.so

LoadModule mpm_prefork_module modules/mod_mpm_prefork.so

LoadModule perl_module        modules/mod_perl.so

LoadModule apreq_module       modules/mod_apreq2.so

LoadModule proxy_module       modules/mod_proxy.so

LoadModule proxy_fcgi_module  modules/mod_proxy_fcgi.so

LoadModule systemd_module     modules/mod_systemd.so

LoadModule macro_module       modules/mod_macro.so

LoadModule dbd_module         modules/mod_dbd.so

LoadModule authn_dbd_module   modules/mod_authn_dbd.so

LoadModule authz_dbd_module   modules/mod_authz_dbd.so

LoadModule auth_form_module   modules/mod_auth_form.so

