namespace :billtweets do

  desc "Do tweets"
  task :do_tweets => :environment do
    max_random_delay = ENV['max_delay']
    if max_random_delay
      Tweeter.make_tweets
      Tweeter.find('digiconbill').tweet(:max_delay => max_random_delay)
    else
      puts 'must supply max_random_delay'
      puts 'USAGE: rake billtweets:do_tweets max_delay=15'
    end
  end

end
