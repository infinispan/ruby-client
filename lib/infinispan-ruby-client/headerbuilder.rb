require 'infinispan-ruby-client/unsigned.rb'

class HeaderBuilder
	def self.getHeader op_code
		[MAGIC[0].chr, #Magic
		 Unsigned.encodeVint(0x04), #Message Id			
		 #0x04.chr, #Message Id			
		 HT_VERSION.chr, # Version
		 op_code, # Opcode
		 [], # Cache Name Length
		 # # 	Cache Name
		 0.chr, # Flags
		 0x01.chr, # Client Intelligence	
		 0.chr,  # Topology Id	
		 0.chr, # Transaction Type
		 0.chr] # Transaction Id
	end
end
