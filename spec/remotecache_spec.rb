
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

  it "should read versioned strings from the cache" #do
    #cache = RemoteCache.new
    #cache.put("a key", "a value")
    #cache.get_versioned("a key").should == "a value"
  #end
  
  #it "Can accept cache names" do
  #  rm = RemoteCache.new("localhost",11222,"testcache")
  #  rm.put("stringKey","valorrrrrr")
  #  rm.get("stringKey").should == "valorrrrrr"
  #end
end
