FROM node:latest@sha256:7963d848677d0a965ad6ddce1d4dbc20f296fde327ae76f1d18d8330d3bcc959

# install the latest version of yarn
RUN curl -o- -L https://yarnpkg.com/install.sh | bash
ENV PATH /root/.yarn/bin:/root/.config/yarn/global/node_modules/.bin:$PATH

# install global node modules
RUN yarn global add graphql prisma

# check versions
RUN yarn --version
RUN prisma --version

# expose development ports
EXPOSE 4000:4000
