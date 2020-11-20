module Sections
  class HeaderComponent < ViewComponent::Base
    attr_accessor :title, :image, :mobile_image

    def initialize(front_matter)
      front_matter.with_indifferent_access.tap do |fm|
        @title        = fm["title"]
        @image        = fm["image"]
        @mobile_image = fm["mobileimage"] || false
      end
    end

    def responsive_image
      image_sizes = [%(#{image_path} 800w)]
      image_sizes << %(#{mobile_image_path} 600w) if mobile_image.present?

      image_tag(image_path, srcset: image_sizes.join(", "), alt: "Student in a classroom")
    end

  private

    def image_path
      helpers.hero_image_path(image)
    end

    def mobile_image_path
      helpers.hero_image_path(mobile_image)
    end
  end
end
