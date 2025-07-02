# MLIR NVVM Tests
Just some experiments with Linalg lowering to run on Nvidia GPUs.

Requires a recent build of MLIR & LLVM.  Build command used:
```
$ cd llvm-project
$ cmake -B build -S llvm -G Ninja \
    -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ \
    -DLLVM_CCACHE_BUILD=ON -DLLVM_ENABLE_LLD=ON \
    -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo -DLLVM_ENABLE_ASSERTIONS=ON \
    -DLLVM_TARGETS_TO_BUILD="Native;NVPTX" \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
    -DLLVM_ENABLE_PROJECTS=mlir -DMLIR_ENABLE_BINDINGS_PYTHON=OFF
```
