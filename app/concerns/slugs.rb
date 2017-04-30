require 'addressable'

module Slugs

  module FindSlug
    def find_by_slug(slug)
      self.find_by('lower(name) = ?', deslug(slug))
    end

    private

    def deslug(slug)
      Addressable::URI
        .unencode(slug)
        .split('-').join(' ') # deslugify
        .split('%2D').join('-') # decode hyphens in name
    end
  end

  module MakeSlug
    def slug
      safe_name = Addressable::URI.normalize_component(
        self.name.downcase,
        Addressable::URI::CharacterClasses::UNRESERVED
      )
      safe_name
        .split('-').join('%2D') # encode hyphens in name
        .split('%20').join('-') # slugify
    end
  end
end
