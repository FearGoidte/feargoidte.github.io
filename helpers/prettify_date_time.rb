def prettify_date(date)
  number = date.day.ordinalize
  ordinal = number.slice!(-2, 2)
  "#{date.strftime('%A')}, #{number}<sup>#{ordinal}</sup>
  #{date.strftime('%B %Y')}"
end

def prettify_date_time(date_time)
  number = date_time.day.ordinalize
  ordinal = number.slice!(-2, 2)
  "#{date_time.strftime('%A')}, #{number}<sup>#{ordinal}</sup>
  #{date_time.strftime('%B %Y')} at
  #{date_time.strftime('%H:%M')} (#{Time.zone.name})"
end
