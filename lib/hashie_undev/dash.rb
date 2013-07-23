module HashieUndev

	class Dash

		def initialize(args = {})
			@obj_hash = args
			unless class_hash.nil?
				class_hash.each_pair do |key, value|
					if value[:required] && !args.has_key?(key)
						raise ArgumentError, "The property #{key} is required for this Dash"
					end
					unless value[:default].nil? || args.has_key?(key)
						@obj_hash[key] = value[:default]
					end
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
					if value.nil? && class_hash[method_name.to_sym][:required]
						raise ArgumentError, "The property #{method_name} is required for this Dash"
					end
					@obj_hash[method_name.to_sym] = value 
				end
			else
				define_singleton_method(meth) { @obj_hash[method_name.to_sym] }
			end
			send meth, *args
		end

		class << self
			attr_accessor :class_hash

			def property(key_name, options = {})
				self.class_hash ||= Hash.new
				self.class_hash[key_name] = {}
				[:default, :required].each do |option_name|
					self.class_hash[key_name][option_name] = options.has_key?(option_name) ? options[option_name] : nil
				end
			end
		end

		def class_hash
			self.class.class_hash
		end

	end
end