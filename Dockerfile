FROM ruby:2.4
MAINTAINER Anton Karpenko <toshidono.it.work@gmail.com>

COPY . /app/
WORKDIR /app
RUN gem install foreman
RUN bundle install
CMD foreman start