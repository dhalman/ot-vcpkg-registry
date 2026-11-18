cmake_minimum_required(VERSION 3.25...4.3)
project(botan_312_consumer LANGUAGES NONE)
find_package(Botan 3.12.0 EXACT CONFIG REQUIRED PATHS "${BOTAN_PREFIX}/share/botan" NO_DEFAULT_PATH)

set(target Botan::Botan)
set(runtime_dir lib)
if(BOTAN_LINKAGE STREQUAL "static")
    set(target Botan::Botan-static)
elseif(WIN32)
    set(runtime_dir bin)
endif()

set(prefix "${BOTAN_PREFIX}")
if(BOTAN_EXPECT_DEBUG)
    string(APPEND prefix "$<$<CONFIG:Debug>:/debug>")
endif()
add_custom_target(check_botan ALL
    COMMAND "${CMAKE_COMMAND}"
        "-DRUNTIME=$<TARGET_FILE:${target}>" "-DLINKER=$<TARGET_LINKER_FILE:${target}>"
        "-DEXPECT_RUNTIME=${prefix}/${runtime_dir}" "-DEXPECT_LINKER=${prefix}/lib"
        -P "${CMAKE_CURRENT_SOURCE_DIR}/check.cmake"
    VERBATIM
)
