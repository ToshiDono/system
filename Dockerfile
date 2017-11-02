FROM ruby:2.4
MAINTAINER Anton Karpenko <toshidono.it.work@gmail.com>

COPY . /app/
WORKDIR /app
RUN bundle install
EXPOSE 15672
EXPOSE 5432
CMD foreman start