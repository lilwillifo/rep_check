@service ||= PropublicaService.new

rep1 = @service.get_url("/congress/v1/members/house/CO/1/current.json").first[:name]
  rep2 = @service.get_url("/congress/v1/members/house/CO/2/current.json").first[:name]
  rep3 = @service.get_url("/congress/v1/members/house/CO/3/current.json").first[:name]
  rep4 = @service.get_url("/congress/v1/members/house/CO/4/current.json").first[:name]
  rep5 = @service.get_url("/congress/v1/members/house/CO/5/current.json").first[:name]
  rep6 = @service.get_url("/congress/v1/members/house/CO/6/current.json").first[:name]
  rep7 = @service.get_url("/congress/v1/members/house/CO/7/current.json").first[:name]
rep_names = [rep1, rep2, rep3, rep4, rep5, rep6, rep7]

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
  vote_position = raw_rep_position.first[:vote_position]
  if vote_position == bill.democratic_majority_position
    'Dem'
  elsif vote_position == bill.republican_majority_position
    'Rep'
  else
    'Other'
  end
end

response = @service.get_url("/congress/v1/house/votes/2017/01.json")

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
      rep_names.each do |rep_name|
        RepVotes.create!(bill_id: bill.id, rep_name: rep_name, vote_with: vote(bill, rep_name) )
      end
    end
    end

#GovTrack Categories
# category_1 = Category.create(name: 'Agriculture and Food')
#   category_2 = Category.create(name: 'Animals')
#   category_3 = Category.create(name: 'Armed Forces and National Security')
#   category_4 = Category.create(name: 'Arts, Culture, Religion')
#   category_5 = Category.create(name: 'Civil Rights and Liberties, Minority Issues')
#   category_6 = Category.create(name: 'Commerce')
#   category_7 = Category.create(name: 'Crime and Law Enforcement')
#   category_8 = Category.create(name: 'Education')
#   category_9 = Category.create(name: 'Emergency Management')
#   category_10 = Category.create(name: 'Energy')
#   category_11 = Category.create(name: 'Environmental Protection')
#   category_12 = Category.create(name: 'Families')
#   category_13 = Category.create(name: 'Finance and Financial Sector')
#   category_14 = Category.create(name: 'Foreign Trade and International Finance')
#   category_15 = Category.create(name: 'Geographic Areas, Entities, and Committees')
#   category_16 = Category.create(name: 'Government Operations and Politics')
#   category_17 = Category.create(name: 'Health')
#   category_18 = Category.create(name: 'Housing and Community Development')
#   category_19 = Category.create(name: 'Immigration')
#   category_20 = Category.create(name: 'International Affairs')
#   category_21 = Category.create(name: 'Labor and Employment')
#   category_22 = Category.create(name: 'Law')
#   category_23 = Category.create(name: 'Native Americans')
#   category_24 = Category.create(name: 'Private Legislation')
#   category_25 = Category.create(name: 'Public Lands and Natural Resources')
#   category_26 = Category.create(name: 'Science, Technology, Communications')
#   category_27 = Category.create(name: 'Social Sciences and History')
#   category_28 = Category.create(name: 'Social Welfare')
#   category_29 = Category.create(name: 'Sports and Recreation')
#   category_30 = Category.create(name: 'Taxation')
#   category_31 = Category.create(name: 'Transportation and Public Works')
#   category_32 = Category.create(name: 'Water Resources Development')
