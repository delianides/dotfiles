#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Next cmux Tab
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName cmux
# @raycast.icon 🔀
# @raycast.description Focus the next tab across every split in the cmux workspace, wrapping around.

exec "$HOME/.bin/cmux-cycle" next
