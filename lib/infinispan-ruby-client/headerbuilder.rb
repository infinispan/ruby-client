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
