require "rails_helper"

RSpec.describe Search do
  include_context "use fixture markdown pages"

  describe "#results" do
    subject { described_class.new(search).results }

    context "with keyword matching single result" do
      let(:search) { "returners" }

      it { is_expected.to have_attributes length: 1 }
      it { is_expected.to include "/first" }
    end

    context "with keyword matching multiple results" do
      let(:search) { "teaching" }

      it { is_expected.to have_attributes length: 2 }
      it { is_expected.to include "/second" }
      it { is_expected.to include "/third" }
    end

    context "with partial keyword match" do
      let(:search) { "teach" }

      it { is_expected.to have_attributes length: 3 }
      it { is_expected.to include "/first" }
      it { is_expected.to include "/second" }
      it { is_expected.to include "/third" }
    end

    context "with mismatched case" do
      let(:search) { "tEaCh" }
      it { is_expected.to have_attributes length: 3 }
      it { is_expected.to include "/first" }
      it { is_expected.to include "/second" }
      it { is_expected.to include "/third" }
    end

    context "with keyword matching no results" do
      let(:search) { "nomatch" }

      it { is_expected.to be_empty }
    end

    context "with blank keyword" do
      let(:search) { "" }

      it { is_expected.to be_nil }
    end

    context "with nil keyword" do
      let(:search) { nil }

      it { is_expected.to be_nil }
    end
  end
end
