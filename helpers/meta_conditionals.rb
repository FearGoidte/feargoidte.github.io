def meta_title
  meta_title = if @title
                 @title
               elsif current_resource.data.title
                 current_resource.data.title
               else
                 data.settings.site.name
               end
  meta_title = strip_tags(meta_title)
  meta_title
end

def meta_description
  meta_description = if @description
                       @description
                     elsif current_resource.data.description
                       current_resource.data.description
                     else
                       data.settings.site.description
                     end
  meta_description = strip_tags(meta_description)
  meta_description
end
