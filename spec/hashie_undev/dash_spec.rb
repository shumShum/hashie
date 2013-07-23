require 'spec_helper'

describe HashieUndev::Dash do

	describe 'init dash' do
		before(:each) do
			class Person < HashieUndev::Dash
			  property :name, :required => true
			  property :email
			  property :occupation, :default => 'Rubyist'
			end
		end

		it 'bad new - required key miss' do
			expect{ p = Person.new }.to raise_error ArgumentError
		end

		describe 'work with required and default key' do
			before(:each) do
				@p = Person.new(:name => "Bob")
			end

			it 'true init, return required key' do
				expect(@p.name).to eql('Bob')
			end

			it 'required key = nil' do
				expect{ @p.name = nil }.to raise_error ArgumentError
			end 

			it 'return default key' do
				expect(@p.occupation).to eql('Rubyist')
			end

			it 'call miss key' do
				expect{ @p.awesome }.to raise_error NoMethodError
			end

			it 'call key like hash' do
				expect(@p[:occupation]).to eql('Rubyist')
			end

			it 'call miss key like hash' do
				expect{@p[:awesome]}.to raise_error NoMethodError 
			end

		end

	end

end