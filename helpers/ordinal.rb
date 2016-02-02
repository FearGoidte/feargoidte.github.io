def ordinal(value)
  begin
    value = value.to_i
  end
  suffixes = %w(th st nd rd th th th th th th)
  suffix = if [11, 12, 13].include? value % 100
             suffixes[0]
           else
             suffixes[value % 10]
           end
  format("#{value}<sup>%s</sup>", suffix)
end
