require 'rails_helper'

describe Category do
  it {should have_many :bills}
  it 'has valid attributes' do
    category = Category.create(name: 'example')
    expect(category.name).to eq('example')
  end
end
