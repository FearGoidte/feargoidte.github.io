def ordinal(value)
  begin
    value = value.to_i
  end
  suffixes = ['th', 'st', 'nd', 'rd', 'th', 'th', 'th', 'th', 'th', 'th']
  unless [11, 12, 13].include? value % 100 then
    suffix = suffixes[value % 10]
  else
    suffix = suffixes[0]
  end
  "#{value}<sup>%s</sup>" % suffix
end
