json._links do
  json.first_page "#{url}?page=#{data.current_page}"
  json.prev_page "#{url}?page=#{data.current_page - 1}" if (data.current_page > 1)

  json.current_page "#{url}?page=#{data.current_page}"

  json.next_page "#{url}?page=#{data.current_page + 1}" if data.next_page
  json.last_page "#{url}?page=#{data.total_pages}"
end

json._meta do
  json.page data.current_page
  json.per_page base_class.per_page
  json.count data.length
  json.total_count data.count
  json.total_pages data.total_pages
end
