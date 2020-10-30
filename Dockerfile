FROM ruby:2.4.1

MAINTAINER Alexis Dumortier <dumortier.alexis@gmail.com>

ENV BUNDLER_VERSION=2.1.4

RUN gem update --system


RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs

RUN apt-get update -yqqq && \
  apt-get install -y \
    build-essential libpq-dev sudo vim ca-certificates postgresql-client && \
  gem install bundler --no-document --no-prerelease
  
# Add new user
RUN mkdir /app && \
  adduser web --home /home/web --shell /bin/bash --disabled-password
RUN chown web:web -R /app /home/web /usr/local/bundle

# Set web user root user
RUN echo 'root:root' | chpasswd
RUN echo 'web ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Install all gems
COPY Gemfile /app/
COPY /bin/start_dev /bin
WORKDIR /app

RUN gem install bundler -v "$(grep -A 1 "BUNDLED WITH" Gemfile.lock | tail -n 1)"

RUN bundle _2.1.4_ install