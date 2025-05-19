# ================================================================================================ #
# Properties and Helper Variables

# Set the verbosity based on the GET_MESSAGE_LOG_LEVEL
cmake_language(GET_MESSAGE_LOG_LEVEL LOG_LEVEL)

# Fetch the `multi config` checking property down
get_property(IS_MULTI_CONFIG GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
if(IS_MULTI_CONFIG)
    message(STATUS "Generator Config: Multi")
else()
    message(STATUS "Generator Config: Single")
endif()

# Check to see if this project is being included by another project
if(NOT DEFINED IS_MASTER_PROJECT)
    set(IS_MASTER_PROJECT OFF)
    if(CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
        set(IS_MASTER_PROJECT ON)
    endif()
endif()

# ================================================================================================ #
# System Information

# Store the system type in its own variable, for use by version.h
message("-- System: ${CMAKE_SYSTEM_NAME}")
if(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
    set(LINUX true)
else()
    set(UNKNOWN true)
endif()

# ================================================================================================ #
# Build Types

# Configurable Settings for the Build Type
set(BUILD_TYPES "Debug" "RelWithDebInfo" "Release")
list(GET BUILD_TYPES 0 BUILD_TYPES_DEFAULT)

# Set the required options depending on the generator type
if(IS_MULTI_CONFIG)
    # Specifies the available build types (configs) on multi-config generators. See, -
    # https://cmake.org/cmake/help/latest/variable/CMAKE_CONFIGURATION_TYPES.html -
    # https://cmake.org/cmake/help/latest/generator/Ninja%20Multi-Config.html -
    # https://ninja-build.org/manual.html
    set(CMAKE_CONFIGURATION_TYPES
        ${BUILD_TYPES}
        CACHE STRING "" FORCE
    )
else()
    # Set the build type to the default, if none supplied
    if(NOT CMAKE_BUILD_TYPE)
        message(STATUS "Defaulting the build type to '${BUILD_TYPES_DEFAULT}'!")
        set(CMAKE_BUILD_TYPE
            ${BUILD_TYPES_DEFAULT}
            CACHE STRING "Choose the build type to use" FORCE
        )
    endif()

    # Set the possible build types, to the defined list above for CMake-GUI
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS ${BUILD_TYPES})
    message(STATUS ${BUILD_TYPES})
endif()

# ================================================================================================ #
# Project-Wide Language Standards

# When the C++ standard is not defined we need it to set a sensible default
if(NOT DEFINED CMAKE_CXX_STANDARD)
    set(CMAKE_CXX_STANDARD 17)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)
    message(STATUS "CXX Standard Set to the Default Value (c++${CMAKE_CXX_STANDARD})")
endif()

# When the C standard is not defined we need it to set a sensible default
if(NOT DEFINED CMAKE_C_STANDARD)
    set(CMAKE_C_STANDARD 17)
    set(CMAKE_C_STANDARD_REQUIRED ON)
    message(STATUS "C Standard Set to the Default Value (c${CMAKE_C_STANDARD})")
endif()

# Disable compiler-specific extensions project-wide for increased portability
set(CMAKE_C_EXTENSIONS OFF)
set(CMAKE_CXX_EXTENSIONS OFF)
message(STATUS "Globally Disable Compiler-Specific C++ and C Extensions")

# ================================================================================================ #
