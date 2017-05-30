use v6;
use Test;
use Bailador::Test;

plan 7;

my $app = EVALFILE "examples/app.pl6";

subtest {
    plan 2;
    my %data = run-psgi-request($app, 'GET', '/');
	is-deeply %data<response>, [302, ["Content-Type" => "text/html", :Location("/index.html")], "Not found"], 'route GET /';
    is %data<err>, '';
}, '/';

subtest {
	plan 2;
	my %data = run-psgi-request($app, 'GET', '/die');
	is-deeply %data<response>, [500, ["Content-Type" => "text/html, charset=utf-8"], 'Internal Server Error'], 'route GET /die dies';
    like %data<err>, rx:s/This is an exception so you can see how it is handled/, 'stderr';
}, '/die';

subtest {
    plan 2;
    my %data = run-psgi-request($app, 'GET', '/about');
	is-deeply %data<response>, [200, ["Content-Type" => "text/html"], 'about me'], 'route GET /about';
    is %data<err>, '';
}, '/about';

subtest {
    plan 2;
    my %data = run-psgi-request($app, 'GET', '/hello/Foo');
	is-deeply %data<response>, [200, ["Content-Type" => "text/html"], 'Hello Foo!'], 'route GET /hello/Foo';
    is %data<err>, '';
}, '/hello/Foo';

subtest {
    plan 2;
    my %data = run-psgi-request($app, 'GET', '/foo-and-more');
	is-deeply %data<response>, [200, ["Content-Type" => "text/html"], 'regexes! I got -and-more'], 'route GET /foo-and-more';
    is %data<err>, '';
}, '/foo-and-more';

subtest {
    plan 2;
    my %data = run-psgi-request($app, 'GET', '/foo/and/more');
	is-deeply %data<response>, [200, ["Content-Type" => "text/html"], 'regexes! I got /and/more'], 'route GET /foo/and/more';
    is %data<err>, '';
}, '/foo/and/more';


subtest {
    plan 2;
    my %data = run-psgi-request($app, 'GET', '/two-parts');
	is-deeply %data<response>, [200, ["Content-Type" => "text/html"], 'two and parts'], 'route GET /two-parts';
    is %data<err>, '';
}, '/two-parts';

#subtest {
#    plan 2;
#    my %data = run-psgi-request($app, 'GET', '/template/Camelia');
#	is-deeply %data<response>, [200, ["Content-Type" => "text/html"], ''], 'route GET /template/Camelia';
#    is %data<err>, '';
#}, '/template/Camelia';




# vim: expandtab
# vim: tabstop=4
