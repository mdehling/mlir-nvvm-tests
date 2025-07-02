// -----// IR Dump After ConvertNVVMToLLVMPass (convert-nvvm-to-llvm) //----- //
module attributes {gpu.container_module} {
  gpu.module @kernel_module {
    gpu.func @matmul_kernel(%arg0: memref<128x128xf32>, %arg1: memref<128x128xf32>, %arg2: memref<128x128xf32>) kernel {
      %c0 = arith.constant 0 : index
      %c128 = arith.constant 128 : index
      %c1 = arith.constant 1 : index
      cf.br ^bb1(%c0 : index)
    ^bb1(%0: index):  // 2 preds: ^bb0, ^bb8
      %1 = arith.cmpi slt, %0, %c128 : index
      cf.cond_br %1, ^bb2, ^bb9
    ^bb2:  // pred: ^bb1
      cf.br ^bb3(%c0 : index)
    ^bb3(%2: index):  // 2 preds: ^bb2, ^bb7
      %3 = arith.cmpi slt, %2, %c128 : index
      cf.cond_br %3, ^bb4, ^bb8
    ^bb4:  // pred: ^bb3
      cf.br ^bb5(%c0 : index)
    ^bb5(%4: index):  // 2 preds: ^bb4, ^bb6
      %5 = arith.cmpi slt, %4, %c128 : index
      cf.cond_br %5, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %6 = memref.load %arg0[%0, %4] : memref<128x128xf32>
      %7 = memref.load %arg1[%4, %2] : memref<128x128xf32>
      %8 = memref.load %arg2[%0, %2] : memref<128x128xf32>
      %9 = arith.mulf %6, %7 : f32
      %10 = arith.addf %8, %9 : f32
      memref.store %10, %arg2[%0, %2] : memref<128x128xf32>
      %11 = arith.addi %4, %c1 : index
      cf.br ^bb5(%11 : index)
    ^bb7:  // pred: ^bb5
      %12 = arith.addi %2, %c1 : index
      cf.br ^bb3(%12 : index)
    ^bb8:  // pred: ^bb3
      %13 = arith.addi %0, %c1 : index
      cf.br ^bb1(%13 : index)
    ^bb9:  // pred: ^bb1
      gpu.return
    }
  }
  func.func @matmul(%arg0: memref<128x128xf32>, %arg1: memref<128x128xf32>, %arg2: memref<128x128xf32>) attributes {llvm.emit_c_interface} {
    %c0 = arith.constant 0 : index
    gpu.launch_func  @kernel_module::@matmul_kernel blocks in (%c0, %c0, %c0) threads in (%c0, %c0, %c0)  args(%arg0 : memref<128x128xf32>, %arg1 : memref<128x128xf32>, %arg2 : memref<128x128xf32>)
    return
  }
}


