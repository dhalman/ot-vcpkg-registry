set(VCPKG_POLICY_EMPTY_PACKAGE enabled)
set(expect_debug ON)
if(VCPKG_BUILD_TYPE STREQUAL "release")
    set(expect_debug OFF)
endif()
vcpkg_cmake_configure(
    SOURCE_PATH "${CURRENT_PORT_DIR}/project"
    OPTIONS
        "-DBOTAN_PREFIX=${CURRENT_INSTALLED_DIR}"
        "-DBOTAN_LINKAGE=${VCPKG_LIBRARY_LINKAGE}"
        "-DBOTAN_EXPECT_DEBUG=${expect_debug}"
)
vcpkg_cmake_build()
