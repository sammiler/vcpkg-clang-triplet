#include_guard(GLOBAL)
#
## vcpkg 工具链设置
#set(VCPKG_TARGET_TRIPLET "x64-linux-clang" CACHE STRING "vcpkg target triplet")
#set(VCPKG_CMAKE_CONFIGURE_OPTIONS "-DVCPKG_TARGET_TRIPLET=${VCPKG_TARGET_TRIPLET}")
#
#
#
#
## 编译器设置
#set(CMAKE_C_COMPILER "clang" CACHE PATH "C compiler" FORCE)
#set(CMAKE_CXX_COMPILER "clang++" CACHE PATH "C++ compiler" FORCE)
#set(CMAKE_AR "llvm-ar" CACHE STRING "Archiver" FORCE)
#set(CMAKE_LINKER "lld" CACHE STRING "Linker" FORCE)
#set(CMAKE_RANLIB "llvm-ranlib" CACHE STRING "Ranlib" FORCE)
#
#
#
#
#
## Optimize configure options for util-linux to ensure correct shared library versioning
#set(VCPKG_CONFIGURE_MAKE_OPTIONS
#        "--disable-static"
#        "--enable-shared"
#        "--with-pic"
#        "--disable-all-programs"  # Disable tools, focus on libraries
#        "--enable-libblkid"
#        "--enable-libmount"
#        "CC=${CMAKE_C_COMPILER}"
#        "CXX=${CMAKE_CXX_COMPILER}"
#        "AR=${CMAKE_AR}"
#        "RANLIB=${CMAKE_RANLIB}"
#        "LDFLAGS=-fuse-ld=lld"
#        "LIBTOOL=/usr/bin/libtool"  # Explicitly specify libtool
#        CACHE STRING "Additional configure options for make-based ports"
#)
## 可选功能开关
#option(VCPKG_USE_LTO "Enable full LTO for release builds" OFF)
#option(VCPKG_USE_SANITIZERS "Enable sanitizers for release builds" OFF)
#
## C 标准设置
#set(CMAKE_C_STANDARD 11 CACHE STRING "C standard")
#set(CMAKE_C_STANDARD_REQUIRED ON CACHE BOOL "")
#set(CMAKE_C_EXTENSIONS ON CACHE BOOL "")
#set(std_c_flags "-std=c11 -D__STDC__=1 -Wno-implicit-function-declaration")
#
## C++ 标准设置
#set(CMAKE_CXX_STANDARD 17 CACHE STRING "C++ standard")
#set(CMAKE_CXX_STANDARD_REQUIRED ON CACHE BOOL "")
#set(CMAKE_CXX_EXTENSIONS OFF CACHE BOOL "")
#set(std_cxx_flags "-std=c++17 -Wno-register")
#
## 架构标志
#set(arch_flags "-msse4.2 -maes -mpclmul -mcrc32")
#if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
#    string(APPEND arch_flags " -m32 --target=i686-pc-linux-gnu")
#endif()
#
## 运行时库设置
#set(VCPKG_CRT_LINKAGE "dynamic" CACHE STRING "CRT linkage (static/dynamic)")
#if(VCPKG_CRT_LINKAGE STREQUAL "static")
#    set(VCPKG_CRT_FLAG "-static")
#else()
#    set(VCPKG_CRT_FLAG "")
#endif()
#
## 忽略错误警告
#set(ignore_werror "-Wno-error")
#
## LTO 和 Sanitizer 设置
#set(CLANG_C_LTO_FLAGS "-fuse-ld=lld")
#set(CLANG_CXX_LTO_FLAGS "-fuse-ld=lld")
#if(VCPKG_USE_LTO)
#    set(CLANG_C_LTO_FLAGS "-flto -fuse-ld=lld")
#    set(CLANG_CXX_LTO_FLAGS "-flto -fuse-ld=lld -fwhole-program-vtables")
#endif()
#
#if(VCPKG_USE_SANITIZERS)
#    set(sanitizers "alignment,null")
#    if(VCPKG_USE_LTO)
#        string(APPEND sanitizers ",cfi")
#    else()
#        string(APPEND sanitizers ",address")
#    endif()
#    if(VCPKG_CRT_LINKAGE STREQUAL "static")
#        string(APPEND sanitizers ",undefined")
#    endif()
#    string(APPEND CLANG_FLAGS_RELEASE "-fsanitize=${sanitizers}")
#endif()
#
## 编译器标志
#set(CMAKE_C_FLAGS "${std_c_flags} ${arch_flags} ${ignore_werror} ${VCPKG_C_FLAGS}" CACHE STRING "")
#set(CMAKE_C_FLAGS_DEBUG "-O0 -g -D_DEBUG ${VCPKG_C_FLAGS_DEBUG}" CACHE STRING "")
#set(CMAKE_C_FLAGS_RELEASE "-O2 ${CLANG_FLAGS_RELEASE} ${VCPKG_C_FLAGS_RELEASE} ${CLANG_C_LTO_FLAGS} -DNDEBUG" CACHE STRING "")
#set(CMAKE_C_FLAGS_MINSIZEREL "-Os ${CLANG_FLAGS_RELEASE} ${VCPKG_C_FLAGS_RELEASE} ${CLANG_C_LTO_FLAGS} -DNDEBUG" CACHE STRING "")
#set(CMAKE_C_FLAGS_RELWITHDEBINFO "-O2 -g ${CLANG_FLAGS_RELEASE} ${VCPKG_C_FLAGS_RELEASE} ${CLANG_C_LTO_FLAGS} -DNDEBUG" CACHE STRING "")
#
#set(CMAKE_CXX_FLAGS "${std_cxx_flags} ${arch_flags} ${ignore_werror} ${VCPKG_CXX_FLAGS}" CACHE STRING "")
#set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} ${VCPKG_CXX_FLAGS_DEBUG}" CACHE STRING "")
#set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} ${VCPKG_CXX_FLAGS_RELEASE} ${CLANG_CXX_LTO_FLAGS}" CACHE STRING "")
#set(CMAKE_CXX_FLAGS_MINSIZEREL "${CMAKE_C_FLAGS_MINSIZEREL} ${VCPKG_CXX_FLAGS_RELEASE} ${CLANG_CXX_LTO_FLAGS}" CACHE STRING "")
#set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_C_FLAGS_RELWITHDEBINFO} ${VCPKG_CXX_FLAGS_RELEASE} ${CLANG_CXX_LTO_FLAGS}" CACHE STRING "")
#
## 链接器标志
#foreach(linker IN ITEMS "SHARED" "MODULE" "EXE")
#    set(CMAKE_${linker}_LINKER_FLAGS "${VCPKG_LINKER_FLAGS}" CACHE STRING "")
#    set(CMAKE_${linker}_LINKER_FLAGS_DEBUG "-g ${VCPKG_LINKER_FLAGS_DEBUG}" CACHE STRING "")
#    set(CMAKE_${linker}_LINKER_FLAGS_RELEASE "-O2 ${VCPKG_LINKER_FLAGS_RELEASE}" CACHE STRING "")
#    set(CMAKE_${linker}_LINKER_FLAGS_MINSIZEREL "-Os ${VCPKG_LINKER_FLAGS_RELEASE}" CACHE STRING "")
#    set(CMAKE_${linker}_LINKER_FLAGS_RELWITHDEBINFO "-O2 -g ${VCPKG_LINKER_FLAGS_RELEASE}" CACHE STRING "")
#endforeach()
#
## 清理重复空格
#foreach(flag_suf IN ITEMS "" "_DEBUG" "_RELEASE" "_MINSIZEREL" "_RELWITHDEBINFO")
#    string(REGEX REPLACE " +" " " CMAKE_C_FLAGS${flag_suf} "${CMAKE_C_FLAGS${flag_suf}}")
#    string(REGEX REPLACE " +" " " CMAKE_CXX_FLAGS${flag_suf} "${CMAKE_CXX_FLAGS${flag_suf}}")
#endforeach()
#
## 清理临时变量
#unset(std_c_flags)
#unset(std_cxx_flags)
#unset(arch_flags)
#unset(ignore_werror)
#unset(CLANG_C_LTO_FLAGS)
#unset(CLANG_CXX_LTO_FLAGS)
#unset(CLANG_FLAGS_RELEASE)
#unset(sanitizers)
#unset(VCPKG_CRT_FLAG)



# In ~/CLionProjects/vcpkg-clang-triplet/x64-linux-llvm/clang-toolchain.cmake
# (确保这个文件被你的 x64-linux-clang.cmake triplet 文件通过 VCPKG_CHAINLOAD_TOOLCHAIN_FILE 加载)

# 基本 vcpkg 设置
set(VCPKG_TARGET_TRIPLET "x64-linux-clang" CACHE STRING "vcpkg target triplet")
# VCPKG_CMAKE_CONFIGURE_OPTIONS 通常在主 triplet 文件中设置，这里不需要重复

# --- 核心编译器设置 ---
# 强制指定 Clang 编译器
set(CMAKE_C_COMPILER "clang" CACHE PATH "C compiler" FORCE)
set(CMAKE_CXX_COMPILER "clang++" CACHE PATH "C++ compiler" FORCE)

# --- 让 CMake/Autotools 自动检测或使用默认工具 ---
# 注释掉，避免强制指定可能引起冲突的工具
# set(CMAKE_AR "llvm-ar" CACHE STRING "Archiver" FORCE)
# set(CMAKE_LINKER "lld" CACHE STRING "Linker" FORCE) # 尤其这个，让编译器驱动链接
# set(CMAKE_RANLIB "llvm-ranlib" CACHE STRING "Ranlib" FORCE)

# --- 移除 VCPKG_CONFIGURE_MAKE_OPTIONS ---
# 这个变量会全局影响所有 makefile 项目的 configure 参数，非常危险且不推荐在工具链中设置。
# 如果 libmount 需要特定 configure 参数，应该在 libmount 的 portfile.cmake 中处理。
# unset(VCPKG_CONFIGURE_MAKE_OPTIONS CACHE) # 确保它没有被缓存

# --- 禁用高级特性 ---
# 明确关闭 LTO 和 Sanitizers，避免它们引入复杂性
# (确保你的主 triplet 文件 x64-linux-clang.cmake 没有覆盖这些为 ON)
# option(VCPKG_USE_LTO "Enable full LTO for release builds" OFF)
# option(VCPKG_USE_SANITIZERS "Enable sanitizers for release builds" OFF)

# --- C 标准设置 ---
# 使用 gnu11 可能对 Autotools 项目更友好，它们有时依赖 GNU extensions
set(CMAKE_C_STANDARD 11 CACHE STRING "C standard")
set(CMAKE_C_STANDARD_REQUIRED ON CACHE BOOL "")
set(CMAKE_C_EXTENSIONS ON CACHE BOOL "") # 明确启用 C extensions
set(std_c_flags "-std=gnu11") # 使用 gnu11 而不是 c11

# --- C++ 标准设置 ---
set(CMAKE_CXX_STANDARD 17 CACHE STRING "C++ standard")
set(CMAKE_CXX_STANDARD_REQUIRED ON CACHE BOOL "")
set(CMAKE_CXX_EXTENSIONS OFF CACHE BOOL "") # C++ 通常不需要 extensions
set(std_cxx_flags "-std=c++17")

# --- 移除特定架构优化 ---
# set(arch_flags "-msse4.2 -maes -mpclmul -mcrc32") # 暂时禁用
set(arch_flags "")

# --- 运行时库设置 (保持动态) ---
set(VCPKG_CRT_LINKAGE "dynamic" CACHE STRING "CRT linkage (static/dynamic)")
set(VCPKG_CRT_FLAG "") # VCPKG_CRT_FLAG 变量本身通常不是标准 CMake 或 Autotools 使用的

# --- 移除警告抑制 ---
# set(ignore_werror "-Wno-error") # 暂时移除，看看是否有警告被当作错误

# --- 基础编译器标志 ---
# 只设置最基本的标志，移除 LTO、Sanitizer、arch_flags 等
set(CMAKE_C_FLAGS "${std_c_flags} ${arch_flags} ${VCPKG_C_FLAGS}" CACHE STRING "" FORCE)
set(CMAKE_C_FLAGS_DEBUG "-O0 -g -D_DEBUG ${VCPKG_C_FLAGS_DEBUG}" CACHE STRING "" FORCE)
set(CMAKE_C_FLAGS_RELEASE "-O2 -DNDEBUG ${VCPKG_C_FLAGS_RELEASE}" CACHE STRING "" FORCE)
set(CMAKE_C_FLAGS_MINSIZEREL "-Os -DNDEBUG ${VCPKG_C_FLAGS_RELEASE}" CACHE STRING "" FORCE)
set(CMAKE_C_FLAGS_RELWITHDEBINFO "-O2 -g -DNDEBUG ${VCPKG_C_FLAGS_RELEASE}" CACHE STRING "" FORCE)

set(CMAKE_CXX_FLAGS "${std_cxx_flags} ${arch_flags} ${VCPKG_CXX_FLAGS}" CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} ${VCPKG_CXX_FLAGS_DEBUG}" CACHE STRING "" FORCE) # 沿用 C 的 Debug 标志
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} ${VCPKG_CXX_FLAGS_RELEASE}" CACHE STRING "" FORCE) # 沿用 C 的 Release 标志
set(CMAKE_CXX_FLAGS_MINSIZEREL "${CMAKE_C_FLAGS_MINSIZEREL} ${VCPKG_CXX_FLAGS_RELEASE}" CACHE STRING "" FORCE) # 沿用 C 的 MinSizeRel 标志
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_C_FLAGS_RELWITHDEBINFO} ${VCPKG_CXX_FLAGS_RELEASE}" CACHE STRING "" FORCE) # 沿用 C 的 RelWithDebInfo 标志

# --- 基础链接器标志 ---
# 只设置基本的 Debug/Release 标志，移除 LTO 相关
foreach(linker IN ITEMS "EXE" "SHARED" "MODULE")
    set(CMAKE_${linker}_LINKER_FLAGS "${VCPKG_LINKER_FLAGS}" CACHE STRING "" FORCE)
    set(CMAKE_${linker}_LINKER_FLAGS_DEBUG "-g ${VCPKG_LINKER_FLAGS_DEBUG}" CACHE STRING "" FORCE)
    set(CMAKE_${linker}_LINKER_FLAGS_RELEASE "-O2 ${VCPKG_LINKER_FLAGS_RELEASE}" CACHE STRING "" FORCE) # 通常 Release 链接时也加 -O2
    set(CMAKE_${linker}_LINKER_FLAGS_MINSIZEREL "-Os ${VCPKG_LINKER_FLAGS_RELEASE}" CACHE STRING "" FORCE) # 通常 MinSizeRel 链接时也加 -Os
    set(CMAKE_${linker}_LINKER_FLAGS_RELWITHDEBINFO "-O2 -g ${VCPKG_LINKER_FLAGS_RELEASE}" CACHE STRING "" FORCE) # RelWithDebInfo
endforeach()

# --- 清理重复空格 ---
# 这个保留，是好习惯
foreach(flag_suf IN ITEMS "" "_DEBUG" "_RELEASE" "_MINSIZEREL" "_RELWITHDEBINFO")
    if(DEFINED CMAKE_C_FLAGS${flag_suf})
        string(REGEX REPLACE " +" " " CMAKE_C_FLAGS${flag_suf} "${CMAKE_C_FLAGS${flag_suf}}")
    endif()
    if(DEFINED CMAKE_CXX_FLAGS${flag_suf})
        string(REGEX REPLACE " +" " " CMAKE_CXX_FLAGS${flag_suf} "${CMAKE_CXX_FLAGS${flag_suf}}")
    endif()
endforeach()

# --- 清理临时变量 ---
unset(std_c_flags)
unset(std_cxx_flags)
unset(arch_flags)
# unset(ignore_werror) # 因为上面注释掉了定义
# unset(VCPKG_CRT_FLAG) # 因为上面注释掉了定义
