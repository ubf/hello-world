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
%%%

-module(hello_world_plugin).
-behaviour(ubf_plugin_stateless).

-include_lib("ubf/include/ubf.hrl").
-include_lib("ubf/include/ubf_plugin_stateless.hrl").

-export([info/0, description/0, keepalive/0]).
-export([moduleStart/1, moduleRestart/1]).
-export([handlerStart/1, handlerStop/3, handlerRpc/1]).

%% NOTE the following two lines
-compile({parse_transform,contract_parser}).
-add_contract("src/hello_world_plugin").

info() ->
    "I am a UBF server".

description() ->
    "A stateless server programmed by UBF".

keepalive() ->
    ok.

moduleStart(_Args) ->
    unused.

moduleRestart(Args) ->
    moduleStart(Args).

handlerStart(_Args) ->
    {accept,ok,start,undefined}.

handlerStop(_Pid,_Reason,undefined) ->
    undefine.

handlerRpc(Event)
  when Event==info; Event==description ->
    ?S(?MODULE:Event());
handlerRpc(Event)
  when Event==keepalive ->
    ?MODULE:Event();
handlerRpc(Event) ->
    Reply = Event,
    %% simply echo the request as the response
    Reply.

%%%----------------------------------------------------------------------
%%% Implementation functions
%%%----------------------------------------------------------------------
