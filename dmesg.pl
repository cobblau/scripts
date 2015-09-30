#!/usr/bin/perl -wn

# Convert dmesg's timstamp to human readable timestamp
# Usage:
#   dmesg | perl dmesg.pl

use strict;

foreach my $line (<>) {
    my ($uptime) = do { local @ARGV='/proc/uptime';<>}; ($uptime) = ($uptime =~ /^(\d+)\./);
    $line=~/^\[\s*(\d+)\.\d+\](.+)/;
    printf "[%s]%s\n", scalar localtime(time - $uptime + $1), $2;
}
