def spell_out(value) # Spell out whole-number words for one to ten; use  gures for numbers above ten. Based upon ‘jekyll-humanize’—https://github.com/23maverick23/jekyll-humanize
  begin
	value = value.to_i
  rescue Exception => e
	puts "#{e.class} #{e}"
	return value
  end
  unless value >= 0 and value < 11 then
	return value
  else
	return ["zero", "one", "two", "three", "four", "five", "six",
	  "seven", "eight", "nine", "ten"][value]
  end
end #End apnumber