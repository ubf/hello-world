%%% -*- mode: erlang -*-
%%%
%%% The MIT License
%%%
%%% Copyright (C) 2013 by Joseph Wayne Norton <norton@alum.mit.edu>
%%%
%%% Permission is hereby granted, free of charge, to any person obtaining a copy
%%% of this software and associated documentation files (the "Software"), to deal
%%% in the Software without restriction, including without limitation the rights
%%% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
%%% copies of the Software, and to permit persons to whom the Software is
%%% furnished to do so, subject to the following conditions:
%%%
%%% The above copyright notice and this permission notice shall be included in
%%% all copies or substantial portions of the Software.
%%%
%%% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
%%% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
%%% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
%%% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
%%% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
%%% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
%%% THE SOFTWARE.
%%%

-module(hello_world_example).

-export([setup/0, teardown/0, run/0]).

%%%-------------------------------------------------------------------
%%% API
%%%-------------------------------------------------------------------

setup() ->
    setup(hello_world).

teardown() ->
    teardown(hello_world).

run() ->
    Port = server_port(hello_world_tcp_port),
    Pid = client_connect("localhost", Port),
    try
        Request = ['hello-world'],
        {reply, Reply} = client_rpc(Pid, Request),
        if Reply =/= Request ->
                erlang:error(failed, [Request, Reply]);
           true ->
                Reply
        end
    after
        client_stop(Pid)
    end.

%%%-------------------------------------------------------------------
%%% Internal
%%%-------------------------------------------------------------------

setup(App) ->
    _ = application:start(sasl),
    _ = application:stop(App),
    ok = application:start(App),
    App.

teardown(App) ->
    _ = application:stop(App),
    ok.

server_port(Name) ->
    case proc_socket_server:server_port(Name) of
        Port when is_integer(Port) ->
            Port;
        _ ->
            timer:sleep(10),
            server_port(Name)
    end.

client_connect(Host, Port) ->
    Options = [{statelessrpc,true}, {serverhello,undefined}, {simplerpc,true}, {proto,ubf}],
    client_connect(Host, Port, Options).

client_connect(Host, Port, Options) ->
    client_connect(Host, Port, Options, infinity).

client_connect(Host, Port, Options, Timeout) ->
    {ok,Pid,_} = ubf_client:connect(Host, Port, Options, Timeout),
    Pid.

client_rpc(Pid, Args) ->
    client_rpc(Pid, Args, infinity).

client_rpc(Pid, Args, Timeout) ->
    ubf_client:rpc(Pid, Args, Timeout).

client_stop(Pid) ->
    ubf_client:stop(Pid).
