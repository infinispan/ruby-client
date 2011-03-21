require '../lib/infinispan-ruby-client.rb'

describe "RemoteCache Functional Test" do
  it "Can put and read strings from cache" do
    rm = RemoteCache.new
    rm.put("stringKey","valorrrrrr")
    rm.get("stringKey").should == "valorrrrrr"
  end
  it "Can put and read ruby objects from cache" do
    rm = RemoteCache.new
    myNow = Time.now
    rm.put("myNow",myNow)
    rm.get("myNow").should == myNow
  end
end