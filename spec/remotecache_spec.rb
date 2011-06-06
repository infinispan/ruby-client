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
    cache = Infinispan::RemoteCache.new
    cache.put("stringKey", "valorrrrrr").should be_true
    cache.get("stringKey").should == "valorrrrrr"
  end

  it "should put and read ruby objects from cache" do
    cache = Infinispan::RemoteCache.new
    myNow = Time.now
    cache.put("myNow",myNow).should be_true
    cache.get("myNow").should == myNow
  end

  it "should put and read versioned values from the cache" do
    cache = Infinispan::RemoteCache.new
    cache.put("a key", "a value").should be_true
    first_version = cache.get_versioned("a key")
    cache.put("a key", "a 2nd value").should be_true
    second_version = cache.get_versioned("a key")
    first_version[0].should_not == second_version[0]
    first_version[1].should == "a value"
    second_version[1].should == "a 2nd value"
  end
  
  it "should remove values from the cache" do
    cache = Infinispan::RemoteCache.new
    myNow = Time.now
    cache.put("myNow",myNow)
    cache.remove("myNow").should be_true
  end

  it "should return false when attempting to remove values that don't exist" do
    cache = Infinispan::RemoteCache.new
    cache.remove("myNow").should be_false
  end

  it "contains_key should return false when the key does not exist" do
    cache = Infinispan::RemoteCache.new
    cache.contains_key("foobar").should be_false
  end

  it "contains_key should return true when the key exists" do
    cache = Infinispan::RemoteCache.new
    cache.put("foo", "bar")
    cache.contains_key("foo").should be_true
  end

  it "should remove versioned values from the cache" 

  it "should accept cache names" 
  it "should put multiple values into the cache" 
  it "should support putIfAbsent"
  it "should support remove/if"
  it "should support replace/if"
  it "should support getting server statistics"
  it "should support put/get bulk"
end
