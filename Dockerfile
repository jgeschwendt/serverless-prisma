FROM node:latest@sha256:53caf7b35b949f365fdec7b599e495f125d6e3a54104caf05594a82e01343146

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
