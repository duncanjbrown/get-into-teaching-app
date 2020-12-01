require "rails_helper"

describe Navbar::NavbarComponent, type: "component" do
  let(:all_frontmatter) do
    { "/mock-path" => { title: "Mock title", navigation: 20 } }
  end

  before do
    allow(Pages::Frontmatter).to receive(:list).and_return all_frontmatter
  end

  subject! { render_inline(Navbar::NavbarComponent.new(all_frontmatter)) }

  describe "Desktop navbar component" do
    context "when rendered" do
      it "shows background colour on link that matches the current page" do
        expect(page).to have_css("li.active") do |active_li|
          expect(active_li).to have_link("Home", href: "/")
        end
      end

      it "shows no background colour on links that do not match the current page" do
        page.all(".navbar__desktop li.active", count: 1)
      end
    end
  end
end
