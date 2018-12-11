# /usr/bin/env bash
# Author: Xan

find data/ -type f | grep -Ev '*.xml' | xargs -i cat {} | grep -Ev 'open\|filtered' | less -r
