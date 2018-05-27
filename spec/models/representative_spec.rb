require 'spec_helper'
require './app/models/representative'
require './app/services/propublica_service'
require 'JSON'
require 'faraday'
require 'pry'

describe Representative, type: :model do
  it 'exists' do
    representative = Representative.new(1)
    expect(representative).to be_a Representative
  end
  it 'has valid attributes' do
    representative = Representative.new(1)
    expect(representative.name).to be_a String
    expect(representative.party).to be_a String
    expect(representative.facebook).to be_a String
    expect(representative.twitter).to be_a String
    expect(representative.email).to be_a String
    expect(representative.website).to be_a String
    expect(representative.image).to be_a String
  end
end
