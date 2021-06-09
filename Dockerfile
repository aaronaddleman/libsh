FROM bats/bats

ENV GITHUB_WORKSPACE
RUN apk update && apk add git