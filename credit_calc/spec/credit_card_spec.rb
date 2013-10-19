require 'spec_helper'

describe CreditCalc do
  describe '.calc' do
    context 'when amount = 0' do
      let(:args) do
        {amount: 0, percent: 22, period: 10}
      end

      it 'returns 0' do
        expect(described_class.calc(args)).to be_zero
      end 
    end

    context 'when percent = 0 and amount = 1000' do
      let(:args) do
        {amount: 1000, percent: 0, period: 10}
      end

      it 'returns 1000' do
        expect(described_class.calc(args)).to be 1000
      end
    end

    context 'when period = 0 and amount = 1000' do
      let(:args) do
        {amount: 1000, percent: 22, period: 0}
      end
     
      it 'returns 1000' do
        expect(described_class.calc(args)).to be 1000
      end 
    end

    context 'when amount = 1000, percent = 22 and period = 10' do
      let(:args) do
        {amount: 1000, percent: 22, period: 10}
      end
      it 'returns 7305' do
        expect(described_class.calc(args)).to be 7305
      end
    end

    context 'when amount < 0' do
      let(:args) do
        {amount: -1, percent: 22, period: 10}
      end
      it 'raises ArgumentError' do
         expect { described_class.calc(args) }.
           to raise_error(ArgumentError, 'amount should be >= 0')
      end
    end

    context 'when percent < 0' do
      let(:args) do
        {amount: 1000, percent: -1, period: 10}
      end
      it 'raises ArgumentError' do
         expect { described_class.calc(args) }.
           to raise_error(ArgumentError, 'percent should be >= 0')
      end
    end

    context 'when period < 0' do
      let(:args) do
        {amount: 1000, percent: 22, period: -1}
      end
      it 'raises ArgumentError' do
         expect { described_class.calc(args) }.
           to raise_error(ArgumentError, 'period should be >= 0')
      end
    end
    
    context 'when amount is not defined' do
      let(:args) do
        {percent: 22, period: 10}
      end
      it 'raises ArgumentError' do
         expect { described_class.calc(args) }.
           to raise_error(ArgumentError, 'amount should be defined')
      end
    end

    context 'when percent is not defined' do
      let(:args) do
        {amount: 1000, period: 10}
      end
      it 'raises ArgumentError' do
         expect { described_class.calc(args) }.
           to raise_error(ArgumentError, 'percent should be defined')
      end
    end

    context 'when period is not defined' do
      let(:args) do
        {amount: 1000, percent: 22}
      end
      it 'raises ArgumentError' do
         expect { described_class.calc(args) }.
           to raise_error(ArgumentError, 'period should be defined')
      end
    end
  end
end
