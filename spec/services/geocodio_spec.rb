require 'rails_helper'

describe GeocodioService do
  context 'instance methods' do
    describe "district" do
      it "returns district for a given address" do
        VCR.use_cassette("find_district") do
          address = '1271 S Marshall St Denver, CO 80232'

          expect(GeocodioService.new(address).district).to eq(7)
        end
      end
    end
  end
end
