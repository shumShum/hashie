

module HashieUndev

	class Mash < Hash

		def method_missing(meth, *args, &block)
			format = meth.to_s.scan(/(\w*)(\?|=|!|_)?/)
			unless format[0].empty?
				method_name = format[0][0]
				method_opt = format[0][1]
				case method_opt 
				when '?'
					return !self[method_name].nil?
				when '='
					return self[method_name] = args[0]
				when '!'
					self[method_name] = self.class.new
					return self[method_name]
				# when '_'
				# 	multi_level_obj = self.class.new
					
				else
					self[method_name]
				end
			end
		end

	end
end