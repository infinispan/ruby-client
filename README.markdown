# Infinispan Ruby Client

[Infinispan](http://www.jboss.org/infinispan) is a scalable, high-availability
data grid.  This is a native Ruby client implementation of Infinispan's [Hotrod
client/server protocol](http://community.jboss.org/docs/DOC-14421), allowing
Ruby applications to natively store and retrieve strings and Ruby objects in
the Infinispan data grid.


## Introduction

This is a [Level-1
client](http://community.jboss.org/wiki/HotRodProtocol#Client_Intelligence_1_byte),
meaning that it is a basic client and does not participate in the data grid
clustering.  The client currently only supports using the default cache, and
all operations of the Hot Rod protocol are implemented except the [server
stats](http://community.jboss.org/wiki/HotRodProtocol#stats_request)
request.  

## Installation

    $ gem install infinispan-ruby-client

## Usage

Using the infinispan-ruby-client requires that you connect to an Infinispan
server using the hotrod protocol.  

1) First start Infinispan, specifying hotrod for the protocol 

    $INFINISPAN_DIR/bin/startServer.sh -r hotrod

2) Then write code

    require 'infinispan-ruby-client'
    cache = Infinispan::RemoteCache.new => #<Infinispan::RemoteCache:0x100365a78 @name="", @host="localhost", @port=11222> 

    # Store and retrieve a string
    cache.put("Name", "Lance") => true 
    cache.get("Name") => "Lance" 

    # Store and retrieve a ruby object
    cache.put("Time", Time.now) => true
    time = cache.get("Time") => Tue Jun 07 17:45:17 -0400 2011
    time.class => Time


## Todo
* Support cache names 
* Add ping operation before any call
* Validate response headers
* Get server statistics
* Support for  lifespanSeconds and maxIdleTimeSeconds
* Support for intelligent clients and topologies, and listeners
* Configuration files support
* Transaction support 
* Support for Apache Avro Marshaller ??


## License
Copyright 2011 Red Hat, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.


