require 'socket'

class RemoteCache
	attr_accessor :host, :port

	def initialize host='localhost',port=11222
		@host = host
		@port = port
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