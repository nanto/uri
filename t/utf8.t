#!perl

use strict;
use warnings;

use utf8;

use Test::More tests => 28;
use URI;
use URI::QueryParam;
use Encode qw/encode_utf8/;

my $u;

$u = URI->new('http://foobar/mooi€e');
is $u->as_string, 'http://foobar/mooi%E2%82%ACe';
ok !utf8::is_utf8($u->as_string);

$u = URI->new(encode_utf8('http://foobar/mooi€e'));
is $u->as_string, 'http://foobar/mooi%E2%82%ACe';
ok !utf8::is_utf8($u->as_string);

$u = URI->new('http:');
$u->query_form("mooi€e" => "mooi€e");
is $u->query, "mooi%E2%82%ACe=mooi%E2%82%ACe";
is scalar $u->query_param("mooi€e"), encode_utf8("mooi€e");
is scalar $u->query_param(encode_utf8("mooi€e")), encode_utf8("mooi€e");
ok !utf8::is_utf8(scalar $u->query_param(encode_utf8("mooi€e")));

$u = URI->new('http:');
$u->query_form(encode_utf8("mooi€e") => "mooi€e");
is $u->query, "mooi%E2%82%ACe=mooi%E2%82%ACe";
is scalar $u->query_param("mooi€e"), encode_utf8("mooi€e");
is scalar $u->query_param(encode_utf8("mooi€e")), encode_utf8("mooi€e");
ok !utf8::is_utf8(scalar $u->query_param(encode_utf8("mooi€e")));

$u = URI->new('http:');
$u->query_form("mooi€e" => encode_utf8("mooi€e"));
is $u->query, "mooi%E2%82%ACe=mooi%E2%82%ACe";
is scalar $u->query_param("mooi€e"), encode_utf8("mooi€e");
is scalar $u->query_param(encode_utf8("mooi€e")), encode_utf8("mooi€e");
ok !utf8::is_utf8(scalar $u->query_param(encode_utf8("mooi€e")));

$u = URI->new('http:');
$u->query_form(encode_utf8("mooi€e") => encode_utf8("mooi€e"));
is $u->query, "mooi%E2%82%ACe=mooi%E2%82%ACe";
is scalar $u->query_param("mooi€e"), encode_utf8("mooi€e");
is scalar $u->query_param(encode_utf8("mooi€e")), encode_utf8("mooi€e");
ok !utf8::is_utf8(scalar $u->query_param(encode_utf8("mooi€e")));

$u = URI->new('http://mooi€e.org/');
is $u->as_string, 'http://xn--mooie-9l4b.org/';
ok !utf8::is_utf8($u->as_string);

$u = URI->new(encode_utf8('http://mooi€e.org/'));
is $u->as_string, 'http://xn--mooie-9l4b.org/';
ok !utf8::is_utf8($u->as_string);

$u = URI->new('http:');
$u->host('mooi€e.org');
is $u->host, 'xn--mooie-9l4b.org';
ok !utf8::is_utf8($u->host);

$u = URI->new('http:');
$u->host(encode_utf8('mooi€e.org'));
is $u->host, 'xn--mooie-9l4b.org';
ok !utf8::is_utf8($u->host);
