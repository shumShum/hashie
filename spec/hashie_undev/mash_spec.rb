require 'spec_helper'

describe HashieUndev::Mash do 

	before(:each) do
		@mash = HashieUndev::Mash.new
	end

	describe 'call bool methods' do
		it 'call name? should return false' do
			@mash.name? eq(false)
		end
	end

end