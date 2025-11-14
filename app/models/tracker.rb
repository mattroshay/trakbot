class Tracker < ApplicationRecord
  belongs_to :user

  validates :link, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: "must be a valid URL" }
  validates :description, presence: true, length: { minimum: 3, maximum: 500 }
end
