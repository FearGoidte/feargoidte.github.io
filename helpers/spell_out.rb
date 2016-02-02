def spell_out(value)
  begin
    value = value.to_i
  rescue Exception => e
    puts "#{e.class} #{e}"
    return value
  end
  unless value >= 0 && value < 11 then
    return value
  else
    return ['zero',
            'one',
            'two',
            'three',
            'four',
            'five',
            'six',
            'seven',
            'eight',
            'nine',
            'ten'][value]
  end
end
