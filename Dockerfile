FROM ruby:2.7.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs ntp yarn
RUN mkdir /api_rails
WORKDIR /api_rails

COPY Gemfile Gemfile.lock package.json yarn.lock ./
RUN bundle install
VOLUME /user/local/bundle

ADD . /api_rails
