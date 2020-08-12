class Quote < ApplicationRecord
  extend FriendlyId
  friendly_id :tag, use: :slugged
end
