namespace :billtweets do

  desc "Do tweets"
  task :do_tweets => :environment do
    max_random_delay = ENV['max_delay']
    if max_random_delay
      %w[equalitybilluk digiconbill].each do |bill|
        tweeter = Tweeter.find(bill)
        if bill == 'digiconbill'
          tweeter.do_search
          tweeter.make_tweets
        end
        tweeter.tweet(:max_delay => max_random_delay)
      end
    else
      puts 'must supply max_random_delay'
      puts 'USAGE: rake billtweets:do_tweets max_delay=15'
    end
  end

end
