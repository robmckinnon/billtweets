class Tweet < ActiveRecord::Base

  belongs_to :entry_item
  belongs_to :tweeter

  def display_message
    if message.size > 140
      message.sub(entry_item.url, 'http://bit.ly/15mmkk')
    else
      message
    end
  end
end
