package Entry::Register;

use latest;

use Req;
use Tpl qw/tpl/;
use Logger;
use Model::Auth;
use Digest::SHA1 qw(sha1_base64);
use Apache2::Const qw/OK NOT_FOUND HTTP_BAD_REQUEST HTTP_CONFLICT HTTP_EXPECTATION_FAILED/;
use Credis;

sub handler {
    my $r = shift; $r->content_type('text/html'); my $a = Req::params($r);

    if (exists $a->{httpd_username} and exists $a->{httpd_password}) {
    	$log->debug('register');

    	return HTTP_CONFLICT if Model::Auth->load($a->{httpd_username}, 'username');

    	my $mod = Model::Auth->new({
            'username' => $a->{httpd_username},
            'passwd'   => '{SHA}'.sha1_base64($a->{httpd_password}).'=',
            'created'  => 'NOW()',
            'status'   => 'register'
    	}); $mod->save();

        return HTTP_EXPECTATION_FAILED unless $mod;

        my $redis = Credis->new( 'confirm:'.sha1_base64( $mod->{id}.$mod->{username} ) );
        $redis->set_expire( $mod->{id} , 7200);

        $log->debug('New user was added to DB.');

        return OK;
    }

    elsif( $a->{key} ) {

	    $log->debug('confirm');

        my $redis = Credis->new( 'confirm:' . $a->{key} );

	    $log->debug('confirm request not found') unless $redis->val;

	    return NOT_FOUND unless $redis->val;

	    my $mod   = Model::Auth->load( $redis->val );

	    if($mod->{id} and $a->{key} eq sha1_base64( $mod->{id} . $mod->{username} )){

	        $mod->{status} =  'active';
	        $mod->save();
            $redis->del;
            $log->debug('active now');
	        return OK;
	   }

	   $log->debug('user not found');

    }


    return NOT_FOUND;
}
