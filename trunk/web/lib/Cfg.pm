package Cfg;

use warnings;
use strict;

use Exporter();

use Config::Tiny;

BEGIN {
    our @ISA    = qw( Exporter );
    our @EXPORT = qw( $cfg );

    our $cfg = Config::Tiny->read( $ENV{'DOCUMENT_ROOT'} . '/etc/my.ini' ) or die 'Cant open etc/my.ini';
}

=pod

=encoding UTF-8

=head1 NAME

Cfg

=head1 VERSION

0.1

=head1 DESCRIPTION

Cfg - global access to $cfg

=head1 SYNOPSIS

use Cfg;

print $cfg->{DB}->{n};

=head1 HISTORY

Version 0.1: first release; Aug 2017

=cut

1;
