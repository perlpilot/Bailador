#!/usr/bin/env perl6

use lib 'lib';
use Bailador;

get '/' => sub {
    content_type 'text/plain';
    join "\n", map { join "\t", .method.Str, .orig-path; }, app.routes;
}

get '/foo' => sub { }
get '/foo/bar' => sub { }
get post '/blah/:order' => sub { }
patch '/goober/:order' => sub { }

baile();
