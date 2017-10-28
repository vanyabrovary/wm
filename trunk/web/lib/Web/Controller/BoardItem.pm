package Web::Controller::BoardItem;

use warnings;
use strict;

use Mojo::Base 'Mojolicious::Controller';
use Tpl;

sub index {
    my $self = shift;
    $self->render( data => Tpl::get_tpl('index') );
}


################################################################################################################ FOR TO DO
#use DBI;
#use Digest::SHA qw(sha1_base64);
#my $user = shift or &help();
#my $pass = shift or &help();
#$pass = '{SHA}'.sha1_base64($pass).'=';
#my $db = DBI->connect("dbi:Pg:dbname=apacheauth;host=127.0.0.1", 'apache', 'ooo', {AutoCommit => 1});
#my $h = $db->prepare("SELECT passwd FROM pgsql_auth WHERE username = ? AND passwd = ?");
#$h->execute($user,$pass);
#my $itm =  $h->fetchrow_hashref;
#die($itm->{passwd}) if $itm;
#$h = $db->prepare("INSERT INTO pgsql_auth (username, passwd) VALUES (?, ?)");
#$h->execute($user, $pass);
#sub help { die("\nUsage:\n\t ./pass.pl <user> <pass> \n\n");}
################################################################################################################

1;
