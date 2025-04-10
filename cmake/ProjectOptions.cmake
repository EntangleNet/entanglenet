# As this defines project options it can only be run once
include_guard(GLOBAL)

include(CMakeDependentOption)

# ================================================================================================ #
# Developement Mode and Options

# Option: Developer Mode
# These 'Developer Mode' settings are only relevant for developer(s) of this project.
# Developer Mode can be activated by users of the project but is set to an advanced option as it
# is not recommended.
option(
    ENTANGLENET_DEVELOPER_MODE
    "Enable the developer mode for ${CMAKE_PROJECT_NAME}."
    ${PROJECT_IS_TOP_LEVEL}
)
if(NOT PROJECT_IS_TOP_LEVEL)
    mark_as_advanced(ENTANGLENET_DEVELOPER_MODE)
endif()

# ================================================================================================ #

