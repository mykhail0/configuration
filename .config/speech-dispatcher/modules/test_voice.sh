#!/bin/dash

export model="/usr/share/piper-voices/en/en_US/${1}/high/en_US-${1}-high.onnx"
echo "Arch Linux is the best" | piper-tts --quiet --model "$model" --speaker "${2-0}" --output_file - | mpv --volume=80 --no-terminal --keep-open=no -
