# 10K Hours To...

a side project tracker by [Ryan Kulp](https://www.ryanckulp.com) that provides a simple changelog for contextual updates, as well as simple time- and dollar-tracking for skill development.

## Want your own 10kHoursTo instance?

two options. either deploy this code to your own server (instructions below), or pay $99 one-time for a managed instance on a server controlled by Ryan Kulp.

## Installation
1. clone the repo
2. `cd ten_k_hours && bundle` (installs dependencies)
3. `bundle exec figaro install`
4. `cp config/application-sample.yml config/application.yml` (put ENV vars here)

## Development
```sh
bin/dev # uses foreman to boot server, frontend, and bg job queue
```

## Testing
```
bundle exec rspec # run all tests inside spec/
bundle exec rspec spec/dir_name # run all tests inside given directory
```

## Deploying
if you choose to deploy to Heroku.com:

```sh
figaro heroku:set -e production # you only need to do this once
heroku git:remote -a heroku_app_name_here # you only need to do this once
```

```sh
git push heroku master # deploys master branch
git push heroku some_branch_name:master # deploys non-master branch
```

**note**: Heroku must have 2 'dynos' enabled, `web` + `worker`, to process background jobs. if you don't need a queue, simply remove the `worker` task from `Procfile` and don't invoke `.delayed` functions.
