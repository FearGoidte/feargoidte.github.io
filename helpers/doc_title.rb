def doc_title
  separator = '—'
  site_name = data.settings.site.name
  if @title
    @title + separator + site_name
  elsif current_resource.data.title
    current_resource.data.title + separator + site_name
  else
    site_name
  end
end
