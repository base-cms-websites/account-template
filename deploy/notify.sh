#!/bin/bash
set -e
[[ $RANCHER_CLUSTERID = "c-rc5kp" ]] && ENVIRONMENT="staging" || ENVIRONMENT="production"

payload="{
  \"attachments\": [{
    \"color\": \"good\",
    \"text\": \"Deployment of \`$TRAVIS_REPO_SLUG\` @ \`$TRAVIS_TAG\` to \`$ENVIRONMENT\` has finished.\"
  }]
}"
curl -f -X POST --data "$payload" -H 'Content-type: application/json' $SLACK_WEBHOOK_URL

payload="{
  \"deployment\": {
    \"revision\": \"\`$TRAVIS_TAG\`\",
    \"description\": \"Finished\",
    \"user\": \"TravisCD\"
  }
}"
curl -f -X POST --data "$payload" \
  -H 'Content-type: application/json' \
  -H "X-Api-Key:$NR_APIKEY" \
  https://api.newrelic.com/v2/applications/$NR_APPID/deployments.json
