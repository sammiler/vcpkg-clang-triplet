


# 基本 vcpkg 设置
set(VCPKG_TARGET_TRIPLET "x64-linux-clang" CACHE STRING "vcpkg target triplet")
# VCPKG_CMAKE_CONFIGURE_OPTIONS 通常在主 triplet 文件中设置，这里不需要重复

# --- 核心编译器设置 ---
# 强制指定 Clang 编译器
set(CMAKE_C_COMPILER "clang" CACHE PATH "C compiler" FORCE)
set(CMAKE_CXX_COMPILER "clang++" CACHE PATH "C++ compiler" FORCE)


message(STATUS "Using Clang  C  compiler:  ${CMAKE_C_COMPILER}"   )
message(STATUS "Using Clang  CXX  compiler :${CMAKE_CXX_COMPILER}"   )



# !! 新增：为 vcpkg 启动的子进程设置环境变量 !!
set(ENV{CC} "clang")
set(ENV{CXX} "clang++")
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


# !! 强制设置系统处理器架构 !!
set(CMAKE_SYSTEM_PROCESSOR "x86_64" CACHE STRING "System Processor" FORCE)
set(CMAKE_SYSTEM_NAME ${VCPKG_CMAKE_SYSTEM_NAME} CACHE STRING "CMake System Name" FORCE) # 从 vcpkg 变量同步
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

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
set(CMAKE_C_FLAGS "${std_c_flags}   ${arch_flags} ${VCPKG_C_FLAGS}" CACHE STRING "" FORCE)
set(CMAKE_C_FLAGS_DEBUG "-O0 -g -D_DEBUG ${VCPKG_C_FLAGS_DEBUG}" CACHE STRING "" FORCE)
set(CMAKE_C_FLAGS_RELEASE "-O2 -DNDEBUG ${VCPKG_C_FLAGS_RELEASE}" CACHE STRING "" FORCE)
set(CMAKE_C_FLAGS_MINSIZEREL "-Os -DNDEBUG ${VCPKG_C_FLAGS_RELEASE}" CACHE STRING "" FORCE)
set(CMAKE_C_FLAGS_RELWITHDEBINFO "-O2 -g -DNDEBUG ${VCPKG_C_FLAGS_RELEASE}" CACHE STRING "" FORCE)

set(CMAKE_CXX_FLAGS "${std_cxx_flags} ${arch_flags} ${VCPKG_CXX_FLAGS}" CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} ${VCPKG_CXX_FLAGS_DEBUG}" CACHE STRING "" FORCE) # 沿用 C 的 Debug 标志
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} ${VCPKG_CXX_FLAGS_RELEASE}" CACHE STRING "" FORCE) # 沿用 C 的 Release 标志
set(CMAKE_CXX_FLAGS_MINSIZEREL "${CMAKE_C_FLAGS_MINSIZEREL} ${VCPKG_CXX_FLAGS_RELEASE}" CACHE STRING "" FORCE) # 沿用 C 的 MinSizeRel 标志
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_C_FLAGS_RELWITHDEBINFO} ${VCPKG_CXX_FLAGS_RELEASE}" CACHE STRING "" FORCE) # 沿用 C 的 RelWithDebInfo 标志


# --- Linker Flags ---
# 基础链接器标志 (合并 VCPKG 变量)
set(common_linker_flags "-pthread ${VCPKG_LINKER_FLAGS}")

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




# --- Final Debug Output ---
message(STATUS "Triplet: Final C_FLAGS = ${CMAKE_C_FLAGS}")
message(STATUS "Triplet: Final CXX_FLAGS = ${CMAKE_CXX_FLAGS}")
message(STATUS "Triplet: Final EXE_LINKER_FLAGS = ${CMAKE_EXE_LINKER_FLAGS}")