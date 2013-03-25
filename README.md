

#Hello World Example for Universal Binary Format#


Copyright (c) 2013 by Joseph Wayne Norton

__Authors:__ Joseph Wayne Norton ([`norton@alum.mit.edu`](mailto:norton@alum.mit.edu)).<p>This is an Erlang/OTP application whose only purpose is to serve as a
simple "Hello World" example for the UBF framework.</p>
<p>This application contains the following components:</p>
<ul>
<li>
<p>
application
</p>
</li>
<li>
<p>
supervisor
</p>
</li>
<li>
<p>
UBF server and client
</p>
</li>
<li>
<p>
UBF "hello world" contract and plugin implementation
</p>
</li>
</ul>
<p>To download, build, and test the hellow_word application in one shot,
please follow this recipe:</p>


<pre><code>$ mkdir working-directory-name
$ cd working-directory-name
$ git clone https://github.com/ubf/hello-world.git hello_world
$ cd hello_world
$ make deps clean compile test</code></pre>

<p>To test the hellow_world application manually, please follow this
recipe after completing the above steps:</p>


<pre><code>$ mkdir working-directory-name
$ cd working-directory-name
$ cd hello_world
$ make
$ (cd ebin; erl -pz ../deps/ubf/ebin)
Erlang R16B (erts-5.10.1) [source] [64-bit] [smp:2:2] [async-threads:10] [hipe] [kernel-poll:false]

Eshell V5.10.1  (abort with ^G)
1> hello_world_example:setup().

=PROGRESS REPORT==== 25-Mar-2013::17:15:42 ===
          supervisor: {local,sasl_safe_sup}
             started: [{pid,<0.41.0>},
                       {name,alarm_handler},
                       {mfargs,{alarm_handler,start_link,[]}},
                       {restart_type,permanent},
                       {shutdown,2000},
                       {child_type,worker}]

=PROGRESS REPORT==== 25-Mar-2013::17:15:42 ===
          supervisor: {local,sasl_safe_sup}
             started: [{pid,<0.42.0>},
                       {name,overload},
                       {mfargs,{overload,start_link,[]}},
                       {restart_type,permanent},
                       {shutdown,2000},
                       {child_type,worker}]

=PROGRESS REPORT==== 25-Mar-2013::17:15:42 ===
          supervisor: {local,sasl_sup}
             started: [{pid,<0.40.0>},
                       {name,sasl_safe_sup},
                       {mfargs,
                           {supervisor,start_link,
                               [{local,sasl_safe_sup},sasl,safe]}},
                       {restart_type,permanent},
                       {shutdown,infinity},
                       {child_type,supervisor}]

=PROGRESS REPORT==== 25-Mar-2013::17:15:42 ===
          supervisor: {local,sasl_sup}
             started: [{pid,<0.43.0>},
                       {name,release_handler},
                       {mfargs,{release_handler,start_link,[]}},
                       {restart_type,permanent},
                       {shutdown,2000},
                       {child_type,worker}]

=PROGRESS REPORT==== 25-Mar-2013::17:15:42 ===
         application: sasl
          started_at: nonode@nohost

=PROGRESS REPORT==== 25-Mar-2013::17:15:42 ===
          supervisor: {local,hello_world_sup}
             started: [{pid,<0.49.0>},
                       {name,hello_world_server},
                       {mfargs,
                           {ubf_server,start_link,
                               [hello_world,
                                [hello_world_plugin],
                                0,
                                [{statelessrpc,true},
                                 {startplugin,hello_world_plugin},
                                 {serverhello,undefined},
                                 {simplerpc,true},
                                 {proto,ubf},
                                 {maxconn,10000},
                                 {idletimer,60000},
                                 {registeredname,hello_world_tcp_port}]]}},
                       {restart_type,permanent},
                       {shutdown,2000},
                       {child_type,worker}]

=PROGRESS REPORT==== 25-Mar-2013::17:15:42 ===
         application: hello_world
          started_at: nonode@nohost
hello_world
2> hello_world_example:run().

=PROGRESS REPORT==== 25-Mar-2013::17:15:47 ===
          supervisor: {local,inet_gethost_native_sup}
             started: [{pid,<0.55.0>},{mfa,{inet_gethost_native,init,[[]]}}]

=PROGRESS REPORT==== 25-Mar-2013::17:15:47 ===
          supervisor: {local,kernel_safe_sup}
             started: [{pid,<0.54.0>},
                       {name,inet_gethost_native_sup},
                       {mfargs,{inet_gethost_native,start_link,[]}},
                       {restart_type,temporary},
                       {shutdown,1000},
                       {child_type,worker}]
['hello-world']
3> hello_world_example:teardown().

=INFO REPORT==== 25-Mar-2013::17:15:52 ===
    application: hello_world
    exited: stopped
    type: temporary
ok
4> erlang:halt().</code></pre>


<h2 id="_what_is_ubf">What is UBF?</h2>

<p>UBF is the "Universal Binary Format", designed and implemented by Joe
Armstrong.  UBF is a language for transporting and describing complex
data structures across a network.  It has three components:</p>
<ul>
<li>
<p>
UBF(a) is a "language neutral" data transport format, roughly
  equivalent to well-formed XML.
</p>
</li>
<li>
<p>
UBF(b) is a programming language for describing types in UBF(a) and
  protocols between clients and servers.  This layer is typically
  called the "protocol contract".  UBF(b) is roughly equivalent to
  Verified XML, XML-schemas, SOAP and WDSL.
</p>
</li>
<li>
<p>
UBF(c) is a meta-level protocol used between a UBF client and a UBF
  server.
</p>
</li>
</ul>
<p>See <a href="http://ubf.github.com/ubf">http://ubf.github.com/ubf</a> for further details.</p>




##Modules##


<table width="100%" border="0" summary="list of modules">
<tr><td><a href="https://github.com/ubf/hello-world/blob/master/doc/hello_world_app.md" class="module">hello_world_app</a></td></tr>
<tr><td><a href="https://github.com/ubf/hello-world/blob/master/doc/hello_world_example.md" class="module">hello_world_example</a></td></tr>
<tr><td><a href="https://github.com/ubf/hello-world/blob/master/doc/hello_world_plugin.md" class="module">hello_world_plugin</a></td></tr>
<tr><td><a href="https://github.com/ubf/hello-world/blob/master/doc/hello_world_sup.md" class="module">hello_world_sup</a></td></tr></table>

