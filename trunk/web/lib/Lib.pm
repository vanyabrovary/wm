package Lib;

use warnings;
use strict;

use DB;
use Cfg;
use Credis;

sub new {
    my $class = shift;
    bless {}, $class;
}

sub db_user_count {
    my $self = shift;

   # my $h = $db->prepare("SELECT count(username) FROM pgsql_auth");
   # $h->execute();
   # my $cnt = $h->fetchrow_array;

   # return $cnt;
}

sub incr {
    my $self  = shift;
    my $redis = Credis->new( $cfg->{REDIS}->{host_key_incr} );
    return $redis->incr;
}






1;

