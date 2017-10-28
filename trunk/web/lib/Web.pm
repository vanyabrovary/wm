package Web;

use warnings;
use strict;

use Mojo::Base 'Mojolicious';

sub startup {
    my $self = shift;
    my $r    = $self->routes;
    $r->any('/')->to( controller => 'BoardItem', action => 'index' );
}

=pod

=encoding UTF-8

=head1 NAME

Web

=head1 VERSION

0.1

=head1 DESCRIPTION

Web - startup for Mojolicious routes

=head1 HISTORY

Version 0.1: first release; Aug 2017

=cut

1;
