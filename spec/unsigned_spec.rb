require '../lib/infinispan-ruby-client.rb'

class MyTestDoubleSocket<Array
	def initialize
		@mypos=0
	end
	def read i
		result = self[@mypos]
		@mypos+=1
		result
	end
end

describe Unsigned do
	describe "encoding for unsigned int/longs" do
	it "returns 0 for int zero" do
		Unsigned.encodeVint(0).size.should == 1
	end
	it "returns 1 byte for smaller ints" do
		Unsigned.encodeVint(50).size.should == 1
	end
	it "returns 2 bytes for medium ints" do
		Unsigned.encodeVint(128).size.should == 2
	end
	it "returns 3 bytes for medium to large ints" do
		Unsigned.encodeVint(60000).size.should == 3
	end
	## perform some refactoring and add more than 5 bytes integer
	end

  describe "encoding for unsigned int/longs" do

	before(:each) do
		@input=MyTestDoubleSocket.new
	end
	it "returns 0 for int zero" do
		@input<<0.chr
		Unsigned.decodeVint(@input).should == 0
    end
    it "returns valid small int greater than 0 for 2 bytes" do
		@input<<1.chr
		Unsigned.decodeVint(@input).should == 1
    end
    it "returns valid medium int greater than 128 for 2 bytes" do
		@input<<128.chr<<1.chr
		Unsigned.decodeVint(@input).should >= 128
    end
    it "returns valid medium int greater than 16384 for 3 bytes" do
      	@input<<128.chr<<128.chr<<1.chr
		Unsigned.decodeVint(@input).should >= 16384
    end
	#perform some refactoring and add more than 5 bytes integer
  end
end
