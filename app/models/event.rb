class Event < ApplicationRecord
  def self.search_by(search_term)
    where("LOWER(title) LIKE :search_term OR
          LOWER(source) LIKE :search_term OR
          CAST(date AS text) LIKE :search_term OR
          LOWER(place) LIKE :search_term",
          search_term: "#{search_term.downcase}%")
  end
end
