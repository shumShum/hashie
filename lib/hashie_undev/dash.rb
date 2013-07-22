module HashieUndev

	class Dash

		def initialize(args = {})
			@obj_hash = args
			@@class_hash.keys.each do |key|
				if @@class_hash[key]['required'] && !args.has_key?(key)
					raise ArgumentError, "The property #{key} is required for this Dash"
				end
				unless @@class_hash[key]['key_val'].nil? || args.has_key?(key)
					@obj_hash[key] = @@class_hash[key]['key_val']
				end
			end
		end

		def method_missing(meth, *args, &block)
			method_name = meth.to_s[-1] == '=' ? meth.to_s[0..-2] : meth.to_s
			method_opt = meth.to_s[-1]
			if method_name == '[]'
				method_name = args[0].to_s
				args = args[1..-1]
			end

			raise NoMethodError unless @obj_hash.has_key?(method_name.to_sym)
			if method_opt == '='
				define_singleton_method(meth) do |value| 
					if value.nil? && @@class_hash[method_name.to_sym]['required']
						raise ArgumentError, "The property #{method_name} is required for this Dash"
					end
					@obj_hash[method_name.to_sym] = value 
				end
			else
				define_singleton_method(meth) { @obj_hash[method_name.to_sym] }
			end
			send meth, *args
		end
		
		def self.property(key_name, options = {})
			@@class_hash ||= Hash.new
			@@class_hash[key_name] = {}
			@@class_hash[key_name]['key_val'] = options.has_key?(:default) ? options[:default] : nil
			@@class_hash[key_name]['required'] = options.has_key?(:required) ? options[:required] : false
		end

	end

end