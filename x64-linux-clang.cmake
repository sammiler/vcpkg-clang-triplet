# This triplet is tested in vcpkg ci via https://github.com/microsoft/vcpkg/pull/25897
set(VCPKG_TARGET_ARCHITECTURE x64)
set(VCPKG_CRT_LINKAGE dynamic)
set(VCPKG_LIBRARY_LINKAGE dynamic)

## Toolchain setup
set(VCPKG_TARGET_TRIPLET "x64-linux-clang")
set(VCPKG_CMAKE_CONFIGURE_OPTIONS "-DVCPKG_TARGET_TRIPLET=${VCPKG_TARGET_TRIPLET}")
set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/x64-linux-llvm/clang-toolchain.cmake")


# Ensure vcpkg recognizes Linux platform
set(VCPKG_CMAKE_SYSTEM_NAME Linux CACHE STRING "Target system name")

set(VCPKG_QT_TARGET_MKSPEC   linux-clang) # For Qt5

## Policy settings
set(VCPKG_POLICY_SKIP_ARCHITECTURE_CHECK enabled)


## Extra scripts which should not directly be hashed so that changes don't nuke the complete installed tree in manifest mode
## Note: This breaks binary caching so don't apply changes to these files unkowningly.
include("${CMAKE_CURRENT_LIST_DIR}/x64-linux-llvm/clang-toolchain.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/x64-linux-llvm/port_specialization.cmake")
