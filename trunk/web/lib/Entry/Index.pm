package Entry::Index;

use warnings;
use strict;

use DB;
use Req;
use Tpl qw/tpl/;
use Model::Auth;
use Digest::SHA1 qw(sha1_base64);
use Apache2::Const qw/OK NOT_FOUND HTTP_BAD_REQUEST HTTP_CONFLICT HTTP_EXPECTATION_FAILED/;

sub handler {
    my $r = shift; $r->content_type('text/html');

   ## $log->debug('Index handler. Uri ' . $r->uri());

    my %c = (
        '/'                 => *index{CODE},
        '/logout'           => *index{CODE},
        '/login'            => *index_login{CODE},
        '/register'         => *index_register{CODE},
        '/restore'          => *index_restore{CODE},
        '/restore_send'     => *index_restore_send{CODE},
        '/restore_pchange'  => *index_restore_send{CODE},
    );

    foreach my $e (keys %c){ if( (my @a=($r->uri()=~ /^$e$/) ) ){return &{$c{$e}}( $r, @a );}}

    return NOT_FOUND;
}

sub index {
    my $r = shift;
    tpl('index' => $r);
    return OK;
}

sub index_login {
    my $r = shift;
    tpl('login' => $r);
    return OK;
}

sub index_restore {
    my $r = shift;
    tpl('restore' => $r);
    return OK;
}

sub index_restore_pchange {
    my $r = shift;
    tpl('pchange' => $r);
    return OK;
}

sub index_restore_send {
    my $r = shift;
    tpl('restore' => $r);
    return OK;
}

sub index_register(){
    my $r = shift;
    my $a = Req::params($r);

    return HTTP_BAD_REQUEST unless $a->{httpd_username} or $a->{httpd_password};
    return HTTP_CONFLICT	if Model::Auth->load($a->{httpd_username}, 'username');

   ## $log->debug('Params httpd_username and httpd_password - OK');

    my $mod = Model::Auth->new({'username' => $a->{httpd_username}, 'passwd' => '{SHA}'.sha1_base64($a->{httpd_password}).'='});
    $mod->save();

    return HTTP_EXPECTATION_FAILED unless $mod;

   ## $log->debug('New user was added to DB.');

    return OK;
}

1;
