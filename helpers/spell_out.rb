def spell_out(value)
  value = value.to_i
  if value >= 0 && value < 11
    return %w(zero one two three four five six seven eight nine ten)[value]
  else
    return value
  end
end
