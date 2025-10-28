FROM debian:trixie

# base dependencies - e.g. python 3.11
RUN apt-get update && apt-get install -y python3 make g++ python3-pip awscli

# extra dependencies
RUN apt-get install -y curl wget vim less git

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
# nvm install - ALL NPM COMMANDS MUST GO IN THE LARGE BLOCK BELOW
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

RUN echo 'export NVM_DIR="$HOME/.nvm"' >> "$HOME/.bashrc" \
  && echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> "$HOME/.bashrc" \
  && . "$NVM_DIR/nvm.sh" \
  && nvm --version \
  && nvm install --lts \
  && nvm alias default lts/* \
  && node -v && npm -v \
  && npm install --global @google/gemini-cli @anthropic-ai/claude-code @openai/codex@latest \
  && corepack enable \
  && corepack prepare yarn@1.22.22 --activate

RUN mkdir -p $HOME/scripts
COPY docker/entrypoint.sh /home/node/scripts/

RUN git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv
RUN echo 'export PATH=$PATH:$HOME/.tfenv/bin' >> ~/.bashrc

# switch back to root user and install extra things
USER root
RUN apt-get install -y unzip

## back to node user
USER node

ENTRYPOINT [ "/bin/bash", "-i", "/home/node/scripts/entrypoint.sh" ]