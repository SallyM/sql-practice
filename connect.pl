#!usr/bin/perl
# connect.pl: connect to the MySQL server

use strict;
use warnings;
use DBI;


my $dsn = "DBI:mysql:host=localhost;database=cookbook";
my $dbh = DBI->connect ($dsn, "sally", "sallypass")
	     or die "Cannot connect to server\n";

print "Connected\n";
$dbh->disconnect ();
print "Disconnected\n";
