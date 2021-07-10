#!/usr/bin/env bash

[ ! -z ${ENABLE_LPASS_AGENT_TIMEOUT} ] && \
    export set LPASS_AGENT_TIMEOUT="${ENABLE_LPASS_AGENT_TIMEOUT-300}"
