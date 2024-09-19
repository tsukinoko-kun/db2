FROM ruby:3

RUN apt-get update -qq && apt-get install -y build-essential libsqlite3-dev vim git
ENV EDITOR vim

RUN mkdir /api
WORKDIR /api

COPY Gemfile /api/Gemfile
COPY Gemfile.lock /api/Gemfile.lock
RUN bundle update --bundler
RUN bundle install

CMD bash