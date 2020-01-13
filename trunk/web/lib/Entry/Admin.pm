package Entry::Admin;

use warnings;
use strict;

use Tpl qw/tpl/;
use Apache2::Const qw/OK FORBIDDEN/;
#use Credis;

sub handler {
    my $r = shift;
    $r->content_type('text/html');

    return FORBIDDEN unless $ENV{'REMOTE_USER'};

#    my $credis     = Credis->new( $ENV{REMOTE_USER} );
#    my $ttl        = $credis->ttl();
#    my $last_login = $credis->getset_expire(`date`, 7776000);

    my $ttl        = 10000;
    my $last_login = 32423423424;


    tpl( 'admin' => $r, 'user' => $ENV{REMOTE_USER} . ' ' . $last_login . ' (' . $ttl . ') '  );

    return OK;
}

1;
