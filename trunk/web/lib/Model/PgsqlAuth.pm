package Model::PgsqlAuth;

use warnings;
use strict;

use Model;
our @ISA = qw/Model/;

sub db_table()   { 'pgsql_auth' }
sub db_columns() { qw/id passwd username groups/ }

1;

=pod

=encoding UTF-8

=head1 NAME

Model::PgsqlAuth

=head1 DESCRIPTION

Model::PgsqlAuth - Model of pgsql_auth table. Table with logins and passwords

=head1 SYNOPSIS

my $model = Model::PgsqlAuth->load($arg->{id});

print $model->{passwd};

=head1 HISTORY

Ноя  1 16:08:32 EET 2017

=cut
