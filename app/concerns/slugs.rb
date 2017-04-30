require 'addressable'

module Slugs

  module FindSlug
    def find_by_slug(slug)
      reserved_slug = Addressable::URI.unencode(slug)
      spaced_slug = slug.tr('-', ' ')
      reserved_spaced_slug = Addressable::URI.unencode(spaced_slug)
      self.find_by('lower(name) = ? OR lower(name) = ?', reserved_slug, reserved_spaced_slug)
    end

    def deslug(name)
      name.split('-').maps{|word| word.capitalize}.join(' ')
    end
  end

  module MakeSlug
    def slug
      reserved_slug = self.name.tr(' ','-').tr('^A-Za-z0-9-+$&\.()','').downcase
      Addressable::URI.normalize_component(reserved_slug, Addressable::URI::CharacterClasses::UNRESERVED)
    end
  end
end
