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
              republican_majority_position: vote[:republican][:majority_position]
              )
          end

rep1 = service.get_url("/congress/v1/members/house/CO/1/current.json").first[:name]
rep2 = service.get_url("/congress/v1/members/house/CO/2/current.json").first[:name]
rep3 = service.get_url("/congress/v1/members/house/CO/3/current.json").first[:name]
rep4 = service.get_url("/congress/v1/members/house/CO/4/current.json").first[:name]
rep5 = service.get_url("/congress/v1/members/house/CO/5/current.json").first[:name]
rep6 = service.get_url("/congress/v1/members/house/CO/6/current.json").first[:name]
rep7 = service.get_url("/congress/v1/members/house/CO/7/current.json").first[:name]
reps = [rep1, rep2, rep3, rep4, rep5, rep6, rep7]


def vote(roll_call, name)
  response = get_url("/congress/v1/115/house/sessions/1/votes/#{@roll_call}.json")
  positions = response[:votes][:vote][:positions]
  raw_rep_position = positions.select {|member| member[:name] == name}
  vote_position = raw_rep_position.first[:vote_position]
end

reps.each do |rep_name|
  Bill.all.each do |bill|
    RepVotes.create(bill_id: bill.id, rep_name: rep_name, vote_with: vote(bill.roll_call, rep_name) )
  end
end
