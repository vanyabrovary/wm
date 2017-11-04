package Entry::Admin;

use warnings;
use strict;

use Req;
use Logger;
use Tpl qw/tpl/;
use Apache2::Const qw/OK FORBIDDEN/;

sub handler {
    my $r = shift; $r->content_type('text/html');

    $log->debug('Admin handler. Uri ' . $r->uri());

    return FORBIDDEN unless $ENV{'REMOTE_USER'};

    tpl( 'admin' => $r, user => $ENV{'REMOTE_USER'} );

    return OK;
}

1;
