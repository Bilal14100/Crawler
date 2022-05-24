class AmazonSerp < ApplicationRecord
  validates :url, presence: true, format: URI::regexp(%w[http https])
  scope :active, -> {where(active: true)}
end
