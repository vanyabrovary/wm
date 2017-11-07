package Tpl;

use warnings;
use strict;

use Req;

use Template;
use Cfg;
use Lib;

use Apache2::RequestRec();

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

    $tt = Template->new({ INCLUDE_PATH => $ENV{'DOCUMENT_ROOT'} . $cfg->{PATH}->{tpl} }) or die "Tpl error!";
    $tt->process($tpl . '.html', \%arg, \$html) or do { die $tt->error(); return 0; };

    $req->headers_out->set('Content-Length' => length($html));
    print $html;
    #  print $html;
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
