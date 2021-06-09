require "rails_helper"

RSpec.describe Search do
  include_context "use fixture markdown pages"

  describe "#results" do
    subject { described_class.new(search: search).results }

    context "with keyword matching single result" do
      let(:search) { "returners" }

      it { is_expected.to have_attributes length: 1 }
      it { is_expected.to include(a_hash_including(path: "/first")) }
    end

    context "with keyword matching multiple results" do
      let(:search) { "teaching" }

      it { is_expected.to have_attributes length: 2 }
      it { is_expected.to include(a_hash_including(path: "/second")) }
      it { is_expected.to include(a_hash_including(path: "/third")) }
    end

    context "with partial keyword match" do
      let(:search) { "teach" }

      it { is_expected.to have_attributes length: 3 }
      it { is_expected.to include(a_hash_including(path: "/first")) }
      it { is_expected.to include(a_hash_including(path: "/second")) }
      it { is_expected.to include(a_hash_including(path: "/third")) }
    end

    context "with mismatched case" do
      let(:search) { "tEaCh" }
      it { is_expected.to have_attributes length: 3 }
      it { is_expected.to include(a_hash_including(path: "/first")) }
      it { is_expected.to include(a_hash_including(path: "/second")) }
      it { is_expected.to include(a_hash_including(path: "/third")) }
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

    context "with numeric keyword" do
      let(:search) { "2000" }

      it { is_expected.to include(a_hash_including(path: "/second")) }
    end

    context "with search term matching partially page title" do
      let(:search) { "sec" }

      it { is_expected.to have_attributes length: 1 }
      it { is_expected.to include(a_hash_including(path: "/second")) }
    end

    context "with search term matching word later in title" do
      let(:search) { "wor" }

      it { is_expected.to have_attributes length: 2 }
      it { is_expected.to include(a_hash_including(path: "/page1")) }
      it { is_expected.to include(a_hash_including(path: "/subfolder/page2")) }
    end

    context "with search term starting in the middle of a word" do
      let(:search) { "ello" }

      it { is_expected.to be_empty }
    end

    context "when the search term is not a string" do
      let(:search) { 2021 }

      it { is_expected.to be_empty }
    end

    describe "non-content pages" do
      describe "events" do
        Search::NON_CONTENT_PAGES.dig("/events", :keywords).each do |kw|
          describe kw do
            let(:search) { kw }

            it "finds the events page when searching for #{kw}" do
              expect(subject).to include(a_hash_including(path: "/events"))
            end
          end
        end
      end
    end
  end
end
