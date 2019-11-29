require 'spec_helper'

describe Client do
  subject(:client) { described_class.new(username: 'pentos1234') }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:phone) }
    it { is_expected.to respond_to(:address) }
  end

  describe 'valid?' do
    it 'should be valid when name, phone and address are valid' do
      user = described_class.new(username: 'jperez', phone: '4123-4123',
                                 address: 'Av Paseo Colón 840')
      expect(user.valid?).to eq true
      expect(user.errors.empty?).to eq true
    end

    it 'should raise InvalidParameterException when username is nil' do
      expect do
        described_class.new(phone: '4123-4123',
                            address: 'Av Paseo Colón 840')
      end.to raise_error('invalid_username')
    end

    it 'should raise InvalidParameterException when username is blank' do
      expect do
        described_class.new(username: '', phone: '4123-4123',
                            address: 'Av Paseo Colón 840')
      end.to raise_error('invalid_username')
    end

    it "should be invalid when name contains '#?!' characters" do
      expect do
        described_class.new(username: '#pe?_!', phone: '4123-4123',
                            address: 'Av Paseo Colón 840')
      end.to raise_error('invalid_username')
    end

    it 'should be invalid when name contains a blank space' do
      expect do
        described_class.new(username: 'pe luna', phone: '4123-4123',
                            address: 'Av Paseo Colón 840')
      end.to raise_error('invalid_username')
    end

    it 'should be invalid when phone is blank' do
      client = described_class.new(username: 'pentos123', phone: '',
                                   address: 'Av Paseo Colón 840')
      expect(client.valid?).to eq false
      expect(client.errors).to have_key(:phone)
    end

    it 'should be invalid when phone contains non numerical numbers' do
      client = described_class.new(username: 'pentos123', phone: '4123-412A',
                                   address: 'Av Paseo Colón 840')
      expect(client.valid?).to eq false
      expect(client.errors).to have_key(:phone)
    end

    it 'should be invalid when address is blank' do
      client = described_class.new(username: 'pentos123', phone: '4123-412',
                                   address: '')
      expect(client.valid?).to eq false
      expect(client.errors).to have_key(:address)
    end

    it 'should be invalid when address size is less than 3' do
      client = described_class.new(username: 'pentos123', phone: '4123-4127',
                                   address: 'a1')
      expect(client.valid?).to eq false
      expect(client.errors).to have_key(:address)
    end
  end
end
