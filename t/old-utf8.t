#!perl

use strict;
use warnings;

use utf8;

use Test::More tests => 5;
use URI;
use URI::URL;
use Encode qw/encode_utf8/;

$URI::COERCE_OCTETS = 0;

my $u;

$u = URI->new("http://r\xE9sum\xE9.example.org");
is $u->as_string, 'http://xn--rsum-bpad.example.org';

$u = URI::URL->new("ftp://anonymous:p%61ss\@h\xE5st:12345");
is $u->host, 'xn--hst-ula';
is $u->as_string, 'ftp://anonymous:pass@xn--hst-ula:12345';

$u = URI->new('http:');
$u->host('mooi€e.org');
is $u->host, 'xn--mooie-9l4b.org';

$u = URI->new('http:');
$u->host(encode_utf8('mooi€e.org'));
is $u->host, 'xn--mooie-qa80ayo.org';
