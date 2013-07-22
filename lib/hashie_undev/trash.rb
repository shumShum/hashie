module HashieUndev

	class Trash < Dash

		def initialize(args = {})
			
		end	
	
		class << self
			attr_accessor :class_hash

			def property(key_name, options = {})
				super
				
				self.class_hash[key_name]['aliases'] = options.has_key?(:from) ? options[:from] : nil
			end
		end

	end
end