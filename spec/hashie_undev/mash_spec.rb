require 'spec_helper'

describe HashieUndev::Mash do 

	before(:each) do
		@mash = HashieUndev::Mash.new
	end

	describe 'call bool methods' do
		it 'call name? should return false' do
			@mash.name?.should eq(false)
		end

		it 'call = should def hash key' do
			@mash.name = 'Name'
			@mash.name.should eq('Name')
		end

	end

end