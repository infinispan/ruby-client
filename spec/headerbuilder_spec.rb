require '../lib/infinispan-ruby-client.rb'

describe "Header Builder" do
  context "Get Header" do
    it "Build operation with header with default cache" do
      result = HeaderBuilder.getHeader(GET[0].chr,"")
      result.size.should == 10
    end
    it "Build operation with header with specific cache" do
      result = HeaderBuilder.getHeader(GET[0].chr,"myCache")
      result.size.should == 11
      cache_name_size=result[4][0].unpack('*c')
      cache_name_size.should == [7]
      result[5].should == "myCache"
    end
	end
end