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

	describe 'init trash with transform_with' do
		before(:each) do
			class Result < HashieUndev::Trash
			  property :id, :transform_with => lambda { |v| v.to_i }
			  property :created_at, :from => :creation_date, :with => lambda { |v| Time.parse(v) }
			end
			@result = Result.new(:id => '123', :creation_date => '2012-03-30 17:23:28')
		end

		it 'id as integer' do
			expect(@result.id.class).to eql(Fixnum)
		end

		it 'created_at as Time' do
			expect(@result.created_at.class).to eql(Time)
		end
	end

end