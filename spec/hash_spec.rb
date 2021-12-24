# frozen_string_literal: true

RSpec.describe Hash do
  it { expect(Hash).to be_respond_to(:of) }

  context ".of" do
    subject { Hash.of(Symbol, Array) }
    it { is_expected.to be_a DeepClassCompare::Matcher }
    it { expect { subject }.not_to raise_error }
    it { expect { subject.of(Object) }.to raise_error }
  end

  context "#like_a?" do
    context "should compare key and value class" do
      it "return true" do
        expect({a: []}).to be_like_a Hash.of(Symbol, Array)
        expect({'a' => 1}).to be_like_a Hash.of(String, Integer)
        expect({1 => :a}).to be_like_a Hash.of(Integer, Symbol)
        expect({[] => 'a'}).to be_like_a Hash.of(Array, String)
      end

      it "return false" do
        expect({a: []}).not_to be_like_a Hash.of(Array, String)
        expect({'a' => 1}).not_to be_like_a Hash.of(Symbol, Array)
        expect({1 => :a}).not_to be_like_a Hash.of(String, Integer)
        expect({[] => 'a'}).not_to be_like_a Hash.of(Integer, Symbol)
      end
    end

    context "should compare value only" do
      it "return true" do
        expect({a: []}).to be_like_a Hash.of(Array)
        expect({'a' => 1}).to be_like_a Hash.of(Integer)
        expect({1 => :a}).to be_like_a Hash.of(Symbol)
        expect({[] => 'a'}).to be_like_a Hash.of(String)
      end

      it "return false" do
        expect({a: []}).not_to be_like_a Hash.of(String)
        expect({'a' => 1}).not_to be_like_a Hash.of(Array)
        expect({1 => :a}).not_to be_like_a Hash.of(Integer)
        expect({[] => 'a'}).not_to be_like_a Hash.of(Symbol)
      end
    end

    context "should compare class chain by pass a matcher" do
      let(:params) do
        {
          a: %w(a b c),
          b: %w(a b c)
        }
      end
      it "return true" do
        expect(params).to be_like_a Hash.of(Symbol, Array.of(String))
      end

      it "return false" do
        expect(params).not_to be_like_a Hash.of(Symbol, Array.of(Hash))
      end
    end

    context "should compare with different types of values" do
      let(:params) do
        {
          a: %w(a b c),
          "b" => 123
        }
      end

      it "return true" do
        expect(params).to be_like_a Hash.of([Symbol, String], [Array.of(String), Integer])
      end

      it "return false" do
        expect(params).not_to be_like_a Hash.of([Symbol, Integer], [Array.of(String), Hash])
      end
    end
  end
end
