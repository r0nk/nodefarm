#!/bin/bash

# build the game
godot --headless --export-release "Linux/X11" .
# upload the game to platforms
butler push export.zip target
# notify chats of update
echo "update pushed: $(git rev-parse HEAD)" | notify
# collect feedback
