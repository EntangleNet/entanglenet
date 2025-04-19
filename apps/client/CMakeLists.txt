add_executable(entanglenet main.cpp)

add_library(portaudio SHARED IMPORTED)
TARGET_LINK_LIBRARIES(entanglenet portaudio)

add_custom_target(client
COMMAND ${CMAKE_COMMAND} -E echo "This is client target!"
DEPENDS entanglenet)