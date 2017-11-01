package Model;

use warning;
use strict;
use DB;

sub new {
    my ( $class, $arg ) = @_;
    my $self = {};

    if ( $arg->{ $class->_id } ) {
        $self = load( $class, $arg->{ $class->_id } );
    }
    else {
        bless $self, $class;
    }

    $self->set($arg);

    return $self;
}

sub load() {
    my ( $class, $val, $col ) = @_;

    return 0 unless $val;

    $col = $class->_id unless $col;

    my $self = ();
    $self = &_fetch_from_db( $class, $col, $val );

    return $self;
}

sub list {
    my ($class) = @_;

    my $module = "Model/$class.pm";

    require $module;

    my $h = $db->prepare( "SELECT " . $class->_id . " FROM " . $class->db_table() );
    $h->execute();
    my @b = ();

    while ( my ($id) = $h->fetchrow_array ) {
        push @b, $class->load($id);
    }

    return \@b;
}

sub list_where {
    my ( $class, $val, $col ) = @_;

    return 0 unless $val or $col;

    my $module = "Model/$class.pm";

    require $module;

    my $h = $db->prepare( "SELECT " . $class->_id . " FROM " . $class->db_table() . " WHERE $col = ?" );
    $h->execute($val);
    my @b = ();

    while ( my ($id) = $h->fetchrow_array ) {
        push @b, $class->load($id);
    }

    return \@b;
}

sub save {
    my $self = shift;
    $self->_store_in_db();
    return $self;
}

sub set {
    my ( $self, $arg ) = @_;

    foreach my $col ( $self->db_columns ) {

        if ( defined $arg->{$col} ) {
            $self->{$col} = $arg->{$col};
        }

    }

    return 1;
}

# fix for databases with TABLE_id as primary key instead id as primary key
sub _id {
    my ($class) = @_;

    if ( grep /^id$/, $class->db_columns() ) {
        return 'id';
    }
    else {
        return $class->db_table() . '_id';
    }

}

sub _fetch_from_db {
    my ( $cls, $col, $val ) = @_;

    my $h = $db->prepare('SELECT ' . join( ',', $cls->db_columns() ) . ' FROM ' . $cls->db_table() . ' WHERE ' . $col . ' = ? ' );
    $h->execute($val);
    my $obj = $h->fetchrow_hashref();

    if ($obj) {
        return bless $obj, $cls;
    }
    else {
        return 0;
    }

}

sub _store_in_db {
    my $self         = shift;
    my @binds        = ();
    my @keys         = ();
    my @keys_valuses = (); ## fix for PostgreSQL

    foreach my $key ( $self->db_columns ) {
        next unless defined $self->{$key};
        next if $key eq $self->_id;
        if ( $self->{"${key}NULL"} ) {
            push @keys,          "$key";
            push @keys_valuses,  '?';
            push @binds,          undef;
        }

        elsif ( $self->{$key} =~ /^[A-Z_]+\(.*\)$/ ) {
            push @keys, "$key";
        }
        elsif ( $self->{$key} ne '' ) {
            push @keys,          "$key";
            push @keys_valuses,  '?';
            push @binds,         $self->{$key};
        }
    }
    my $q = '';

    if ( $self->{ $self->_id } ) {
        $q = 'UPDATE ' . $self->db_table .' ( ' . join( ',', @keys ) .' ) VALUES  ( ' . join( ',', @keys_valuses ) .' ) WHERE ' . $self->_id . ' = ?';
        push @binds, $self->{ $self->_id };
    }
    else {
        $q = 'INSERT INTO ' . $self->db_table . ' ( ' . join( ',', @keys ) . ') VALUES ( ' . join( ',', @keys_valuses ) . ' ) ';
    }

    my $h = $db->prepare($q);
    $h->execute(@binds) or do { return 0; };
    $self->{ $self->_id } ||= $self->newid();

    #return 1;
}

sub newid {
    my $self = shift;
    return $db->{mysql_insertid} || $self->{ $self->_id };
}

1;

=pod

=encoding UTF-8

=head1 NAME

Model - the simplest ORM implementation.

=head1 DESCRIPTION

ORM implementation with full SQL syntax support.
Contain only methods needed for CRUD. No JOIN or UNION implementation inside.
Mostly old scool Perl coding style using.

=head1 EXAMPLES

=over 4

=item * Create

my $model = Model::FeedFileStat->new($args);
$model->save();

=item * Update

my $model = Model::FeedFileStat->load( $arg->{id}, 'id' );
$model->{channel_id} = $channel_id;
$model->save();

Or

my $model = Model::FeedFileStat->load( $arg->{id} );
$model->{channel_id} = $channel_id;
$model->save();


=item * Read

my $model = Model::FeedFileStat->load( $channel_id, 'channel_id' );
print Dumper($model);

=item * Read list.

print $_->{some_field} foreach ( @{ Model::FeedFileStat->list() } )

=item * Read inner list.

foreach ( @{ Model::FeedFileStat->list() } ){
print Dumper($_) foreach ( @{ $_->gaps() } );
}

=item * Delete.

my $model = Model::FeedFileStat->load( $arg->{id} );
$model->delete();

=back

=head1 BUGS

newid - return bad for MySQL.

=head1 TODO

=over 4

=item * _id

To finish smarter. It's fast fixme now

=item * ExtModel

Add ExtModel from Full version

=item * Replace

Add Replace from Full version

=back

=head1 SUPPORT

Bugs may be submitted through vanyabrovaru@gmail.com

=head1 AUTHORS

vanyabrovaru@gmail.com

=cut
