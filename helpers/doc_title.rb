def doc_title
  seperator = '—'
  site_name = data.settings.site.name
  if @title
    page_title = @title
  elsif current_resource.data.title
    page_title = current_resource.data.title
  end
  if page_title
    page_title + seperator + site_name
  else
    return site_name
  end
end
