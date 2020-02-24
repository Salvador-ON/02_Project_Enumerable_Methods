require './lib/enumerables.rb'

RSpec.describe Enumerable do
  let(:arr) { [8, 3, 5, 5, 6, 6] }

  describe '#my_each' do
    context 'when no block given return enumarator' do
      it { expect(arr.my_each).to be_a(Enumerator) }
    end

    context 'when block given return array' do
      it { expect(arr.my_each { |x| x + 2 }).to eq(arr) }
    end
  end

  describe 'my_each_with_index' do
    context 'when no block given return enumarator' do
      it { expect(arr.my_each_with_index).to be_a(Enumerator) }
    end

    context 'when block given return array' do
      it { expect(arr.my_each_with_index { |x| x + 2 }).to eq(arr) }
    end
  end
end
