#
# Copyright 2011 Red Hat, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'socket'

module Infinispan
  class RemoteCache
    include Infinispan::Constants

    attr_accessor :host, :port, :name

    def initialize( host="localhost", port=11222, name="" )
      @host = host
      @port = port
      @name = name
    end

    def get( key )
      do_op( :operation => GET[0], :key => key )
    end
    
    def put( key, value )
      do_op( :operation => PUT[0], :key => key, :value => value )
    end

    def get_versioned( key )
      do_op( :operation => GET_WITH_VERSION[0], :key => key )
    end

    def contains_key?( key )
      do_op( :operation => CONTAINS[0], :key => key )
    end

    alias_method :contains_key, :contains_key?

    def contains_key?( key )
      self.contains_key( key )
    end

    def remove( key )
      do_op( :operation => REMOVE[0], :key => key )
    end

    private
    def do_op( options )
      options[:cache] ||= @name

      send_op    = Operation.send[ options[:operation] ]
      recv_op    = Operation.receive[ options[:operation] ]

      if (send_op && recv_op)
        TCPSocket.open( @host, @port ) do |connection|
          send_op.call( connection, options )
          recv_op.call( connection )
        end
      else
        raise "Unexpected operation: #{options[:operation]}"
      end

    end
  end

  module Operation

    include Infinispan::Constants
    include Infinispan::ResponseCode

    def self.send 
      {
        GET[0]                      => KEY_ONLY_SEND,
        GET_WITH_VERSION[0]         => KEY_ONLY_SEND,
        PUT[0]                      => KEY_VALUE_SEND,
        REMOVE[0]                   => KEY_ONLY_SEND,
        CONTAINS[0]                 => KEY_ONLY_SEND
      }
    end

    def self.receive 
      {
        GET[0]                      => KEY_ONLY_RECV,
        GET_WITH_VERSION[0]         => GET_WITH_VERSION_RECV,
        PUT[0]                      => BASIC_RECV,
        REMOVE[0]                   => BASIC_RECV,
        CONTAINS[0]                 => BASIC_RECV
      }
    end

    KEY_ONLY_SEND = lambda { |connection, options|
      connection.write( HeaderBuilder.getHeader(options[:operation], options[:cache]) )
      mkey = Marshal.dump( options[:key] )
      connection.write( Unsigned.encodeVint( mkey.size ) )
      connection.write( mkey )
    }

    KEY_VALUE_SEND = lambda { |connection, options|
      connection.write( HeaderBuilder.getHeader(options[:operation], options[:cache]) )
      mkey = Marshal.dump( options[:key] )
      connection.write( Unsigned.encodeVint( mkey.size ) )
      connection.write( mkey )
      connection.write [0x00.chr,0x00.chr]
      mkey = Marshal.dump( options[:value] )
      connection.write( Unsigned.encodeVint( mkey.size ) )
      connection.write( mkey )
    }

    KEY_ONLY_RECV = lambda { |connection|
      connection.read( 5 ) # The response header
      response_body_length = Unsigned.decodeVint( connection )
      response_body = connection.read( response_body_length )
      Marshal.load( response_body )
    }

    GET_WITH_VERSION_RECV = lambda { |connection|
      response_header = connection.read( 5 ) # The response header
      version = connection.read( 8 )
      response_body_length = Unsigned.decodeVint( connection )
      response_body = connection.read( response_body_length )
      # Unpack as a signed 64-bit int
      [ version.unpack("q").to_s, Marshal.load( response_body ) ]
    }

    BASIC_RECV = lambda { |connection|
      header = connection.read( 5 ) # Just the response header
      header[3] == SUCCESS
    }

  end
end
