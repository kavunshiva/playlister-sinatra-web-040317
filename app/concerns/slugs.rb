require 'addressable'

module Slugs

  module FindSlug
    def find_by_slug(slug)
      self.find do |instance|
        decode(instance.slug) == slug
      end
    end

    private

    def decode(slug)
      Addressable::URI.unencode(slug)
    end
  end

  module MakeSlug
    def slug
      url_safe_name = Addressable::URI.normalize_component(
        self.name.downcase,
        Addressable::URI::CharacterClasses::UNRESERVED
      )
      url_safe_name
        .split('%20').join('-') # slugify
    end
  end
end
