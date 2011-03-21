require 'socket'

#TODO Add support for Cachename and ConfigFile (Yaml or current XML)
class RemoteCache
	attr_accessor :host, :port

	def initialize host='localhost',port=11222
		@host = host
		@port = port
	end

  def get key
		s=TCPSocket.open(@host, @port)
		##Send Header
		s.write HeaderBuilder.getHeader(GET[0].chr)
		##Send Body
		mkey=Marshal.dump(key)
		s.write Unsigned.encodeVint(mkey.size)
		#s.putc mkey.size
		s.write mkey
		#Handle response
		rspHeader = s.read(5)
		puts "Header " + rspHeader.unpack('c*').to_s
		rspBodyValueLengh = Unsigned.decodeVint(s)
		puts "Value Lenght " + rspBodyValueLengh.to_s
		rspBodyValue = s.read(rspBodyValueLengh)
		mrspBodyValue = Marshal.load(rspBodyValue)
		s.close
		mrspBodyValue
	end
	

	def put key,value
		s=TCPSocket.open(@host, @port)
		##Send Header
		s.write HeaderBuilder.getHeader(PUT[0].chr)
		##Send Body
		mkey=Marshal.dump(key)
		s.write Unsigned.encodeVint(mkey.size)
		#s.putc(mkey.size)
		puts "AAAA1 " + mkey.size.to_s + Unsigned.encodeVint(mkey.size).to_s
		s.write mkey
		s.write [0x00.chr,0x00.chr]
		mvalue=Marshal.dump(value)
		s.write Unsigned.encodeVint(mvalue.size)
		#s.putc mvalue.size
		puts "AAAA2 " + mvalue.size.to_s
		s.write mvalue
		#Handle response
		rspHeader = s.read(5)
		puts "Header " + rspHeader.unpack('c*').to_s
		s.close
	end
end

#rm = RemoteCache.new
#puts rm.get("\002>\005diego")
#puts rm.put("12345678","valorrrrrr")
#puts rm.put("Time",Time.now)
#puts rm.get("Time").to_s
#rm.put("1",1111111)
#puts rm.get("1")






#	def getJava key
#		s=TCPSocket.open(@host, @port)
#		s.write [MAGIC[0].chr,0x04.chr,HT_VERSION.chr,GET[0].chr,[],0.chr,0x01.chr,0.chr,0.chr,0.chr]
#		#s.write [[],0.chr,0x01.chr,0.chr,0.chr,0.chr]
#		s.putc 8
#		s.write key
#		rspHeader = s.read(5)
#		rspBodyValueLengh = s.read(1)
#		rspBodyValue = s.read(rspBodyValueLengh[0])
#		puts "Header " + rspHeader.unpack('c*').to_s
#		puts "Lenght " + rspBodyValueLengh.unpack('c*').to_s
#		s.close
#		rspBodyValue[2,rspBodyValueLengh[0]-1]
#	end
