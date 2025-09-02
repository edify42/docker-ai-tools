#!/usr/bin/env bash

source /home/node/.bashrc
echo 'running startup of ai-tools container'

if [[ -z "${GEMINI_API_KEY}" ]]; then
  echo "No GEMINI_API_KEY set - exiting"
  exit 1
fi

if [[ -z "${ANTHROPIC_API_KEY}" ]]; then
  echo "No ANTHROPIC_API_KEY set - exiting"
  exit 1
fi

mkdir -p .gemini

cat << EOF > .gemini/settings.json
{
  "selectedAuthType": "gemini-api-key"
}
EOF

mkdir -p .claude

cat << EOF > .claude/settings.json
{
  "apiKeyHelper": "/home/node/scripts/claude-key-helper.sh",
  "theme": "dark"
}
EOF

/usr/bin/env bash