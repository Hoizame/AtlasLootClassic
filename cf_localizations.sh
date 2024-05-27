#!/bin/bash
# Source from: https://github.com/WeakAuras/WeakAuras2

declare -A locale_files=(
  ["Base Namespace"]="CF_Locales/Global.lua"
  ["Collections"]="CF_Locales/Collections.lua"
  ["Crafting"]="CF_Locales/Crafting.lua"
  ["DungeonsAndRaids"]="CF_Locales/DungeonsAndRaids.lua"
  ["DungeonsAndRaidsTBC"]="CF_Locales/DungeonsAndRaidsTBC.lua"
  ["DungeonsAndRaidsWrath"]="CF_Locales/DungeonsAndRaidsWrath.lua"
  ["DungeonsAndRaidsCata"]="CF_Locales/DungeonsAndRaidsCata.lua"
  ["PvP"]="CF_Locales/PvP.lua"
  ["Options"]="CF_Locales/Options.lua"
  ["Factions"]="CF_Locales/Factions.lua"
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
    "https://wow.curseforge.com/api/projects/1014843/localization/import"
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
