FROM debian:bookworm

# base dependencies - e.g. python 3.11
RUN apt update && apt install -y python3 make g++ python3-pip awscli

# extra dependencies
RUN apt install -y curl wget vim less

RUN groupadd -g 1000 node \
    && useradd -m -u 1000 -g 1000 -s /bin/bash node

# Install NVM for 'node' user
ENV NVM_DIR=/home/node/.nvm
RUN mkdir -p $NVM_DIR \
    && chown -R node:node /home/node

# switch user + install
USER node
WORKDIR /home/node
ENV NVM_DIR=/home/node/.nvm
# nvm install
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

RUN echo 'export NVM_DIR="$HOME/.nvm"' >> "$HOME/.bashrc" \
  && echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> "$HOME/.bashrc" \
  && . "$NVM_DIR/nvm.sh" \
  && nvm --version \
  && nvm install --lts \
  && nvm alias default lts/* \
  && node -v && npm -v \
  && npm install --global @google/gemini-cli @anthropic-ai/claude-code @openai/codex@latest


RUN mkdir -p $HOME/scripts
COPY docker/entrypoint.sh /home/node/scripts/

## Last set of user desired dependencies to make builds faster via caching.

ENTRYPOINT [ "/bin/bash", "-i", "/home/node/scripts/entrypoint.sh" ]