module HashieUndev

	class Trash

		def initialize(args = {})
			@obj_hash = args
			unless class_hash.nil?
				class_hash.each_pair do |key, value|
					if value['required'] && !args.has_key?(key)
						raise ArgumentError, "The property #{key} is required for this Dash"
					end
					unless value[:default].nil? || args.has_key?(key)
						@obj_hash[key] = value[:default]
					end			
					@obj_hash[key] = @obj_hash.delete(value[:from]) if @obj_hash.has_key?(value[:from])
					@obj_hash[key] = value[:with].call(@obj_hash[key]) unless value[:with].nil?
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
			method_name = alias_to_main_key(method_name)
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
				options[:with] = options.delete(:transform_with) if options.has_key?(:transform_with)
				[:default, :required, :from, :with].each do |option_name|
					self.class_hash[key_name][option_name] = options.has_key?(option_name) ? options[option_name] : nil
				end
			end
		end

		private

		def alias_to_main_key(alias_name)
			method_name = alias_name
			class_hash.each_pair do |key, value|
				method_name = key.to_s if value[:from] == alias_name.to_sym
			end
			return method_name
		end

		def class_hash
			self.class.class_hash
		end

	end
end