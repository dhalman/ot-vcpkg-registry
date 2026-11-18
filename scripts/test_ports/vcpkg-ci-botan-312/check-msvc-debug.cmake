cmake_minimum_required(VERSION 3.25)

# Run on buildtrees/botan/<triplet>-dbg/Makefile after the native nmake
# configure, with -DTRIPLET_DEFINE=<a definition supplied only in Debug>.
if(NOT TRIPLET_DEFINE MATCHES "^[A-Za-z_][A-Za-z0-9_]*$")
    message(FATAL_ERROR "Expected a Debug-only triplet definition name")
endif()
file(STRINGS "${BOTAN_MAKEFILE}" rows REGEX "^CXXFLAGS[ \t]+=")
list(LENGTH rows count)
if(NOT count EQUAL 1)
    message(FATAL_ERROR "Expected exactly one Botan CXXFLAGS assignment")
endif()
string(REGEX REPLACE "^[^=]*=[ \t]*" "" flags "${rows}")
separate_arguments(flags WINDOWS_COMMAND "${flags}")
if(NOT "/D${TRIPLET_DEFINE}" IN_LIST flags AND NOT "-D${TRIPLET_DEFINE}" IN_LIST flags)
    message(FATAL_ERROR "Botan CXXFLAGS did not receive the triplet's Debug definition ${TRIPLET_DEFINE}")
endif()
