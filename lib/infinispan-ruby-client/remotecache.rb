require 'socket'

class RemoteCache
	attr_accessor :host, :port, :cache_name

	def initialize host="localhost",port=11222,cache_name=""
		@host = host
		@port = port
    @cache_name = cache_name
    @opb = OperationBuilder.new(self)
	end

  def get key
    op = @opb.buildGET
    op.perform(key)
	end
	

	def put key,value
    op = @opb.buildPUT
    op.perform(key,value)
	end
end