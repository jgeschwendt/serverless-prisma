FROM circleci/node

# install the latest version of yarn
RUN curl -o- -L https://yarnpkg.com/install.sh | bash

# expose development ports
EXPOSE 4000:4000
