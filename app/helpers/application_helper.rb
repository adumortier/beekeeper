module ApplicationHelper

   # Creates a link to sort a collection.
  def sortable(season, column, title = nil)
    query_params = request.GET.deep_symbolize_keys
    title ||= column.titleize

    direction = query_params[:direction] == 'asc' ? 'desc' : 'asc'
    query_params[:season] = season
    query_params[:sort] = column
    query_params[:direction] = direction

    link_to title, query_params
  end

end
