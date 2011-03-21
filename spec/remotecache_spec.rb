require '../lib/infinispan-ruby-client.rb'

describe "RemoteCache Functional Test" do
  it "Can read something from cache" do
    rm = RemoteCache.new
    rm.put("12345678","valorrrrrr")
    rm.get("12345678").should == "valorrrrrr"
  end
end