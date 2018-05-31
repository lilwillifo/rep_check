class RepVotes < ApplicationRecord
  belongs_to :bill
  enum vote_with: ["Dem", "Rep", "Other"]
end
