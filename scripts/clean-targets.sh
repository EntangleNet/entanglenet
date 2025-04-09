#!/usr/bin/env zsh
# ================================================================================================ #
# Force Executable Guard (Disable Script Sourcing)

# Script must be at top level otherwise it is sourced
if [[ $ZSH_EVAL_CONTEXT != "toplevel" ]]; then
    echo "[ERROR] No Source: This script must not be sourced, consider executing it instead!"

    # Return exit code 126 from the script to signify perm error
    return 126
fi

# ================================================================================================ #
# ZSH Options

# Enable extra safety option, this sets the following flags:
#   [-e] Immediatly exit if any command has a non-zero exit status.
#   [-u] Throw an error when a variable is referenced that hasn't been defined
#   [-o pipefail] Prevents pipeline errors from being masked
set -euo pipefail

# ================================================================================================ #
# Remove Targets

for target in ${@}; do
    rm -rf "${target}" || echo '[ERROR] Failed to Clean the Target: '${target}
done

# ================================================================================================ #
