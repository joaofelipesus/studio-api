FROM ruby:3.0.3

# add nodejs and yarn dependencies for the frontend
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Instala nossas dependencias
RUN apt-get update && apt-get install -qq -y --no-install-recommends \
nodejs yarn build-essential libpq-dev imagemagick git-all nano graphviz

RUN echo 'alias rspec="bundle exec rspec"' >> ~/.bashrc && \
    echo 'alias rails="bundle exec rails"' >> ~/.bashrc

# env var with workdir path
ENV INSTALL_PATH /studio-api

# create workdir
RUN mkdir -p $INSTALL_PATH

# define initial location of the container
WORKDIR $INSTALL_PATH

# copy Gemfile to container
COPY Gemfile ./

# gems path
ENV BUNDLE_PATH /gems

# copy application dir to container
COPY . .
