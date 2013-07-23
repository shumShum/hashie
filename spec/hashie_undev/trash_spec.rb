require 'spec_helper'

describe HashieUndev::Trash do

	describe 'init trash with from' do
		before(:each) do
			class TPerson < HashieUndev::Trash
			  property :first_name, :from => :firstName
			end
			@p = TPerson.new(:firstName => 'Bob')
		end

		it 'call propertys alias' do
			expect(@p.first_name).to eql('Bob')
		end

		it 'call propertys alias like method' do
			expect(@p.firstName).to eql('Bob')
		end
	end

end