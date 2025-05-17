# ================================================================================================ #
# Pre-Project Config

cmake_minimum_required(VERSION 3.28)

# Run the Prelude module before we do anything in this file
include(cmake/Prelude.cmake)

# Allow CMake to search for project-specific modules
list(APPEND CMAKE_MODULE_PATH
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/cmake"
)

# ===================================================================================================== #
# Project Configuration

project(
    EntangleNet
    VERSION 0.1.0
    LANGUAGES C CXX
    HOMEPAGE_URL https://github.com/EntangleNet/entanglenet
    DESCRIPTION
        ""
)

# Import/include all project configuration helper modules.
include(ProjectSettings)
include(ProjectOptions)

# Import/include any project-wide dependencies
include(ProjectDependencies)

# ================================================================================================ #
# Project Submodules

add_subdirectory(src)
add_subdirectory(apps)

# ================================================================================================ #

