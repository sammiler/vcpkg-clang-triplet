# vcpkg Clang 三元组：x64-windows-clang

一个为 64 位 Windows 应用程序设计的 vcpkg 三元组，使用 Clang/LLVM 进行构建。

---

## 概览

此三元组配置 vcpkg 使用 Clang 作为编译器和链接器，针对 x64 Windows 平台，依托 Visual Studio 的 LLVM 工具链。它确保与 vcpkg 安装的库兼容，同时将 Clang 的运行时库（例如 `clang_rt.builtins-x86_64.lib`）集成到构建过程中。

- **目标架构**：x86_64（64 位）

- **平台**：Windows

- **编译器**：Clang/LLVM（Visual Studio 2022）

- **CRT 链接方式**：动态链接

- **库链接方式**：静态链接（可配置）



## 注意事项

### Windows 环境

- 需要显式链接 Visual Studio LLVM 安装中的 clang_rt.builtins-x86_64.lib，以支持 Clang 的运行时功能。
- 确保 Visual Studio 2022 已安装 LLVM/Clang 组件。

### Linux 环境

- 在 Linux 下（如使用 x64-linux-clang 三元组），Clang 通常会自动链接其运行时库（如 libclang_rt.builtins-x86_64.a），无需手动指定。
- 如果未出现链接问题，则无需额外配置。

## 故障排除

- **库未找到**：
  - 检查 clang_rt.builtins-x86_64.lib 的路径是否与你的 Visual Studio 安装一致。
  - 确保路径中文件存在。
- **链接错误**：
  - 查看 vcpkg/buildtrees/<包名> 中的构建日志，使用 --verbose 获取详细信息。
- **三元组未生效**：
  - 使用 --triplet x64-windows-clang 参数强制应用此三元组配置。

---

## 许可

此三元组遵循 vcpkg 的 MIT 许可证。
