# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
service ||= PropublicaService.new
response = service.get_url("/congress/v1/house/votes/2017/01.json")
Bill.create(bill_id: response[:votes].first[:bill][:bill_id],
            chamber: response[:chamber],
            year: response[:year],
            month: response[:month],
            congress: response[:votes].first[:congress],
            roll_call: response[:votes].first[:roll_call],
            name: response[:votes].first[:bill][:title],
            democratic_majority_position: response[:votes].first[:democratic][:majority_position],
            republican_majority_position: response[:votes].first[:republican][:majority_position],
            )
