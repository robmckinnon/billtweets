class EntrySourcesController < ResourceController::Base

  def news_sources
    @type = 'News'
    @entry_sources = NewsSource.all
    render 'index'
  end

  def blog_sources
    @type = 'Blog'
    @entry_sources = BlogSource.all
    render 'index'
  end

  def government_sources
    @type = 'Government'
    @entry_sources = GovernmentSource.all
    render 'index'
  end

  def parliament_sources
    @type = 'Parliament'
    @entry_sources = ParliamentSource.all
    render 'index'
  end
end
