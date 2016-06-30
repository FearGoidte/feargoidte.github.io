def make_reference(ref)
  if current_article.data.reference[ref]
    url = current_article.data.references[ref]
    title = tag :span, property: 'dcterms:title' do
      current_article.data.references[ref].title
    end
  end
  date = tag :time, datetime: current_article.data.references[ref].date, property: 'dcterms:date' do
    prettify_date(current_article.data.references[ref].date)
  end
  creator = tag :span, property: 'dcterms:creator', typeof: 'foaf:Person' do
    tag :span, property: 'foaf:name' do
      current_article.data.references[ref].creator
    end
  end
  publisher = tag :span, property: 'dcterms:publisher', typeof: 'foaf:Organization' do
    tag :span, property: 'foaf:name' do
      current_article.data.references[ref].publisher
    end
  end
  tag :cite, typeof: 'http://purl.org/dc/dcmitype/Text foaf:Document', property: 'dcterms:references dcterms:bibliographicCitation', resource: url do
    link_to url, url, property: 'dcterms:identifier' do
      if creator
        ' by ' + creator
      elsif publisher
        ' from ' + publisher
      elsif creator && publisher
        ' by ' + creator + ' from ' + publisher
      end
      title
      ', ' + date if date
    end
  end
end
