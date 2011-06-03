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

class Unsigned
	def self.encodeVint(i)
		result=[]
		while ((i & ~0x7f) != 0)
			result[result.size]=((i & 0x7f) | 0x80).chr
			i>>=7
		end
		result[result.size]=i.chr
		result
	end

	def self.decodeVint(input)
		b = input.read(1)
    i = b[0] & 0x7F
		shift = 7
		while ((b[0] & 0x80) != 0)
			b = input.read(1)
      i |= (b[0] & 0x7F) << shift
			shift += 7
		end
		i
	end
end
