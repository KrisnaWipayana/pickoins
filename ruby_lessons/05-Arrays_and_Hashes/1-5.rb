ticket =
{ ticket_number: '2982343298238',
  type_class: '2day',
  age_class: 'child',
  purchase_date: '2021-05-05'
}

def make_ticket_code(ticket)
    age_short = ticket[:age_class] == 'adult' ? 'a' : 'c'

    type_short = case ticket[:type_class]
               when '1day'
                '1d'
               when '2day'
                '2d'
               when '10hours'
                '10h'
               when '6hours'
                '6h'
               else ticket[:type_class]
               end

    "#{ticket[:ticket_number]}|#{age_short}|#{ticket[:purchase_date]}|#{type_short}"
end

puts make_ticket_code(ticket)