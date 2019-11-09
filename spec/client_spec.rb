require 'spec_helper'

describe Client do
  subject(:client) { described_class.new({}) }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:phone) }
    it { is_expected.to respond_to(:address) }
  end

  describe 'valid?' do
    it 'should be valid when name, phone and address are valid' do
      user = described_class.new('username' => 'jperez', 'phone' => '4123-4123',
                                 'address' => 'Av Paseo Colón 840')
      expect(user.valid?).to eq true
      expect(user.errors.empty?).to eq true
    end

    it 'should be invalid when username is blank' do
      client = described_class.new('username' => '', 'phone' => '4123-4123',
                                   'address' => 'Av Paseo Colón 840')
      expect(client.valid?).to eq false
      expect(client.errors).to have_key(:name)
    end
  end
end
