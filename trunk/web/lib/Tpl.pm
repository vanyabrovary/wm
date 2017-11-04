package Tpl;

use warnings;
use strict;

use Template;
use Cfg;

use Credis;
use Lib;

BEGIN {
    use Exporter();
    our ( @ISA, @EXPORT );
    @ISA    = qw(Exporter);
    @EXPORT = qw(tpl);
}

sub tpl(%);

sub tpl(%) {
    my ($tpl, $req, $html, $tt) = ('', '', '', ''); 	## cleaning for mod_perl
    my %arg = (); 					## cleaning for mod_perl

    ($tpl, $req, %arg) = @_;


    $arg{lib} = Lib->new();


    $tt = Template->new({ INCLUDE_PATH => $ENV{'DOCUMENT_ROOT'} . $cfg->{PATH}->{tpl} })
        or die "Tpl error!";


    $tt->process($tpl . '.html', \%arg, \$html)
        or do { die $tt->error(); return 0; };


    my $redis = Credis->new( $cfg->{REDIS}->{host_key_incr} );

    print $html . '<h5>А я тут считаю открытия страниц: ' . $redis->incr . '</h5>';

    return 1;
}

=pod

=encoding UTF-8

=head1 NAME

Tpl

=head1 DESCRIPTION

Tpl - simple TT implementation

=head1 SYNOPSIS

use Tpl;

print Tpl::get_tpl('board_item');

=head1 HISTORY

Окт 30 17:14:17 MSK 2017

=cut

1;
