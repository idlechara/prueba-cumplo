FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /webapp
WORKDIR "/webapp"
ADD webapp/Gemfile /webapp/Gemfile
ADD webapp/Gemfile.lock /webapp/Gemfile.lock
RUN bundle install
ADD /webapp /webapp