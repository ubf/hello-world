%%% -*- mode: erlang -*-
%%%
%%% The MIT License
%%%
%%% Copyright (C) 2013-2016 by Joseph Wayne Norton <norton@alum.mit.edu>
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

-module(hello_world_sup).

-behaviour(supervisor).

%% External exports
-export([start_link/1]).

%% supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%%----------------------------------------------------------------------
%%% API
%%%----------------------------------------------------------------------
start_link(_Args) ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%%----------------------------------------------------------------------
%%% Callback functions from supervisor
%%%----------------------------------------------------------------------

init(Args) ->
    DefaultMaxConn = 10000,
    DefaultTimeout = 60000,
    DefaultPlugins = proplists:get_value(plugins, Args, [hello_world_plugin]),

    CUBF = case proplists:get_value(hello_world_tcp_port, Args, 0) of
               undefined ->
                   [];
               UBFPort ->
                   UBFMaxConn = proplists:get_value(hello_world_maxconn, Args, DefaultMaxConn),
                   UBFIdleTimer = proplists:get_value(hello_world_timeout, Args, DefaultTimeout),
                   UBFOptions = [{statelessrpc, true}
                                 , {startplugin, hello_world_plugin}
                                 , {serverhello, undefined}
                                 , {simplerpc,true}
                                 , {proto,ubf}
                                 , {maxconn, UBFMaxConn}
                                 , {idletimer, UBFIdleTimer}
                                 , {registeredname, hello_world_tcp_port}
                                ],
                   UBFServer =
                       {hello_world_server, {ubf_server, start_link, [hello_world, DefaultPlugins, UBFPort, UBFOptions]},
                        permanent, 2000, worker, [hello_world_server]},

                   [UBFServer]
           end,

    {ok, {{one_for_one, 2, 60}, CUBF}}.

%%%----------------------------------------------------------------------
%%% Internal functions
%%%----------------------------------------------------------------------
