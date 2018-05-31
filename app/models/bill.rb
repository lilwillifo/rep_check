class Bill < ApplicationRecord
  has_many :rep_votes, class_name: 'RepVotes'
end
