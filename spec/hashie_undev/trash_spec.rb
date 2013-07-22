require 'spec_helper'

describe HashieUndev::Trash do

	before(:each) do
		@trash = HashieUndev::Trash.new
	end

	describe 'init trash with from' do
		before(:each) do
			class Person < Hashie::Trash
			  property :first_name, :from => :firstName
			end
		end

		it 'call propertys alias' do
			p = Person.new(:firstName => 'Bob')
			expect(p.first_name).it eql('Bob')
		end
	end

end