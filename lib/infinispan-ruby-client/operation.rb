class Operation
  attr_accessor :header
  def initialize(rm)
    @remotecache=rm
  end
  
  def perform(*params)
    if(params.size>=2)
      perform_with_key_value(params[0],params[1])
    else
      perform_with_key(params[0])
    end
  end
  
  def perform_with_key key
    s=TCPSocket.open(@remotecache.host, @remotecache.port)
		##Send Header
		s.write @header
		##Send Body
		mkey=Marshal.dump(key)
		s.write Unsigned.encodeVint(mkey.size)
		#s.putc mkey.size
		s.write mkey
		#Handle response
		rspHeader = s.read(5)
#		puts "Header " + rspHeader.unpack('c*').to_s
		rspBodyValueLengh = Unsigned.decodeVint(s)
#		puts "Value Lenght " + rspBodyValueLengh.to_s
		rspBodyValue = s.read(rspBodyValueLengh)
		mrspBodyValue = Marshal.load(rspBodyValue)
		s.close
		mrspBodyValue
  end
  
  def perform_with_key_value key, value
    s=TCPSocket.open(@remotecache.host, @remotecache.port)
		##Send Header
		s.write @header
		##Send Body
		mkey=Marshal.dump(key)
		s.write Unsigned.encodeVint(mkey.size)
  
#		puts "AAAA1 " + mkey.size.to_s + Unsigned.encodeVint(mkey.size).to_s
		s.write mkey
		s.write [0x00.chr,0x00.chr]
		mvalue=Marshal.dump(value)
		s.write Unsigned.encodeVint(mvalue.size)
		#s.putc mvalue.size
#		puts "AAAA2 " + mvalue.size.to_s
		s.write mvalue
		#Handle response
		rspHeader = s.read(5)
#		puts "Header " + rspHeader.unpack('c*').to_s
		s.close
  end
end