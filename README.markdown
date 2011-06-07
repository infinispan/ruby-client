# Hotrod Infinispan Ruby Client
This is a Ruby HotRod client for the JBoss Infinispan Data Grid.

## How to use it?

1) First start a HotRod Server module of Infinispan

    ./startServer.sh -r hotrod

2) Then write code

    require 'infinispan-ruby-client'
    cache = Infinispan::RemoteCache.new => #<Infinispan::RemoteCache:0x100365a78 @name="", @host="localhost", @port=11222> 
    cache.put("Name", "Lance") => true 
    cache.get("Name") => "Lance" 


# TODO
* Support cache names (needs to be decided by Infinispan Team)
* Add ping operation before any call
* Validate response headers
* Get server statistics
* Support for  lifespanSeconds and maxIdleTimeSeconds
* Support for Intelligence Clients and Topologies and Listener
* Configuration files support
* Transaction support # Not available in Infinispan as of version 4.1
* Support for Apache Avro Marshaller ??


# License
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


