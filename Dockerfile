FROM ruby:2.5.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY ./bin/entrypoint.sh /app/bin/entrypoint.sh
COPY . /app

ENTRYPOINT ["/app/bin/entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server" "-b", "0.0.0.0"]
