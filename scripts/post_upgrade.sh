#!/bin/bash
# Post-upgrade script called by Renovate after updating appVersion in Chart.yaml.
#
# Renovate has already written the new appVersion. This script:
#   1. Patch-bumps the chart version in Chart.yaml
#   2. Updates the Version and AppVersion shield badges in README.md
#   3. Inserts a new row in RELEASENOTES.md before the trailing "| | | |" line
#
# Usage:
#   bash scripts/post_upgrade.sh <chart_yaml_path> <new_app_version>
#
# Example:
#   bash scripts/post_upgrade.sh charts/postgres/Chart.yaml 18.5

set -euo pipefail

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <chart_yaml_path> <new_app_version>" >&2
    exit 1
fi

CHART_YAML="$1"
NEW_APP_VERSION="$2"
CHART_DIR=$(dirname "$CHART_YAML")
CHART_NAME=$(basename "$CHART_DIR")

if [ ! -f "$CHART_YAML" ]; then
    echo "ERROR: ${CHART_YAML} does not exist" >&2
    exit 1
fi

# ── 1. Patch-bump chart version in Chart.yaml ─────────────────────────────
# Renovate has already written the new appVersion; only `version` is touched.

CURRENT_CHART_VERSION=$(grep -m1 '^version:' "$CHART_YAML" | sed 's/^version:[[:space:]]*"\?\([^"[:space:]"]*\)"\?[[:space:]]*/\1/')

IFS='.' read -r ver_major ver_minor ver_patch <<< "$CURRENT_CHART_VERSION"
NEW_CHART_VERSION="${ver_major}.${ver_minor}.$((ver_patch + 1))"

sed -i "s|^version:.*|version: \"${NEW_CHART_VERSION}\"|" "$CHART_YAML"
echo "[${CHART_NAME}] Chart version: ${CURRENT_CHART_VERSION} → ${NEW_CHART_VERSION}"

# ── 2. Update README.md shield badges ─────────────────────────────────────
README="${CHART_DIR}/README.md"

if [ ! -f "$README" ]; then
    echo "WARNING: ${README} not found, skipping badge update" >&2
else
    # shields.io badge URL format: /badge/<label>-<message>-<color>
    # A literal hyphen inside <message> must be written as '--'
    ENCODED_APP=$(printf '%s' "$NEW_APP_VERSION" | sed 's/-/--/g')
    ENCODED_CHART=$(printf '%s' "$NEW_CHART_VERSION" | sed 's/-/--/g')

    sed -i "s|!\[Version: [^]]*\]([^)]*)|![Version: ${NEW_CHART_VERSION}](https://img.shields.io/badge/Version-${ENCODED_CHART}-informational?style=flat-square)|g" "$README"
    sed -i "s|!\[AppVersion: [^]]*\]([^)]*)|![AppVersion: ${NEW_APP_VERSION}](https://img.shields.io/badge/AppVersion-${ENCODED_APP}-informational?style=flat-square)|g" "$README"
    echo "[${CHART_NAME}] README.md badges updated"
fi

# ── 3. Insert row in RELEASENOTES.md ──────────────────────────────────────
# Entries are in ascending chronological order. Every file ends with a
# trailing empty table row "| | | |"; the new entry is inserted before it
# to preserve that convention.
NOTES="${CHART_DIR}/RELEASENOTES.md"
NEW_ROW="| ${NEW_CHART_VERSION} | ${NEW_APP_VERSION} | Upgraded ${CHART_NAME} to ${NEW_APP_VERSION} |"

if [ ! -f "$NOTES" ]; then
    echo "WARNING: ${NOTES} not found, skipping release notes update" >&2
else
    LAST_LINE=$(tail -1 "$NOTES")
    if [ "$LAST_LINE" = "| | | |" ]; then
        # Insert new row before the trailing empty row
        {
            head -n -1 "$NOTES"
            echo "$NEW_ROW"
            echo "| | | |"
        } > "${NOTES}.tmp" && mv "${NOTES}.tmp" "$NOTES"
    else
        echo "$NEW_ROW" >> "$NOTES"
    fi
    echo "[${CHART_NAME}] RELEASENOTES.md: inserted row for ${NEW_CHART_VERSION}"
fi
