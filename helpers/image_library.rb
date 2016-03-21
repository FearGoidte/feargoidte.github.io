def image_library(input)
  input = input.to_sym
  data.image_library.each do
    if data['image_library'][input]
      return data['image_library'][input][:name]
    end
  end
end
