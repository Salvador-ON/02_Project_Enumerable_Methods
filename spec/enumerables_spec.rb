require './lib/enumerables.rb'

RSpec.describe Enumerable do
  let(:arr) { [8, 3, 5, 5, 6, 6] }
  let(:a_t2) { %w[cat dog wombat] }

  describe '#my_each' do
    context 'when no block given return enumarator' do
      it { expect(arr.my_each).to be_a(Enumerator) }
    end

    context 'when block given return array' do
      it { expect(arr.my_each { |x| x + 2 }).to eq(arr) }
    end
  end

  describe '#my_each_with_index' do
    context 'when no block given return enumarator' do
      it { expect(arr.my_each_with_index).to be_a(Enumerator) }
    end

    context 'when block given return array' do
      it { expect(arr.my_each_with_index { |x| x + 2 }).to eq(arr) }
    end

    context 'when block given with a string array return array' do
      ha = {}
      ha2 = {}
      it { expect(a_t2.my_each_with_index { |i, ix| ha[i] = ix }).to eq(a_t2.each_with_index { |i, ix| ha2[i] = ix }) }
    end
  end

  describe '#my_all?' do
    context 'when no block given' do
      it { expect(arr.my_all?).to eq(arr.all?) }
    end

    context 'when block given' do
      it { expect(a_t2.my_all? { |word| word.length >= 4 }).to eq(a_t2.all? { |word| word.length >= 4 }) }
    end

    context 'when argument given' do
      it { expect(arr.my_all?(Numeric)).to eq(arr.all?(Numeric)) }
    end

    context 'when using regex' do
      it { expect(a_t2.my_all?(/t/)).to eq(a_t2.all?(/t/)) }
    end

    context 'when no arguments or block given' do
      it { expect([].my_all?).to eq([].all?) }
    end
  end

  describe '#my_none?' do
    context 'when no block given' do
      it { expect(arr.my_none?).to eq(arr.none?) }
    end

    context 'when block given' do
      it { expect(a_t2.my_none? { |word| word.length >= 4 }).to eq(a_t2.none? { |word| word.length >= 4 }) }
    end

    context 'when argument given' do
      it { expect(arr.my_none?(Numeric)).to eq(arr.none?(Numeric)) }
    end

    context 'when using regex' do
      it { expect(a_t2.my_none?(/t/)).to eq(a_t2.none?(/t/)) }
    end

    context 'when no arguments or block given' do
      it { expect([].my_none?).to eq([].none?) }
    end
  end

  describe '#my_any?' do
    context 'when no block given' do
      it { expect(arr.my_any?).to eq(arr.any?) }
    end

    context 'when block given' do
      it { expect(a_t2.my_any? { |word| word.length >= 4 }).to eq(a_t2.any? { |word| word.length >= 4 }) }
    end

    context 'when argument given' do
      it { expect(arr.my_any?(Numeric)).to eq(arr.any?(Numeric)) }
    end

    context 'when using regex' do
      it { expect(a_t2.my_any?(/t/)).to eq(a_t2.any?(/t/)) }
    end

    context 'when no arguments or block given' do
      it { expect([].my_any?).to eq([].any?) }
    end
  end

  describe '#my_inject?' do
    context 'when no block given' do
      it { expect(arr.my_inject(:+)).to eq(arr.inject(:+)) }
    end

    context 'when block given' do
      it { expect(arr.my_inject { |sum, n| sum + n }).to eq(arr.inject { |sum, n| sum + n }) }
    end
  end

  describe '#my_select' do
    context 'when no block given return enumarator' do
      it { expect(arr.my_select).to be_a(Enumerator) }
    end

    context 'when block given return array' do
      it { expect(arr.my_select { |num| num > 4 }).to eq(arr.select { |num| num > 4 }) }
    end
  end

  describe '#my_count' do
    context 'when no block given and no argument' do
      it { expect(arr.my_count).to eq(arr.count) }
    end

    context 'when argument is given' do
      it { expect(arr.my_count(6)).to eq(arr.count(6)) }
    end

    context 'when block is given' do
      it { expect(arr.my_count { |x| x > 5 }).to eq(arr.count { |x| x > 5 }) }
    end
  end

  describe '#my_map' do
    context 'when no block given return enumarator' do
      it { expect(arr.my_map).to be_a(Enumerator) }
    end

    context 'when block given return array' do
      it { expect(arr.my_map { |num| num > 4 }).to eq(arr.map { |num| num > 4 }) }
    end

    context 'when proc is given return array' do
      x2 = proc { |num| num * 2 }
      it { expect(arr.my_map(&x2)).to eq(arr.map(&x2)) }
    end

    context 'when block given with a range return array' do
      it { expect((2..8).my_map { |num| num * num }).to eq((2..8).map { |num| num * num }) }
    end
  end
end
