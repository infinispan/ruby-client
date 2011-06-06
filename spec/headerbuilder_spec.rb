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


describe "Header Builder" do

  context "Get Header" do

    it "Build operation with header with default cache" do
      result = HeaderBuilder.getHeader(Infinispan::Constants::GET[0], "")
      result.size.should == 10
    end

    it "Build operation with header with specific cache" do
      result = HeaderBuilder.getHeader(Infinispan::Constants::GET[0], "myCache")
      result.size.should == 11
      cache_name_size=result[4][0].unpack('*c')
      cache_name_size.should == [7]
      result[5].should == "myCache"
    end

	end
end
