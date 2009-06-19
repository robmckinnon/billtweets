# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :authenticate

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def render_not_found message='Page not found.'
    @title = "Page cannot be found (404 error)"
    @crumbtrail = "Error: page cannot be found"
    render :template => 'public/404.html', :status => 404
  end

  def tidy item
    text = item.content.gsub('<p>',' ').gsub('</p>',' ').gsub('<font size="-1">',' ').gsub('</font>',' ')
    "#{text} [#{item.title}]"
  end

  def index
    @bills = Bill.all.sort_by(&:stories_count).reverse

    # %w[zeroist first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelveth thirteenth fourteenth fifteenth sixteenth seventeenth eighteenth ninteenth twentyth]
    # %w[zeroist first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelveth thirteenth fourteenth fifteenth sixteenth seventeenth eighteenth ninteenth twentyth]

    @titles = @bills.collect(&:name)
    # [0..((x.news_items.last.content.size * (1 / ((@bills.index(x) + 1) / (@bills.size.to_f / 10) ) ) ).to_i)]
    @texts = @bills.collect do |x|
      stuff = if x.news_items.empty?
        'empty'
      elsif x.news_items.size == 1
        tidy(x.news_items.last)
      else
        "#{tidy(x.news_items[x.news_items.size - 2])}</p><p>#{tidy(x.news_items.last)}"
      end
      "<p>#{ stuff }</p><p>[#{x.description}]</p>"
    end

    render :template => 'newspaper2.html.haml'
  end

  def authenticate
    if RAILS_ENV == 'production'
      auth = YAML.load_file(RAILS_ROOT+'/config/auth.yml')
      auth.symbolize_keys!
      authenticate_or_request_with_http_basic do |id, password|
        id == auth[:user] && password == auth[:password]
      end
    end
  end

end
