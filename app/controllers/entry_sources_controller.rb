class EntrySourcesController < ResourceController::Base

  def news_sources
    @type = 'News'
    @entry_sources = NewsSource.all.sort_by(&:item_title_name)
    render 'index'
  end

  def blog_sources
    @type = 'Blog'
    @entry_sources = BlogSource.all.sort_by(&:item_host_uri)
    render 'index'
  end

  def government_sources
    @type = 'Government'
    @entry_sources = GovernmentSource.all.sort_by(&:item_host_uri)
    render 'index'
  end

  def parliament_sources
    @type = 'Parliament'
    @entry_sources = ParliamentSource.all.sort_by(&:item_host_uri)
    render 'index'
  end

end
