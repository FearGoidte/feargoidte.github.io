def doc_title
  seperator = '—'
  site_name = data.settings.site.name
  if @title
    @title + seperator + site_name
  elsif current_resource.data.title
    current_resource.data.title + seperator + site_name
  else
    site_name
  end
end
