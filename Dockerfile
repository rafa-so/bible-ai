FROM ruby:2.7.8-bullseye

RUN gem install bundler -v 2.1.4

WORKDIR /store_app

COPY . .

EXPOSE 3000

RUN bundle install

CMD echo ENV && bundle exec rails s -p 3000 -b 0.0.0.0
