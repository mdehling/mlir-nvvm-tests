module attributes {gpu.container_module} {

  gpu.module @kernel_module {
    gpu.func @matmul_kernel(%A: memref<128x128xf32>, %B: memref<128x128xf32>, %C: memref<128x128xf32>)
        kernel
    {
      linalg.matmul ins(%A, %B : memref<128x128xf32>, memref<128x128xf32>)
                    outs(%C : memref<128x128xf32>) 
      gpu.return
    }
  }

  func.func @matmul(%A: memref<128x128xf32>, %B: memref<128x128xf32>, %C: memref<128x128xf32>) attributes {llvm.emit_c_interface} {
    %c0 = arith.constant 0 : index
    gpu.launch_func @kernel_module::@matmul_kernel
        blocks in (%c0, %c0, %c0)
        threads in (%c0, %c0, %c0)
        args(%A: memref<128x128xf32>, %B: memref<128x128xf32>, %C: memref<128x128xf32>)
    return
  }

}