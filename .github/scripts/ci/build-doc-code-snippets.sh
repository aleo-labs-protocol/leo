#!/usr/bin/env bash
set -euo pipefail

# Create the directory that Leo uses to resolve dependencies.
mkdir -p "$HOME/.aleo"

failed=0
while IFS= read -r -d '' manifest; do
  directory="${manifest%/program.json}"
  echo "--- $directory ---"
  if [ -d "$directory/tests" ]; then
    (cd "$directory" && "$LEO" test) || failed=1
  else
    (cd "$directory" && "$LEO" build) || failed=1
  fi
done < <(find documentation/code_snippets -name program.json \
  -not -path '*/build/*' -not -path '*/imports/*' -print0 | sort -z)
exit "$failed"
