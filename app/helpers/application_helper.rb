# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def link_to_bill bills, titles, index
    link_to_if(bills[index].tweeter, titles[index], bills[index].tweeter)
  end
end
