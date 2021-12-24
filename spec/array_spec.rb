# frozen_string_literal: true

RSpec.describe Array do
  it { expect(described_class).to be_respond_to(:of) }

  context ".of" do
    subject { described_class.of(Array) }
    it { is_expected.to be_a DeepClassCompare::Matcher }
    it { is_expected.to be_respond_to(:of) }
    it { expect { subject }.not_to raise_error }
    it { expect { subject.of([]) }.to raise_error }
    it { expect { subject.of([Object]) }.not_to raise_error }
    it { expect { subject.of('something') }.to raise_error }
    it { expect { subject.of(['something']) }.to raise_error }

    it "not allow to chain after a non-container class" do
      expect { described_class.of(String).of(Integer) }.to raise_error
    end

    it "not allow to chain after a multi-compare" do
      expect { described_class.of([String, Array]).of(Integer) }.to raise_error
    end
  end

  context "#like_a?" do
    context "should compare class chain" do
      it "return true" do
        expect([[]]).to be_like_a described_class.of(Array)
        expect([{}]).to be_like_a described_class.of(Hash)
        expect(%w(a)).to be_like_a described_class.of(String)
        expect(%i(a)).to be_like_a described_class.of(Symbol)
      end

      it "return false" do
        expect([[]]).not_to be_like_a described_class.of(Symbol)
        expect([{}]).not_to be_like_a described_class.of(Array)
        expect(%w(a)).not_to be_like_a described_class.of(Hash)
        expect(%i(a)).not_to be_like_a described_class.of(String)
      end
    end

    context "should compare class chain of three or more" do
      let(:params) do
        [
          [
            %w(a b c)
          ]
        ]
      end
      it "return true" do
        expect(params).to be_like_a described_class.of(Array).of(Array)
        expect(params).to be_like_a described_class.of(Array).of(Array).of(String)
      end

      it "return false" do
        expect(params).not_to be_like_a described_class.of(Array).of(Hash)
        expect(params).not_to be_like_a described_class.of(Array).of(Array).of(Array)
      end
    end

    context "should compare with different types of values" do
      let(:params) do
        ['a', :b, 123]
      end

      it "return true" do
        expect(params).to be_like_a described_class.of([String, Symbol, Integer])
      end

      it "return false" do
        expect(params).not_to be_like_a described_class.of([String, Symbol])
      end
    end

    pending "should compare class chain of three or more with hash" do
      let(:params) do
        [
          {
            a: %w(a b c),
            b: %w(a b c)
          }
        ]
      end

      it "return true" do
        expect(params).to be_like_a described_class.of(Hash).of(Array)
        expect(params).to be_like_a described_class.of(Hash).of(Array).of(String)
        expect(params).to be_like_a described_class.of(Hash).of(Symbol, Array)
        expect(params).to be_like_a described_class.of(Hash).of(Symbol, Array.of(String))
      end

      it "return false" do
        expect(params).not_to be_like_a described_class.of(Array).of(Array)
        expect(params).not_to be_like_a described_class.of(Hash).of(Array).of(Symbol)
        expect(params).not_to be_like_a described_class.of(Hash).of(Symbol, String)
        expect(params).not_to be_like_a described_class.of(Hash).of(Symbol, Array.of(Integer))
      end
    end
  end
end
