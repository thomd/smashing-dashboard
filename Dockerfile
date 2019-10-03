FROM ruby:2.5
LABEL maintainer "Thomas Duerr <thomduerr@gmail.com>"

RUN apt-get update && apt-get install -y nodejs

RUN mkdir /usr/app
WORKDIR /usr/app

RUN groupadd smashing \
    && useradd -l -m -s /bin/false -g smashing smashing \
    && chown -R smashing:smashing /usr/app

USER smashing

COPY Gemfile .
RUN bundle install

RUN smashing new dashboard
RUN cd dashboard && bundle install
WORKDIR /usr/app/dashboard

# add basic authentication
COPY config.ru .

EXPOSE 8080

ENTRYPOINT ["smashing"]
CMD ["start", "-p", "8080"]
