package Entry::Index;

use warnings;
use strict;

use Tpl             qw/tpl/;
use Digest::SHA1    qw(sha1_base64);
use Apache2::Const  qw/OK NOT_FOUND HTTP_BAD_REQUEST/;
use modules         qw(DB Req Logger Model::PgsqlAuth);

sub handler {
    my $r = shift; $r->content_type('text/html');

    $log->debug('Index handler. Uri ' . $r->uri());

    my %c = (
        '/'         => *index{CODE},
        '/logout'   => *index{CODE},
        '/login'    => *index_login{CODE},
        '/register' => *index_register{CODE},
    );

    foreach my $e (keys %c){ if( (my @a=($r->uri()=~ /^$e$/) ) ){return &{$c{$e}}( $r, @a );}}

    return NOT_FOUND;
}

sub index {
    my $r = shift;
    $log->debug('sub index');
    tpl('index' => $r);
    return OK;
}

sub index_login {
    my $r = shift;
    $log->debug('sub index_login');
    tpl('login' => $r);
    return OK;
}


sub index_register(){
    my $r = shift;
    my $a = Req::params($r);

    $log->debug('sub index_register');

    return HTTP_BAD_REQUEST unless $a->{httpd_username} or $a->{httpd_password};

    $log->debug('Params httpd_username and httpd_password - OK');

    my $mod = Model::PgsqlAuth->new({'username' => $a->{httpd_username}, 'passwd'   => '{SHA}'.sha1_base64($a->{httpd_password}).'='});
    $mod->save();

    $log->debug('New user was added to DB.');

    return OK;
}

1;
