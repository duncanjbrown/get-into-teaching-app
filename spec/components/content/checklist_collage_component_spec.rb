require "rails_helper"

describe Content::ChecklistCollageComponent, type: :component do
  subject(:render) do
    render_inline(component)
    page
  end

  let(:checklist) do
    [
      "A range of career paths",
      "Subject specialist, leadership and pastoral opportunities",
      "Flexible and secure",
    ]
  end
  let(:image_paths) do
    [
      "media/images/content/is-teaching-right-for-me/Physics_MissHayre_4.jpg",
      "media/images/content/is-teaching-right-for-me/History_Class_1.jpg",
      "media/images/content/is-teaching-right-for-me/Maths_MrAhmed_1.jpg",
    ]
  end
  let(:cta) do
    {
      text: "Explore career development options",
      link: "/",
    }
  end

  let(:component) { described_class.new(checklist: checklist, image_paths: image_paths, cta: cta) }

  it { is_expected.to have_css(".checklist-collage") }
  it { is_expected.to have_link(cta[:text], href: cta[:link]) }

  it "renders the checlist items" do
    checklist.each do |item|
      is_expected.to have_css("ul li", text: item)
    end
  end

  it "renders the images" do
    image_paths.each do |path|
      filename = path.split(".").first
      is_expected.to have_css("img[src*='#{filename}']")
    end
  end
end
