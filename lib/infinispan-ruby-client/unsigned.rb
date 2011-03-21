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
