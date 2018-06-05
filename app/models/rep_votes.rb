class RepVotes < ApplicationRecord
  belongs_to :bill
  enum vote_with: ["Democrat", "Republican", "Other"]
end
