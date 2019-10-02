FROM ruby:2.5
LABEL maintainer "Thomas Duerr <thomduerr@gmail.com>"

RUN apt-get update && apt-get install -y nodejs

RUN mkdir /usr/app
WORKDIR /usr/app

RUN addgroup smashing \
    && adduser -S -G smashing smashing \
    && chown -R smashing:smashing /usr/app

USER smashing

COPY Gemfile /usr/app/
RUN bundle install

RUN smashing new sweet_dashboard_project
RUN cd sweet_dashboard_project && bundle install

EXPOSE 8080

ENTRYPOINT ["smashing"]
CMD ["start", "-p", "8080"]
