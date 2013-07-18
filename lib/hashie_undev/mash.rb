

module HashieUndev

	class Mash < Hash
		def method_missing(meth, *args, &block)
			format = meth.to_s.scan(/(\w*)(\?|=)?/)
			unless format[0].empty?
				method_name = format[0][0]
				method_opt = format[0][1]
				if method_opt == '?'
					return !self[method_name].nil?
				end
				if method_opt == '='
					return self[method_name] = args[0]
				end
				if method_opt.nil?
					self[method_name]
				end
			end
		end
	end

end