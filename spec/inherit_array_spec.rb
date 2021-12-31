RSpec.describe InheritArray do
  context "when compare with a specific class that inherited from Array" do
    subject { described_class }
    it { is_expected.to be_respond_to :of}

    context ".of" do
      subject { described_class.of(Object) }
      it { expect { subject }.not_to raise_error }
      it { expect { subject.of(Object) }.to raise_error }
    end

    context "#like_a?" do
      let(:params) do
        array = InheritArray.new
        array << 'string'
      end

      it "return true" do
        expect(params).to be_like_a InheritArray
        expect(params).to be_like_a Array
        expect(params).to be_like_a InheritArray.of String
        expect(params).to be_like_a Array.of String
      end
      
      it "return false" do
        expect(params).not_to be_like_a String
        expect(params).not_to be_like_a InheritArray.of Integer
        expect([]).not_to be_like_a InheritArray
        expect(['string']).not_to be_like_a InheritArray.of String
      end
    end
  end
end