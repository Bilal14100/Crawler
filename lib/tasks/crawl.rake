namespace :crawl do
  desc "it will craw products from amazon"
  task amazon: :environment do
    puts "Rake task to crawl products from amazon has started"
    AmazonSerp.active.each do |page|
      puts "Adding for #{page.url}"
      CrawlJob.perform_later(page)
    end
  end

end
