FROM ubuntu

RUN apt -y update && apt install -y git
RUN apt install -y bats
# CMD ["--tap","/code/tests"]
CMD ["bats","--pretty","/code/tests"]