require 'spec_helper'

describe HashieUndev::Mash do 

	before(:each) do
		@mash = HashieUndev::Mash.new
	end

	describe 'call methods' do
		it 'call method should return nil' do
			@mash.name.should be_nil
		end

		it 'call method_name? should return false' do
			@mash.name?.should be_false
		end

		it 'call = should init hash key and return value' do
			@mash.name = 'Name'
			@mash.name.should eq('Name')
		end

		it 'call method_name? should return true after =' do
			@mash.name = 'Name'
			@mash.name?.should be_true
		end
	end

	describe 'call inspect' do
		it 'should return string' do
			@mash.name = 'Name'
			@mash.email = 'name@mail.com'
			@mash.inspect.should eql("Hashie::Mash name='Name' email='name@mail.com'")
		end
	end

end