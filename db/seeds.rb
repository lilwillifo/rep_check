# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
service ||= PropublicaService.new
response = service.get_url("/congress/v1/house/votes/2017/01.json")
response[:votes].each do |vote|
  Bill.create(bill_id: if vote[:bill][:bill_id].nil?
                          ''
                          else
                            vote[:bill][:bill_id]
                          end,
              chamber: response[:chamber],
              year: response[:year],
              month: response[:month],
              congress: vote[:congress],
              roll_call: vote[:roll_call],
              name: vote[:bill][:title],
              democratic_majority_position: vote[:democratic][:majority_position],
              republican_majority_position: vote[:republican][:majority_position],
              )
          end
