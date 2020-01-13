package Credis;

use warnings;
use strict;

use DB;

#$hour = 3600
#$day  = 86400
#$month = 2592000*3

sub new {
    my $class = shift;
    my $self = bless { key => shift || die('NO KEY SET!') }, $class;
    $self->val;
    return $self;
}

sub key {
    my $self = shift;
    unless ( $self->{_key} ) {
        if ( $self->{key}  ) {
            $self->{_key} = 'home:' . $self->{key};
        }
    }
    return $self->{_key};
}

sub incr {
    my $self = shift;
    $self->set(1) unless $self->val;
    return $rdb->incr( $self->key );

}

sub ttl {
    my $self = shift;
    $rdb->ttl( $self->key ) || 0;
}

sub val {
    my $self = shift;
    $rdb->get( $self->key ) || 0;
}

sub set {
    my $self = shift;
    my $val  = shift;

    die('NO VALUE SET!') unless $val;

    $rdb->del( $self->key );
    $rdb->set( $self->key => $val );
}

sub del {
    my $self = shift;
    $rdb->del( $self->key );
}


## reset value for key expire time
sub set_expire {
    my $self   = shift;

    my $val    = shift;
    my $expire = shift || $self->{expire};

    die('NO VALUE SET!') unless $val;

    $rdb->del( $self->key );
    $rdb->set( $self->key => $val );
    $rdb->expire( $self->key => $expire );
}

sub getset_expire {
    my $self   = shift;

    my $val    = shift;
    my $expire = shift || $self->{expire};

    die('NO VALUE FOR GETSET!') unless $val;

    my $getset_val = $rdb->getset( $self->key => $val );
    $rdb->expire( $self->key => $expire );

    return $getset_val;

}

=pod

=encoding UTF-8

=head1 NAME

Cfg

=head1 DESCRIPTION

Cfg - global access to redis wrapper

=head1 SYNOPSIS

use Credis;

my $obj = Credis->new();

=head1 HISTORY

Окт 31 19:48:38 MSK 2017

=cut

1;


