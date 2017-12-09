FROM ruby:2.4
MAINTAINER Anton Karpenko <toshidono.it.work@gmail.com>

COPY . /app/
WORKDIR /app
RUN gem install foreman
RUN bundle install
CMD ./wait-for-it.sh -t 30 postgres:5432 && ./wait-for-it.sh -t 30 rabbitmq:15672 && ./wait-for-it.sh -t 30 rabbitmq:5672 && foreman start