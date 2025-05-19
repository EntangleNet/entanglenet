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
# Project Info

# Output usage and helpful command info for the project
help:
    @just --list --alias-style=separate --justfile {{justfile()}}
_default: help

# Display information relevant to this system
@info:
    echo "{{BOLD}}Architecture:{{NORMAL}} {{arch()}}"
    echo "{{BOLD}}OS:{{NORMAL}} {{os()}}"
    echo "{{BOLD}}OS Family:{{NORMAL}} {{os_family()}}"

# ================================================================================================ #
# Tooling

# Lints the source code, config files, and docs
@lint:
    cmake-lint ./**/*.cmake CMakeLists.txt
    yamllint .
    markdownlint-cli2 ./*.md docs/**/*.md

# Formats the source code by running all format-* recipes
@format:
    cmake-format **/*.cmake CMakeLists.txt -i

# Cleans frequently auto-generated files and directories (e.g. target)
clean:
    rm -r {{dir_build}}
    rm -r {{dir_install}}
    rm -r {{dir_cache}}

# Cleans all auto-generated files and directories (e.g. docs, lockfile)
nuke: clean

# ================================================================================================ #
# Project Configuration

# Generates the config data for CMake
config:
    cmake -S . -B {{dir_build}} -G "Ninja Multi-Config"

# Cleans and then reconfigures the cmake project
reconfig: clean config

# ================================================================================================ #

