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

require 'infinispan-ruby-client/unsigned.rb'

class HeaderBuilder
  def self.getHeader op_code,cache_name
    result=[MAGIC[0].chr, #Magic
            Unsigned.encodeVint(0x04), #Message Id
            HT_VERSION.chr, # Version
            op_code, # Opcode
            cache_name.size==0?[]:Unsigned.encodeVint(cache_name.size)] # Cache Name Length
    
    result<<cache_name unless cache_name.size==0 # # 	Cache Name
    
    tale=[0.chr, # Flags
          0x01.chr, # Client Intelligence
          0.chr, # Topology Id
          0.chr, # Transaction Type
          0.chr] # Transaction Id
    
    tale.each{|e| result<<e}
    result
  end
end
