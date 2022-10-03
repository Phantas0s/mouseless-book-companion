#!/bin/bash

scratchpad() {
    tmux kill-session -t scratchpad 2> /dev/null
    urxvtc -name urxvt_scratchpad -e tmux new-session -d -s scratchpad ';' \
        new-window -n vim 'nvim +e /tmp/nvim-tmp.md' \; \
        attach-session -d -t scratchpad ';'
}
