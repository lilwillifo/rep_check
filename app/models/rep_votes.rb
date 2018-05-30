class RepVotes < ApplicationRecord
  enum vote_with: ["Dem", "Rep", "Other"]
end
