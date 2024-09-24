FROM homebrew/brew:3.2.5
RUN brew install hcloud
COPY entrypoint.sh /entrypoint.sh
RUN sudo chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]