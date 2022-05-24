# ProxyCrawl Test

This is a test project to crawl Amazon SERP. I'm using Nokogiri to parse html pages along with ProxyCrawler.

## Instructions

1. Clone/fork this repository.
2. `cd path/to/repo`
3. `rails db:create`
4. `rails db:migrate`
5. `rails db:seed`
### Testing
I have used FactoryBot, Faker and rspec to run test you can run tests with `rspec`
### Cron Job
I have used whenever gem to add cron jobs but you can use it by running `whenever --update-crontab --set environment='development'` or you can just update crontab and add `0 10 * * 1 /bin/bash -l -c 'cd /home/bilal/learning/proxycrawl-interview-test && RAILS_ENV=development bundle exec rake crawl:amazon --silent >> /home/bilal/learning/proxycrawl-interview-test/config/log/cron.log 2>&1'`it will add a background job for each url in the database.
### Running Background Jobs
I'm using delayed jobs as active jobs adaptor you will need to run `rails jobs:work` to run background jobs.
### API Documentation
1. Start rails server with `rails s`
2. Go to `http://localhost:3000/apipie`
postman collection is also attached please have a look.
