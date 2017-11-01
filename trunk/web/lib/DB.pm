package DB;

use warnings;
use strict;

use Apache::DBI;
use DBI;
use Redis;
use Cfg;

BEGIN {
    use Exporter();
    our ( @ISA, @EXPORT );
    @ISA    = qw(Exporter);
    @EXPORT = qw($db $rdb);

    our $db = DBI->connect(
        "dbi:Pg:dbname=" . $cfg->{DB}->{n} . ";host=" . $cfg->{DB}->{h},
        $cfg->{DB}->{u},
        $cfg->{DB}->{p},
        { AutoCommit => 1 }
    );

    our $rdb = Redis->new();
    $rdb->connect( $cfg->{REDIS}->{host}, $cfg->{REDIS}->{port} );
    $rdb->select( $cfg->{REDIS}->{db} )

}

=pod

=encoding UTF-8

=head1 NAME

DB

=head1 DESCRIPTION

Global access to $db (DBI connection) and $rdb ( Redis connection)

=head1 SYNOPSIS

use DB;

$db->prepare("...");
$rdb->...

=head1 HISTORY

Окт 30 17:15:38 MSK 2017

=cut

1;

