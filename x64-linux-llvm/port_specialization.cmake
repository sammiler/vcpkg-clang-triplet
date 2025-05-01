# tbb 的 -mrtm 标志
if(PORT STREQUAL "tbb")
    set(VCPKG_C_FLAGS "-mrtm")
    set(VCPKG_CXX_FLAGS "-mrtm")
endif()

# re2 的静态链接
if(PORT MATCHES "^(re2)$")
    set(VCPKG_LIBRARY_LINKAGE static)
endif()
# Special handling for dbus configuration regarding session socket directory
if(PORT STREQUAL "dbus")
    message(STATUS "port_specialization: Applying DBUS_SESSION_SOCKET_DIR workaround for ${PORT}")
    # Append the required definition to the CMake configure options for this port
    list(APPEND VCPKG_CMAKE_CONFIGURE_OPTIONS "-DDBUS_SESSION_SOCKET_DIR=/run/dbus")
endif()


# LTO 配置
if(CMAKE_PARENT_LIST_FILE MATCHES "-lto(\\\.|-)" AND NOT PORT MATCHES "(benchmark|gtest|pkgconf|^qt[a-z]+)")
    list(APPEND VCPKG_CMAKE_CONFIGURE_OPTIONS "-DVCPKG_USE_LTO:BOOL=TRUE")
endif()

# Qt 相关配置
if(PORT MATCHES "(qtconnectivity|qtsensors|qtspeech)")
    list(APPEND VCPKG_CMAKE_CONFIGURE_OPTIONS "-DQT_FEATURE_cxx20=ON")
endif()