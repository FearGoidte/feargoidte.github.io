def doc_title
  seperator = '—'
  site_title = data.settings.site.name
  if @title
    page_title = @title
  elsif current_resource.data.title
    page_title = current_resource.data.title
  end
  if page_title
    page_title << seperator << site_title
  else
    return site_title
  end
end
