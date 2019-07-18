#!/bin/bash
# Source from: https://github.com/WeakAuras/WeakAuras2

declare -A LOC_FILES=(
  ["Base Namespace"]="Global.lua"
  ["Collections"]="Collections.lua"
  ["Crafting"]="Crafting.lua"
  ["DungeonsAndRaids"]="DungeonsAndRaids.lua"
  ["PvP"]="PvP.lua"
  ["Options"]="Options.lua"
)

tempfile=$( mktemp )
trap 'rm -f $tempfile' EXIT

do_import() {
  namespace="$1"
  file="$2"
  : > "$tempfile"

  echo -n "Importing $namespace..."
  result=$( curl -sS -X POST -w "%{http_code}" -o "$tempfile" \
    -H "X-Api-Token: $CF_API_KEY" \
    -F "metadata={ language: \"enUS\", namespace: \"$namespace\", \"missing-phrase-handling\": \"DeletePhrase\" }" \
    -F "localizations=<$file" \
    "https://wow.curseforge.com/api/projects/326516/localization/import"
  ) || exit 1
  case $result in
    200) echo "done." ;;
    *)
      echo "error! ($result)"
      [ -s "$tempfile" ] && grep -q "errorMessage" "$tempfile" && cat "$tempfile" | jq --raw-output '.errorMessage'
      exit 1
      ;;
  esac
}

lua babelfish.lua || exit 1
echo

for namespace in "${!LOC_FILES[@]}"; do
  do_import "$namespace" "${LOC_FILES[$namespace]}"
done

exit 0