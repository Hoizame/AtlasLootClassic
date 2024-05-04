#!/bin/bash
# Source from: https://github.com/WeakAuras/WeakAuras2

declare -A locale_files=(
  ["Base Namespace"]="Global.lua"
  ["Collections"]="Collections.lua"
  ["Crafting"]="Crafting.lua"
  ["DungeonsAndRaids"]="DungeonsAndRaids.lua"
  ["DungeonsAndRaidsTBC"]="DungeonsAndRaidsTBC.lua"
  ["DungeonsAndRaidsWrath"]="DungeonsAndRaidsWrath.lua"
  ["DungeonsAndRaidsCata"]="DungeonsAndRaidsCata.lua"
  ["PvP"]="PvP.lua"
  ["Options"]="Options.lua"
  ["Factions"]="Factions.lua"
)

tempfile=$( mktemp )
trap 'rm -f $tempfile' EXIT

do_import() {
  namespace="$1"
  file="$2"
  : > "$tempfile"

  echo -n "Importing $namespace..."
  result=$( curl -sS -0 -X POST -w "%{http_code}" -o "$tempfile" \
    -H "X-Api-Token: $CF_API_KEY" \
    -F "metadata={ language: \"enUS\", namespace: \"$namespace\", \"missing-phrase-handling\": \"DeletePhrase\" }" \
    -F "localizations=<$file" \
    "https://legacy.curseforge.com/api/projects/65387/localization/import"
  ) || exit 1
  case $result in
    200) echo "done." ;;
    *)
      echo "error! ($result)"
      [ -s "$tempfile" ] && grep -q "errorMessage" "$tempfile" | jq --raw-output '.errorMessage' "$tempfile"
      exit 1
      ;;
  esac
}

lua babelfish.lua || exit 1
echo

for namespace in "${!locale_files[@]}"; do
  do_import "$namespace" "${locale_files[$namespace]}"
done

exit 0
