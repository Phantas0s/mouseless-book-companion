#!/bin/bash

tmux kill-session -t scratchpad 2> /dev/null
urxvtc -name urxvt_scratchpad -e tmux new-session -d -s scratchpad \; \
    attach-session -d -t scratchpad \; \
    new-window -n vim 'nvim +e /tmp/nvim-tmp.md' \;
