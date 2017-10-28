package Tpl;

use warnings;
use strict;

use Template;

use Cfg;

sub get_tpl(%);

sub get_tpl(%) {
    my %arg = {}; my ( $tpl, $req, $html ) = ( '', '', '' );

    $tpl = shift;
    $req = shift;
    %arg = @_;
    my $tt = Template->new( { INCLUDE_PATH => $ENV{'DOCUMENT_ROOT'} . '/html/tpl/' } ) or die "Tpl error!";

    $tt->process( $tpl . '.html', \%arg, \$html ) or do { die $tt->error(); return 0; };

    return $html;
}

=pod

=encoding UTF-8

=head1 NAME

Tpl

=head1 VERSION

0.1

=head1 DESCRIPTION

Tpl - simple TT implementation

=head1 SYNOPSIS

use Tpl;

print get_tpl('board_item');

=head1 HISTORY

Version 0.1: first release; Aug 2017

=cut

1;
