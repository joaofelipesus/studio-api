FROM ruby:3.1.2

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

ENV JWT_SECRET_KEY '1c164a12816c0a171e1c2a76135e3bfc0f2cd300da5631bb87fca39a1b49ef7e38b2b3a01768c99b48b2282b7c15e4024769284402b6219c8a5ea067ded3de0a'

ENV TEST_DATABASE_HOST 'postgres'
ENV DEV_DATABASE_HOST 'postgres'

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
