require '../lib/infinispan-ruby-client.rb'

describe "Operation Builder" do
  before(:each) do
    @builder = OperationBuilder.new(RemoteCache.new)
  end
	context "GET Operations" do
    it "Build operation with header" do
      op=@builder.buildGET()
      op.header.size.should >= 10
		end
	end
end
