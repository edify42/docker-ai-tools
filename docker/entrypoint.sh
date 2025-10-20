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
  "theme": "dark"
}
EOF

cat << EOF > .claude.json
{
  "numStartups": 2,
  "hasCompletedProjectOnboarding": true,
  "customApiKeyResponses": {
    "approved": [
      "${ANTHROPIC_API_KEY: -20}"
    ],
    "rejected": []
  },
  "firstStartTime": "2025-10-20T23:22:56.156Z",
  "userID": "549478dba14de2ed8dc1de90d395dab304b58152dced3acda723d427114cbb6f",
  "sonnet45MigrationComplete": true,
  "projects": {
    "/workdir": {
      "allowedTools": [],
      "history": [
        {
          "display": "/exit",
          "pastedContents": {}
        }
      ],
      "mcpContextUris": [],
      "mcpServers": {},
      "enabledMcpjsonServers": [],
      "disabledMcpjsonServers": [],
      "hasTrustDialogAccepted": true,
      "ignorePatterns": [],
      "projectOnboardingSeenCount": 1,
      "hasClaudeMdExternalIncludesApproved": false,
      "hasClaudeMdExternalIncludesWarningShown": false,
      "exampleFiles": []
    }
  },
  "hasCompletedOnboarding": true,
  "lastOnboardingVersion": "2.0.24",
  "hasOpusPlanDefault": false,
  "lastReleaseNotesSeen": "2.0.24"
}
EOF

/usr/bin/env bash