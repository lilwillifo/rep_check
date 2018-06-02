require 'rails_helper'

describe Favorite do
  it {should belong_to :representative}
  it {should belong_to :user}
end
