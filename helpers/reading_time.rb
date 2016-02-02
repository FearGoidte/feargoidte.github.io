def reading_time(input)
  begin
    words_per_minute = 180
    words = input.split.size
    minutes = (words / words_per_minute).to_i
  end
  if minutes <= 1
    return 'less than one minute'
  elsif minutes > 0 && minutes < 2
    return 'about one minute'
  elsif minutes >= 2 && minutes < 10
    return ['zero',
            'one',
            'two',
            'three',
            'four',
            'five',
            'six',
            'seven',
            'eight',
            'nine'][minutes] + ' minutes'
  else
    " #{minutes} minutes"
  end
end
