FROM node:latest@sha256:8062236dc2ee065a98af95eec74d5928d065194eb0ab8fffabdbc5cfaac2137a

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
