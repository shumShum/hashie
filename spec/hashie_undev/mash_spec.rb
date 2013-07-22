require 'spec_helper'

describe HashieUndev::Mash do

	before(:each) do
		@mash = HashieUndev::Mash.new
	end 

	describe 'call methods' do
	
		it 'call method should return nil' do
			expect(@mash.name).to be_nil
		end

		it 'call method_name? should return false' do
			expect(@mash.name?).to be_false
		end

		it 'call = should init hash key and return value' do
			@mash.name = 'Name'
			expect(@mash.name).to eql('Name')
		end

		it 'call method_name? should return true after =' do
			@mash.name = 'Name'
			expect(@mash.name?).to be_true
		end
	end

	describe 'bang methods' do

		it 'call bang methods for multi-level assignment' do
			@mash.author!.name = 'Author Name'
			expect(@mash.author.name).to eql('Author Name')
		end

		# it 'call under-bang methods for multi-level testing' do
		# 	@mash.author.should be_nil
		# 	@mash.author_.name?.should be_false 
		# 	@mash.author!.name = 'Author Name'
		# 	@mash.author_.name?.should be_true
		# end

	end

end