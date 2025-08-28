#!/bin/bash
# 安全切换系统默认 clang/clang++ 到 LLVM 13

set -e

# 检查系统是否有 clang-13
if ! [ -x "$(command -v clang-13)" ]; then
    echo "clang-13 未安装，请先安装 LLVM 13"
    exit 1
fi

# 检查系统是否有 clang-10（备用）
if ! [ -x "$(command -v clang-10)" ]; then
    echo "clang-10 未安装，继续也可以，但无法回退"
fi

echo "配置 update-alternatives..."

# clang
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-10 100 2>/dev/null || true
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-13 130

# clang++
sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-10 100 2>/dev/null || true
sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-13 130

# 设置默认版本为 13
sudo update-alternatives --set clang /usr/bin/clang-13
sudo update-alternatives --set clang++ /usr/bin/clang++-13

echo "默认 clang/clang++ 已切换到 LLVM 13"
echo "当前版本："
clang --version
clang++ --version

