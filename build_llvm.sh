#!/bin/bash



export PATH=/root/scripts/download:$PATH

log="`pwd`/done.txt"

if [  -f ${log} ]; then
  rm ${log}
fi


exe() {
    echo "Execute  $*"
    "$@"
    if [ $? -ne 0 ]; then
         echo "[ERROR] : $*" | tee -a ${log}
	 exit   
    fi
    echo "[ok] $*" | tee -a ${log} 
}



llvm="llvm-project"

r="https://github.com/llvm/llvm-project.git"

d="`pwd`/clang_fresh"

hash_file="`pwd`/triton/cmake/llvm-hash.txt" 
h=`cat ${hash_file}`

if [ ! -d ${llvm} ]; then
    exe	git clone --recursive   ${r} ${llvm}
    exe cd ${llvm}
    exe git checkout ${h} -b hash_triton 
    cd ..
fi

if [ ! -d ${d} ]; then
  exe mkdir ${d}
fi


exe cd ${llvm}

exe mkdir build


exe cmake -S llvm -B build  -G Ninja  -DLLVM_ENABLE_PROJECTS="clang;lld;mlir"  -DCMAKE_BUILD_TYPE=Release  -DLLVM_TARGETS_TO_BUILD="host;NVPTX;AMDGPU" -DLLVM_ENABLE_ASSERTIONS=ON -DCMAKE_INSTALL_PREFIX=${d}

export NINJAJOBS=15
#only build
exe ninja -C build

# install 
exe ninja -C build install









