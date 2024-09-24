FROM homebrew/brew:latest
RUN brew install hcloud
COPY entrypoint.sh /entrypoint.sh
RUN sudo chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]