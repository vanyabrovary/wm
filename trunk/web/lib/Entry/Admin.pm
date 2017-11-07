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
    
    my $credis 		= Credis->new( $ENV{REMOTE_USER} );
    my $ttl 		= $credis->ttl();
    my $last_login 	= $credis->getset_expire(`date`, 7776000);
    
    tpl( 'admin' => $r, 'user' => $ENV{REMOTE_USER} . ' ' . $last_login . ' (' . $ttl . ') '  );

    return OK;
}

1;
