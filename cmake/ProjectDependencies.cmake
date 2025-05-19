# ================================================================================================ #
# CPM (Dependency Management)

# Configurable options used to download a specifc CPM
set(CPM_VERSION "0.40.8")
set(CPM_HASH "78ba32abdf798bc616bab7c73aac32a17bbd7b06ad9e26a6add69de8f3ae4791")
set(CPM_LOCATION "${CMAKE_CURRENT_BINARY_DIR}/cmake")

# Helper variable for the full path of the newly downloaded CPM module
set(CPM_PATH "${CPM_LOCATION}/CPM.cmake")

# Download the correct version of CPM
if(NOT EXISTS ${CPM_PATH})
    message(STATUS "Downloading CPM.cmake")
    file(DOWNLOAD https://github.com/cpm-cmake/CPM.cmake/releases/download/v${CPM_VERSION}/CPM.cmake
         ${CPM_PATH} EXPECTED_HASH SHA256=${CPM_HASH}
    )
endif()

# If the downlaod failed then we throw a fatal error, as CPM is required
if(NOT EXISTS ${CPM_PATH})
    message(FATAL_ERROR "CMake failed to download CPM.cmake, this is a required module!")
endif()

# Define local project cache to allow for quicker builds and offline project configuration
set(CPM_SOURCE_CACHE ".cache/CPM")
set(CPM_USE_NAMED_CACHE_DIRECTORIES ON)

# Once we are sure CPM has been downloaded we need to import it
message(STATUS "Downloading CPM.cmake - done")
include(${CPM_PATH})

# ================================================================================================ #
# Development Dependencies

# CCache - A compiler cache that can drastically improve build times
cpmaddpackage(NAME Ccache.cmake GITHUB_REPOSITORY TheLartians/Ccache.cmake VERSION 1.2.5)

# ================================================================================================ #
