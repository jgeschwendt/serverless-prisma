FROM node:latest

# install the latest version of yarn
RUN curl -o- -L https://yarnpkg.com/install.sh | bash
RUN export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# expose development ports
EXPOSE 4000:4000
