package Entry::Hello;

use warnings;
use strict;

use Req;
use Apache2::Const qw/OK NOT_FOUND/;

sub handler {
    my $r = shift;
    $r->content_type('text/html');
    print "Hello world!";
    return OK;
}

1;
