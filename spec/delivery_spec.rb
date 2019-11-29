require 'spec_helper'

describe Delivery do
  subject(:delivery) { described_class.new(username: 'pepemoto') }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:username) }
    it { is_expected.to respond_to(:created_on) }
    it { is_expected.to respond_to(:updated_on) }
    it { is_expected.to respond_to(:bag) }
    it { is_expected.to respond_to(:delivered_count) }
    it { is_expected.to respond_to(:waiting_time) }
  end

  describe 'valid?' do
    it 'should be valid when username not blank' do
      delivery = described_class.new(username: 'pepemoto')
      expect(delivery.valid?).to eq true
      expect(delivery.errors.empty?).to eq true
    end

    it 'should raise InvalidParameterError when username size is shorter than five characters' do
      expect do
        described_class.new(username: 'pepe')
      end.to raise_error('invalid_username')
    end

    it 'should be valid when username size is five characters' do
      delivery = described_class.new(username: 'pepes')
      expect(delivery.valid?).to eq true
      expect(delivery.errors.empty?).to eq true
    end

    it 'should raise InvalidParameterError when username size
        is larger than twenty than characters' do
      expect do
        described_class.new(username: 'elseniordelosanillos123')
      end.to raise_error('invalid_username')
    end

    it 'should raise InvalidParameterError when username size is twenty characters' do
      expect do
        described_class.new(username: 'elseniordelosanillos')
      end.to raise_error('invalid_username')
    end

    it 'should be valid when username size is nineteen characters' do
      delivery = described_class.new(username: 'elsenordelosanillos')
      expect(delivery.valid?).to eq true
      expect(delivery.errors.empty?).to eq true
    end
  end
end
