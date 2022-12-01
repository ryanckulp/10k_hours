
# 10K Hours To...

a side project changelog by [Ryan Kulp](https://www.ryanckulp.com) with a time- and dollar-spent tracker for new skill development.

![10khours-example-website](https://user-images.githubusercontent.com/3083888/204370072-809d1a5e-99a7-4ac0-857a-02becbd090f0.png)

source: [example website](https://ranch.ryanckulp.com)

## Want your own 10kHoursTo instance?

great! you have 2 options.

either deploy this code for free to your own server (instructions below), or pay a one time fee of $99 for a managed instance.

**the managed instance includes lifetime access and all future bugfixing + feature updates, free.**

## Managed service quickstart

1. [go here](https://buy.stripe.com/5kA03QdFnacg9IQ7ss) (CC) or [here](https://py.pl/GQOIe) (Paypal) to pay $99
2. we'll send access details to the email used at payment
3. you'll be able to set up a custom domain, etc after logging in

## Self-service deploy
10kHoursTo is a Rails 7 application with minimal dependencies. it follows modern Rails conventions and has a simple database architecture (Users, Posts), akin to a blog.

to deploy your own instance, first get the application up and running locally. this is necessary for determining a few parameters: environment secrets and asset storage locations.

## Installation
1. clone the repo
2. `cd ten_k_hours && bundle` (installs dependencies)
3. `bundle exec figaro install` (generates empty secrets file)
4. `cp config/application-sample.yml config/application.yml` (put secrets / ENV vars here)

update the values inside `config/application.yml` to your liking.

5. `rails db:setup` (creates the database)

## Development
```sh
bin/dev # uses foreman gem to boot server, frontend, and bg job queue
```

## Testing

make sure you have firefox installed (https://firefox.com)
```
bundle exec rspec # runs all tests inside spec/
bundle exec rspec spec/dir_name # runs all tests inside given directory
```

## Deploying

where you deploy the application will dictate whether you need additional configurations.

if deploying to Heroku.com you'll need an AWS S3 "bucket" for asset storage due to Heroku's [ephimeral filesystem](https://devcenter.heroku.com/articles/dynos#ephemeral-filesystem).

if you're deploying somewhere else (e.g. Digital Ocean), ignore the directions below and deploy. no additional configuration is needed, and assets will be stored locally on your server.

## Deploying (Heroku.com)

**Step 1 - add AWS**

add `gem 'aws-sdk-s3', require: false` to your Gemfile and `bundle`.

add and set values for `AMAZON_S3_SECRET` and `AMAZON_S3_ACCESS_KEY` to `config/application.yml`. create these inside the AWS console > Credentials.

create an S3 "bucket" and paste + configure the following as `config/storage.yml`:

```yml
test:
  service: Disk
  root: <%= Rails.root.join("tmp/storage") %>

local:
  service: Disk
  root: <%= Rails.root.join("storage") %>

amazon:
  service: S3
  access_key_id: <%= ENV['AMAZON_S3_ACCESS_KEY'] %>
  secret_access_key: <%= ENV['AMAZON_S3_SECRET'] %>
  region: insert-aws-region-here # e.g. us-east-2
  bucket: insert-bucket-name-here # e.g. 10khours-prod
```

**Step 2 - point storage to AWS**

inside the `Post` model, adjust the `has_rich_text` field to:

`has_rich_text :content, service: (Rails.env.production? ? :amazon : :local)`

inside `config/environments/production.rb`, update the `config.active_storage` line to:

`config.active_storage.service = :amazon`

**Step 3 - create an app on Heroku**

in the Heroku user interface, make a new app with whatever name you'd like. you can also do `heroku create <app-name>` via the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli).

link this app with your source code by going to the root directory of the code in your terminal, then:

`heroku git:remote -a heroku_app_name_here # you only need to do this once`

**Step 4 - add environment variables to Heroku**

`figaro heroku:set -e production # do this whenever you change or add new ENV vars`

**Step 5 - deploy to Heroku**

```sh
git push heroku master # deploys master branch
git push heroku some_branch_name:master # deploys non-master branch
```

**note**: Heroku must have 1 'dyno' enabled. the $5-7 `web` dyno resource is sufficient.

## Feature requests

contributions and requests are welcome. just [make a new Issue](https://github.com/ryanckulp/10k_hours/issues/new). you can also ping me at [@ryanckulp](https://twitter.com/ryanckulp).
