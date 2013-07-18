

module HashieUndev

	class Mash < Hash

		def method_missing(meth, *args, &block)
			method_name = meth.to_s[0..-2]
			method_opt = meth.to_s[-1]
			case method_opt 
			when '?'
				return !self[method_name].nil?
			when '='
				return self[method_name] = args[0]
			when '!'
				self[method_name] = self.class.new
				return self[method_name]
			else
				method_name = meth.to_s
				self[method_name]
			end
		end

	end
end