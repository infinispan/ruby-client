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

  before(:all) do
    @cache = Infinispan::RemoteCache.new
  end

  after(:each) do
    @cache.clear
  end

  it "should put and read strings from cache" do
    @cache.put("thekey", "valorrrrrr").should be_true
    @cache.get("thekey").should == "valorrrrrr"
  end

  it "should put and read ruby objects from cache" do
    now = Time.now
    @cache.put("thekey", now).should be_true
    @cache.get("thekey").should == now
  end

  it "should put and read versioned values from the cache" do
    @cache.put("thekey", "a value").should be_true
    first_version = @cache.get_versioned("thekey")
    @cache.put("thekey", "a 2nd value").should be_true
    second_version = @cache.get_versioned("thekey")
    first_version[0].should_not == second_version[0]
    first_version[1].should == "a value"
    second_version[1].should == "a 2nd value"
  end
  
  it "should remove values from the cache" do
    now = Time.now
    @cache.put("thekey", now)
    @cache.remove("thekey").should be_true
  end

  it "should return false when attempting to remove values that don't exist" do
    @cache.remove("thekey").should be_false
  end

  it "contains_key should return false when the key does not exist" do
    @cache.contains_key("thekey").should be_false
  end

  it "contains_key should return true when the key exists" do
    @cache.put("thekey", "foobar")
    @cache.contains_key("thekey").should be_true
  end

  it "put_if_abasent should return true on success" do
    @cache.put_if_absent("thekey", "foo").should be_true
  end

  it "put_if_absent should return false if the key already exists" do
    @cache.put_if_absent("thekey", "foo")
    @cache.put_if_absent("thekey", "bar").should be_false
  end

  it "replace should return true on success" do
    @cache.put("thekey", "value1")
    @cache.replace("thekey", "value2").should be_true
    @cache.get("thekey").should == "value2"
  end

  it "replace should return false if the key does not already exist" do
    @cache.replace("thekey", "value2").should be_false
  end

  it "replace_if_unmodified should return true on success" do
    @cache.put("thekey", "value")
    version, value = @cache.get_versioned("thekey")
    @cache.replace_if_unmodified("thekey", version, "value2").should be_true
    @cache.get("thekey").should == "value2"
  end

  it "replace_if_unmodified should return false if the key has been altered" do
    @cache.put("thekey", "value")
    version, value = @cache.get_versioned("thekey")
    @cache.put("thekey", "value2")
    @cache.replace_if_unmodified("thekey", version, "value2").should be_false
  end

  it "remove_if_unmodified should return true on success" do
    @cache.put("thekey", "value")
    version, value = @cache.get_versioned("thekey")
    @cache.remove_if_unmodified("thekey", version).should be_true
  end

  it "should support clearing the cache" do
    @cache.put("thekey", "value")
    @cache.clear
    @cache.contains_key("thekey").should be_false
  end

  # TODO mock the cache so we can test ping failure
  it "should be able to ping the cache" do
    @cache.ping.should be_true
  end

  it "should support getting all cache entries at once" do
    @cache.put("key-1", "value-1")
    @cache.put("key-2", "value-2")
    @cache.put("key-3", "value-3")
    @cache.put("key-4", "value-4")
    everything = @cache.get_bulk
    everything.size.should == 4
    everything['key-1'].should == 'value-1'
    everything['key-2'].should == 'value-2'
    everything['key-3'].should == 'value-3'
    everything['key-4'].should == 'value-4'
  end

  it "should support getting a subset of all cache entries at once" do
    @cache.put("key-1", "value-1")
    @cache.put("key-2", "value-2")
    @cache.put("key-3", "value-3")
    @cache.put("key-4", "value-4")
    everything = @cache.get_bulk(2)
    everything.size.should == 2
  end

  it "should accept cache names" 
  it "should support getting server statistics"
end
