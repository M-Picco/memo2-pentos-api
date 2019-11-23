require 'spec_helper'

describe Delivery do
  subject(:delivery) { described_class.new({}) }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:username) }
    it { is_expected.to respond_to(:created_on) }
    it { is_expected.to respond_to(:updated_on) }
    it { is_expected.to respond_to(:bag) }
  end

  describe 'valid?' do
    it 'should be valid when username not blank' do
      delivery = described_class.new('username' => 'pepemoto')
      expect(delivery.valid?).to eq true
      expect(delivery.errors.empty?).to eq true
    end

    it 'should be invalid when username size is shorter than five characters' do
      delivery = described_class.new('username' => 'pepe')
      expect(delivery.valid?).to eq false
      expect(delivery.errors).to have_key(:username)
    end

    it 'should be valid when username size is five characters' do
      delivery = described_class.new('username' => 'pepes')
      expect(delivery.valid?).to eq true
      expect(delivery.errors.empty?).to eq true
    end

    it 'should be invalid when username size is  larger than twenty than characters' do
      delivery = described_class.new('username' => 'elseniordelosanillos123')
      expect(delivery.valid?).to eq false
      expect(delivery.errors).to have_key(:username)
    end

    it 'should be invalid when username size is twenty characters' do
      delivery = described_class.new('username' => 'elseniordelosanillos')
      expect(delivery.valid?).to eq false
      expect(delivery.errors).to have_key(:username)
    end

    it 'should be valid when username size is nineteen characters' do
      delivery = described_class.new('username' => 'elsenordelosanillos')
      expect(delivery.valid?).to eq true
      expect(delivery.errors.empty?).to eq true
    end
  end
end
