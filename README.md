# TritonShared

```
https://github.com/triton-lang/triton.git
https://github.com/microsoft/triton-shared.git 

```
# Build triton-shared shared
```
#!/bin/bash

export TRITON_PLUGIN_DIRS=$(pwd)/triton_shared

L="`pwd`/llvm-project"
export LLVM_BUILD_DIR=${L}/build
#export NINJAFLAGS="-j12"
#export CMAKE_BUILD_PARALLEL_LEVEL=12
cd triton
export LLVM_INCLUDE_DIRS=$LLVM_BUILD_DIR/include 
export LLVM_LIBRARY_DIR=$LLVM_BUILD_DIR/lib 
export LLVM_SYSPATH=$LLVM_BUILD_DIR

export TRITON_BUILD_WITH_CLANG_LLD=true
export TRITON_BUILD_WITH_CCACHE=true

numactl --physcpubind=0,1,2,3,4  pip install -e .

```
