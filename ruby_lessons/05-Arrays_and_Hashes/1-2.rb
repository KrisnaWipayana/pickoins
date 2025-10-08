tickets = [
  {
    id: 1,
    customer: { name: "Hans Schmidt", country: "DE" },
    valid_until: "2021-06-03",
    age_class: "adult",
    purchases: [
      { timestamp: "2021-05-30 12:30:33", status: "failed" },
      { timestamp: "2021-05-30 12:33:49", status: "complete" }
    ]
  },
  {
    id: 32,
    customer: { name: "Miyoko Takaguchi", country: "JP" },
    valid_until: "2021-06-05",
    age_class: "child",
    purchases: [
      { timestamp: "2021-05-29 18:30:33", status: "complete" }
    ]
  }
]

#print the time of the failed purchase of Hanss Schmidt's ticket
failed_time = tickets[0][:purchases].find { |p| p[:status] == "failed" }[:timestamp]
puts "Failed time of Hans Schmidt purchases: #{failed_time}"

#print the country of the second customer
country = tickets[1][:customer][:country]
puts "The country of the second customer: #{country}"

#ticket fixes
tickets[1][:customer][:country] = "TW"
tickets[1][:age_class] = "adult"
puts tickets

#purchase_history function
def purchase_history(tickets)
  history = {}
  tickets.each do |ticket|
    name = ticket[:customer][:name]
    statuses = ticket[:purchases].map { |p| p[:status] }
    history[name] = statuses
  end
  history
end
puts "Purchase history: #{purchase_history(tickets)}"