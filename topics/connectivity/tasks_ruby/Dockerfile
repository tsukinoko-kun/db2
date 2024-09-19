FROM ruby:3-alpine

RUN apk add --no-cache --update build-base linux-headers tzdata vim postgresql-dev libpq
ENV EDITOR vim

RUN mkdir /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle update --bundler
RUN bundle install

CMD sh