// -----// IR Dump After ConvertLinalgToLoopsPass (convert-linalg-to-loops) //----- //
module attributes {gpu.container_module} {
  gpu.module @kernel_module {
    gpu.func @matmul_kernel(%arg0: memref<128x128xf32>, %arg1: memref<128x128xf32>, %arg2: memref<128x128xf32>) kernel {
      %c0 = arith.constant 0 : index
      %c128 = arith.constant 128 : index
      %c1 = arith.constant 1 : index
      scf.for %arg3 = %c0 to %c128 step %c1 {
        scf.for %arg4 = %c0 to %c128 step %c1 {
          scf.for %arg5 = %c0 to %c128 step %c1 {
            %0 = memref.load %arg0[%arg3, %arg5] : memref<128x128xf32>
            %1 = memref.load %arg1[%arg5, %arg4] : memref<128x128xf32>
            %2 = memref.load %arg2[%arg3, %arg4] : memref<128x128xf32>
            %3 = arith.mulf %0, %1 : f32
            %4 = arith.addf %2, %3 : f32
            memref.store %4, %arg2[%arg3, %arg4] : memref<128x128xf32>
          }
        }
      }
      gpu.return
    }
  }
  func.func @matmul(%arg0: memref<128x128xf32>, %arg1: memref<128x128xf32>, %arg2: memref<128x128xf32>) attributes {llvm.emit_c_interface} {
    %c0 = arith.constant 0 : index
    gpu.launch_func  @kernel_module::@matmul_kernel blocks in (%c0, %c0, %c0) threads in (%c0, %c0, %c0)  args(%arg0 : memref<128x128xf32>, %arg1 : memref<128x128xf32>, %arg2 : memref<128x128xf32>)
    return
  }
}


