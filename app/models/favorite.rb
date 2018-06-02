class Favorite < ApplicationRecord
  belongs_to :representative
  belongs_to :user
end
