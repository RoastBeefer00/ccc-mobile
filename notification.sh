#!/bin/bash

curl -X POST \
  https://fcm.googleapis.com/v1/projects/cruceschessclub-d09a7/messages:send \
  -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -H "Content-Type: application/json" \
  -d '{
    "message":{
      "notification": {
        "title": "Icebox Brewing",
        "body": "Tomorrow we will be at Icebox Brewing\n\n2825 W Picacho Ave, Las Cruces, NM 88007",
      },
      "data": {
        "jake":"things"
      },
      "android": {
        "priority": "NORMAL"
      },
      "topic": "calendar"
    }
  }'
