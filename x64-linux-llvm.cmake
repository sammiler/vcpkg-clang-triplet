# This triplet is tested in vcpkg ci via https://github.com/microsoft/vcpkg/pull/25897
set(VCPKG_TARGET_ARCHITECTURE   x64)
set(VCPKG_CRT_LINKAGE   dynamic)
set(VCPKG_LIBRARY_LINKAGE   dynamic)

## Toolchain setup
set(VCPKG_TARGET_TRIPLET "x64-linux-llvm")
set(VCPKG_CMAKE_CONFIGURE_OPTIONS "-DVCPKG_TARGET_TRIPLET=${VCPKG_TARGET_TRIPLET}")
#set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/x64-linux-llvm/clang-toolchain.cmake")


# Ensure vcpkg recognizes Linux platform
set(VCPKG_CMAKE_SYSTEM_NAME Linux CACHE STRING "Target system name")

set(VCPKG_QT_TARGET_MKSPEC   linux-clang) # For Qt5
# Qt5 需要的库
#sudo apt update
#sudo apt install \
#libx11-dev \
#libxcb1-dev \
#libx11-xcb-dev \
#libxkbcommon-dev \
#libxkbcommon-x11-dev \
#libgl1-mesa-dev \
#libgles2-mesa-dev \
#mesa-common-dev \
#libxext-dev \
#libxcb-xinerama0-dev \
#libxcb-render0-dev \
#libxcb-shape0-dev \
#libxcb-shm0-dev \
#libxcb-xfixes0-dev \
#libxcb-keysyms1-dev \
#libxcb-image0-dev \
#libxcb-icccm4-dev \
#libxcb-sync-dev \
#libxcb-randr0-dev \
#libxcb-render-util0-dev


## Policy settings
set(VCPKG_POLICY_SKIP_ARCHITECTURE_CHECK enabled)


## Extra scripts which should not directly be hashed so that changes don't nuke the complete installed tree in manifest mode
## Note: This breaks binary caching so don't apply changes to these files unkowningly.
include("${CMAKE_CURRENT_LIST_DIR}/x64-linux-llvm/clang-toolchain.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/x64-linux-llvm/port_specialization.cmake")
