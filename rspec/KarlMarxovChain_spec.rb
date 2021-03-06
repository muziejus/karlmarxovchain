require_relative '../KarlMarxovChain'

RSpec.describe KarlMarxovChain do

  let(:kmc) { KarlMarxovChain.new }

  describe '#initialize' do
    context "when configs.yml is available" do
      it "finds configs.yml" do
        expect(File.exists?("configs.yml")).to eq(true)
      end

      it "assigns @configs" do
        expect(kmc.instance_variable_get(:@configs)).to_not be_nil
      end

      it "assigns @since_id" do
        expect(kmc.instance_variable_get(:@since_id)).to_not be_nil
      end

      it "assures that @since_id is an integer" do
        expect(kmc.instance_variable_get(:@since_id)).to be_an_integer
      end
    end

    context "when configs.yml is unavailable" do
      it "errors out usefully" do
        allow(File).to receive(:exists?).with("configs.yml").and_return(false)
        expect { KarlMarxovChain.new }.to raise_error RuntimeError
      end
    end
  end

  describe '#random_sentence' do

    subject(:random_sentence) { kmc.random_sentence }

    context "when dictionaries are available" do
      it "assigns @dictionary" do
        random_sentence
        expect(kmc.instance_variable_get(:@dictionary)).to_not be_nil
      end

      it "creates a string" do
        expect(random_sentence).to be_instance_of String
      end

      it "that is no more than 140 characters long" do
        expect(random_sentence.length).to be > 4
        # expect(random_sentence.length).to be < 140
      end

      it "that is capitalized" do
        if random_sentence[0] =~ /\w/
          expect(random_sentence[0]).to match(/[[:upper:]]/)
        else
          true # Assuming it's a “ or some such.
        end
      end
    end

    context "when dictionaries are not available" do
      it "errors out usefully" do
        allow(File).to receive(:exists?).with("capital.mmd").and_return(false)
        expect { random_sentence }.to raise_error
      end
    end
  end

  describe "#set_triple_array" do
    it "assigns @triple_array" do
      kmc.set_triple_array
      expect(kmc.instance_variable_get(:@triple_array)).to_not be_nil
    end

    it "which is an array" do
      kmc.set_triple_array
      expect(kmc.instance_variable_get(:@triple_array)).to be_an_instance_of Array
    end
    context "when dictionaries are not available" do
      it "errors out usefully" do
        allow(File).to receive(:exists?).with("capital.txt").and_return(false)
        expect { kmc.set_triple_array }.to raise_error
      end
    end

  end

  describe "#build_sentence" do
    context "when the term exists" do
      subject(:build_sentence) { kmc.build_sentence "England" }

      it "builds a sentence that is no more than 120 characters" do
        expect(build_sentence.length).to be < 120
      end
      it "that begins with the term provided" do
        expect(build_sentence).to match(/^.{0,1}England/)
      end
    end

    context "when the term does not exist" do
      it "produces a useful warning sentence" do
        expect(kmc.build_sentence("Zygmorf")).to eq "Your term (Zygmorf) produced nothing, unlike an exploited worker."
      end
    end

  end

  describe "#add_to_sentence"
  describe "#replies"
  describe "#update_since_id"
  describe "#tweet"

end
