package Req;

use warnings;
use strict;

use Apache2::RequestRec();
use Apache2::Request();
use Apache2::RequestUtil();

sub params($);

sub params($) {
    my $r = shift or return;

    if (my $pargs = $r->pnotes('request-data')){
        return $pargs;
    }

    my $apr = Apache2::Request->new($r);
    my @key = $apr->param;
    my %arg = {};

    foreach my $k(@key){
        $arg{$k} = $r->method eq 'POST' ? $apr->body($k) : $apr->param($k);
    }

    $r->pnotes('request-data',\%arg);

    return \%arg;
}

1;

=pod

=encoding UTF-8

=head1 NAME

Req

=head1 DESCRIPTION

Get Apache2 http request params. Return hashref with params.

=head1 SYNOPSIS

use Req;

sub handler(){
    my $r = shift;
    my $a = Req::params($r);
    print Dumper($a);
}

=head1 HISTORY

Пнд Окт 30 16:42:54 MSK 2017

=cut
