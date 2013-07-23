require 'spec_helper'

describe HashieUndev::Clash do

	before(:each) do
		@c = HashieUndev::Clash.new
	end

	describe 'push where and order options' do
		it 'simple variant' do
			@c.where(abc: 'def').order(:created_at)
			valid_hash = {where: {abc: 'def'}, order: :created_at}
			expect(@c).to eql(valid_hash)
		end

		it 'define with !' do
			@c.where!.abc('def').ghi(123)._end!.order(:created_at)
			valid_hash = {where: {abc: 'def', ghi: 123}, order: :created_at}
			expect(@c).to eql(valid_hash)
		end

		it 'unites several same options' do
			@c.where(abc: 'def').where(hgi: 123)
			valid_hash = {where: {abc: 'def', hgi: 123}}
			expect(@c).to eql(valid_hash)
		end

		it 'call missing key without where!' do
			expect{ @c.abc(:qwe).where(asd: 1) }.to raise_error NoMethodError
		end

	end
end