FROM node:latest@sha256:f4f6f520e7bf0fd98d4b72e63e179304354965e6908df79b691fe1d6ef98ce1d

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
