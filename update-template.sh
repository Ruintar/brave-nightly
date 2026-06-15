#!/bin/sh
set -eu

REPO="brave/brave-browser"
ASSET_REGEX='^brave-browser-nightly_[0-9.]+_amd64\.deb$'

echo "Checking latest Brave Nightly version"

RELEASE_TAG=$(
  gh api "repos/${REPO}/releases?per_page=100" | jq -r --arg regex "$ASSET_REGEX" '
    map(select(any(.assets[]?; .name | test($regex))))
    | first
    | .tag_name
  '
)

if [ -z "$RELEASE_TAG" ] || [ "$RELEASE_TAG" = "null" ]; then
  echo "Could not find a Brave Nightly release"
  exit 1
fi

RELEASE_JSON=$(gh release view "$RELEASE_TAG" -R "$REPO" --json assets)

ASSET_NAME=$(
  printf '%s\n' "$RELEASE_JSON" | jq -r --arg regex "$ASSET_REGEX" '
    .assets[]
    | select(.name | test($regex))
    | .name
  ' | head -n1
)

if [ -z "$ASSET_NAME" ] || [ "$ASSET_NAME" = "null" ]; then
  echo "Could not find the Brave Nightly amd64 .deb asset"
  exit 1
fi

LATEST_VERSION=$(printf '%s\n' "$ASSET_NAME" | sed -E 's/^brave-browser-nightly_([0-9.]+)_amd64\.deb$/\1/')

echo "Latest version is: $LATEST_VERSION"

CURRENT_VERSION=$(awk -F= '/^version=/{print $2}' template)

echo "Current template version is: $CURRENT_VERSION"

if [ "$LATEST_VERSION" = "$CURRENT_VERSION" ]; then
  echo "No update required"
  exit 0
fi

CHECKSUM=$(
  printf '%s\n' "$RELEASE_JSON" | jq -r --arg asset "$ASSET_NAME" '
    .assets[]
    | select(.name == $asset)
    | .digest
  ' | cut -d':' -f2
)

if [ -z "$CHECKSUM" ] || [ "$CHECKSUM" = "null" ]; then
  echo "Could not determine checksum for $ASSET_NAME"
  exit 1
fi

VERSION="$LATEST_VERSION" CHECKSUM="$CHECKSUM" envsubst '${VERSION} ${CHECKSUM}' < ./template.template > template

echo "Template updated"
