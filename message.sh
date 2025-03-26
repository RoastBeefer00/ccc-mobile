#!/bin/bash

curl -X POST \
  https://fcm.googleapis.com/v1/projects/cruceschessclub-d09a7/messages:send \
  -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -H "Content-Type: application/json" \
  -d '{
    "message":{
      "data":{
        "jake":"things"
      },
      "android": {
        "priority": "NORMAL"
      },
      "topic": "calendar"
    }
  }'
