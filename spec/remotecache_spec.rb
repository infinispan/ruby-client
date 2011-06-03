#
# Copyright 2011 Red Hat, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


describe "RemoteCache Functional Test" do

  it "should put and read strings from cache" do
    rm = RemoteCache.new
    rm.put("stringKey","valorrrrrr")
    rm.get("stringKey").should == "valorrrrrr"
  end

  it "should put and read ruby objects from cache" do
    rm = RemoteCache.new
    myNow = Time.now
    rm.put("myNow",myNow)
    rm.get("myNow").should == myNow
  end

  it "should accept cache names" #do
  #  rm = RemoteCache.new("localhost",11222,"testcache")
  #  rm.put("stringKey","valorrrrrr")
  #  rm.get("stringKey").should == "valorrrrrr"
  #end

  it "should put and read versioned values from the cache" #do
    #cache = RemoteCache.new
    #cache.put("a key", "a value")
    #cache.get_versioned("a key").should == "a value"
  #end
  
  it "should remove versioned values from the cache" 
  it "should put multiple values into the cache" 
  it "should support putIfAbsent"
  it "should support remove/if"
  it "should support replace/if"
  it "should support contains_key"
  it "should support getting server statistics"
  it "should support put/get bulk"
end
