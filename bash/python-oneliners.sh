#!/bin/bash

# Cool Bash One-Liners
# ++++++++++++++++++++++========================================================
# Continously request a key from a RESTful endpoint that returns JSON

while true; do echo `curl -s -k -ucpx:"${PWD}" https://obama/api/4.0/stats/capture | python -c "import json,sys; sys.stdout.write(json.dumps(json.load(sys.stdin)['streams'][2]['mbps']))"`; sleep 3; done
