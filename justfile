set dotenv-load
set unstable
set shell := ["zsh", "-cu"]

# ================================================================================================ #
# Project Configration Helpers

project_path := justfile_directory()

# Auto-Generated and Build Paths, or 'out' paths
dir_build   := project_path/"build"
dir_install := project_path/"install"
dir_cache   := project_path/".cache"

# Important Project Paths
dir_cmake   := project_path/"cmake"
dir_scripts := project_path/"scripts"

# ================================================================================================ #
# Command-Line Helpers

# Helper terminal command prefix to allow for easy just recipe calling
# This is required as Just doesnt nativuly allow recipes to call other recipes with dep
call_recipe := just_executable() + " --justfile=" + justfile()

# ================================================================================================ #
# Project Info

# Output usage and helpful command info for the project
help:
    @just --list --alias-style=separate --justfile {{justfile()}}
_default: help

# Output current system information such as OS and Architecture
[group("info")]
@system-info:
    echo $'\n{{BOLD}}{{UNDERLINE}}System Info{{NORMAL}}'
    echo "    {{BOLD}}Architecture:{{NORMAL}} {{arch()}}"
    echo "    {{BOLD}}OS:{{NORMAL}} {{os()}}"
    echo "    {{BOLD}}OS Family:{{NORMAL}} {{os_family()}}"

# ================================================================================================ #
# File System Management

# Removes the provided files/dirs and cleans their data
[group("file-system")]
@clean-targets +targets:
    {{dir_scripts}}/clean-targets.sh {{targets}}

# Clean out all generated files (bui1ld, cache, etc) from the project
[group("file-system")]
@clean: ( clean-targets dir_build dir_install dir_cache )

# ================================================================================================ #
# Project Configuration

# Generates the config data for CMake
[group("config")]
config:
    cmake -S . -B {{dir_build}} -G "Ninja Multi-Config"

# Cleans and then reconfigures the cmake project
[group("config")]
reconfig: clean config

# ================================================================================================ #

