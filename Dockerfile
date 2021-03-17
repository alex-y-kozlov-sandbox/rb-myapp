FROM ruby:2.6.6 AS rails-toolbox

RUN apt-get update && \
apt-get install -y nodejs --no-install-recommends && \
rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y sqlite3 --no-install-recommends && \
rm -rf /var/lib/apt/lists/*


WORKDIR /usr/src/app
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install
COPY . /usr/src/app/


COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000


CMD ["rails", "server", "-b", "0.0.0.0"]
