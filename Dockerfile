FROM node:latest@sha256:7991efd8c404b230c7dc40f114fb89e148fd79b0e6819027747f8e616782e1fa

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
