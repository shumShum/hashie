module HashieUndev

	class Mash < Hash

		def method_missing(meth, *args, &block)
			method_name = meth.to_s[0..-2]
			method_opt = meth.to_s[-1]
			case method_opt 
			when '?'
				define_singleton_method(meth) { !self[method_name].nil? }
			when '='
				define_singleton_method(meth) { |value| self[method_name] = value }
			when '!'
				self[method_name] = self.class.new
     		define_singleton_method(meth) { self[method_name] }
			else
				method_name = meth.to_s
				define_singleton_method(meth) { self[method_name] }
			end

			send meth, *args
		end

	end
end