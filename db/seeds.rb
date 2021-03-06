@service ||= PropublicaService.new

rep1 = @service.get_url("/congress/v1/members/house/CO/1/current.json").first[:name]
  rep2 = @service.get_url("/congress/v1/members/house/CO/2/current.json").first[:name]
  rep3 = @service.get_url("/congress/v1/members/house/CO/3/current.json").first[:name]
  rep4 = @service.get_url("/congress/v1/members/house/CO/4/current.json").first[:name]
  rep5 = @service.get_url("/congress/v1/members/house/CO/5/current.json").first[:name]
  rep6 = @service.get_url("/congress/v1/members/house/CO/6/current.json").first[:name]
  rep7 = @service.get_url("/congress/v1/members/house/CO/7/current.json").first[:name]
@rep_names = [rep1, rep2, rep3, rep4, rep5, rep6, rep7]

def rep(district)
  @service.get_url("/congress/v1/members/house/CO/#{district}/current.json")
end

i=1
while i < 8
  if rep(i).first[:party] == 'D'
    party = 'Democrat'
  elsif rep(i).first[:party] == 'R'
    party = 'Republican'
  else
    party ='Other'
  end
  Representative.create(district: i,
                        name: rep(i).first[:name],
                        party: party,
                        facebook: rep(i).first[:facebook_account],
                        twitter: rep(i).first[:twitter_id]
                       )
  i += 1
end

def find_category(bill_id)
  id = bill_id.chomp('-115')
  if @service.get_url("/congress/v1/115/bills/#{id}.json").nil?
    0
  else
    subject_name = @service.get_url("/congress/v1/115/bills/#{id}.json").first[:primary_subject]
    category = Category.find_or_create_by(name: subject_name)
    category.id
  end
end

def vote(bill, name)
  response = @service.get_url("/congress/v1/115/house/sessions/1/votes/#{bill.roll_call}.json")
  positions = response[:votes][:vote][:positions]
  raw_rep_position = positions.select {|member| member[:name] == name}
  rep = Representative.find_by(name: name)
  vote_position = raw_rep_position.first[:vote_position]
  if bill.democratic_majority_position == bill.republican_majority_position && bill.republican_majority_position == vote_position
    rep.party
  elsif vote_position == bill.democratic_majority_position
    'Democrat'
  elsif vote_position == bill.republican_majority_position
    'Republican'
  else
    'Other'
  end
end

def build_bills(response)
  response[:votes].each do |vote|
    if vote[:bill][:bill_id].nil?
    elsif find_category(vote[:bill][:bill_id]) == 0
    else
    bill = Bill.create!(bill_id: vote[:bill][:bill_id],
                chamber: response[:chamber],
                year: response[:year],
                month: response[:month],
                congress: vote[:congress],
                roll_call: vote[:roll_call],
                name: vote[:bill][:title],
                democratic_majority_position: vote[:democratic][:majority_position],
                republican_majority_position: vote[:republican][:majority_position],
                category_id: find_category(vote[:bill][:bill_id])
                )
        @rep_names.each do |rep_name|
          RepVotes.create!(bill_id: bill.id, rep_name: rep_name, vote_with: vote(bill, rep_name) )
        end
      end
    end
  end

(1..9).each do |i|
  response = @service.get_url("/congress/v1/house/votes/2017/0#{i}.json")
  build_bills(response)
end
(10..12).each do |i|
  response = @service.get_url("/congress/v1/house/votes/2017/#{i}.json")
  build_bills(response)
end
