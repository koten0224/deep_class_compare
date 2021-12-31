RSpec.describe InheritHash do
  context "when compare with a specific class that inherited from Hash" do
    subject { described_class }
    it { is_expected.to be_respond_to :of}

    context ".of" do
      subject { described_class.of(Object, Object) }
      it { expect { subject }.not_to raise_error }
      it { expect { subject.of(Object) }.to raise_error }
    end

    context "#like_a?" do
      let(:params) do
        hash = InheritHash.new
        hash[:symbol] = 'string'
        hash
      end

      it "return true" do
        expect(params).to be_like_a InheritHash
        expect(params).to be_like_a Hash
        expect(params).to be_like_a InheritHash.of String
        expect(params).to be_like_a InheritHash.of Symbol, String
        expect(params).to be_like_a Hash.of String
        expect(params).to be_like_a Hash.of Symbol, String
      end
      
      it "return false" do
        expect(params).not_to be_like_a String
        expect(params).not_to be_like_a InheritHash.of Integer
        expect(params).not_to be_like_a InheritHash.of Symbol, Integer
        expect({}).not_to be_like_a InheritHash
        expect({symbol: 'string'}).not_to be_like_a InheritHash.of String
        expect({symbol: 'string'}).not_to be_like_a InheritHash.of Symbol, String
      end
    end
  end
end