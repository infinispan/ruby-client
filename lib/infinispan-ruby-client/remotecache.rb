require 'socket'

class RemoteCache
	attr_accessor :host, :port, :name

	def initialize( host="localhost", port=11222, name="" )
		@host = host
		@port = port
    @name = name
	end

  def get( key )
    connection = open_connection( HeaderBuilder.getHeader( GET[0].chr, @name ) )
    marshal( connection, key )
    response_header = read_response_header( connection )
    response_body_length = Unsigned.decodeVint( connection )
    response_body = connection.read( response_body_length )
    connection.close
    Marshal.load( response_body )
	end
	

	def put( key, value )
    connection = open_connection( HeaderBuilder.getHeader(PUT[0].chr, @name) )
    marshal( connection, key )
		connection.write [0x00.chr,0x00.chr]
    marshal( connection, value )
    response = read_response_header( connection )
    connection.close
    response
	end

  private
  def open_connection( header )
    socket = TCPSocket.open( @host, @port )
		socket.write( header )
    socket
  end

  def marshal( connection, obj )
		mkey = Marshal.dump( obj )
		connection.write( Unsigned.encodeVint( mkey.size ) )
    connection.write( mkey )
  end

  def read_response_header( connection )
    connection.read( 5 )
  end

end
