// -----// IR Dump After Canonicalizer (canonicalize) //----- //
gpu.module @kernel_module [#nvvm.target] {
  llvm.func @matmul_kernel(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: !llvm.ptr, %arg8: !llvm.ptr, %arg9: i64, %arg10: i64, %arg11: i64, %arg12: i64, %arg13: i64, %arg14: !llvm.ptr, %arg15: !llvm.ptr, %arg16: i64, %arg17: i64, %arg18: i64, %arg19: i64, %arg20: i64) attributes {gpu.kernel, nvvm.kernel} {
    %0 = llvm.mlir.constant(0 : index) : i64
    %1 = llvm.mlir.constant(128 : index) : i64
    %2 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb1(%0 : i64)
  ^bb1(%3: i64):  // 2 preds: ^bb0, ^bb6
    %4 = llvm.icmp "slt" %3, %1 : i64
    llvm.cond_br %4, ^bb2(%0 : i64), ^bb7
  ^bb2(%5: i64):  // 2 preds: ^bb1, ^bb5
    %6 = llvm.icmp "slt" %5, %1 : i64
    llvm.cond_br %6, ^bb3(%0 : i64), ^bb6
  ^bb3(%7: i64):  // 2 preds: ^bb2, ^bb4
    %8 = llvm.icmp "slt" %7, %1 : i64
    llvm.cond_br %8, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %9 = llvm.mul %3, %1 overflow<nsw, nuw> : i64
    %10 = llvm.add %9, %7 overflow<nsw, nuw> : i64
    %11 = llvm.getelementptr inbounds|nuw %arg1[%10] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %12 = llvm.load %11 : !llvm.ptr -> f32
    %13 = llvm.mul %7, %1 overflow<nsw, nuw> : i64
    %14 = llvm.add %13, %5 overflow<nsw, nuw> : i64
    %15 = llvm.getelementptr inbounds|nuw %arg8[%14] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %16 = llvm.load %15 : !llvm.ptr -> f32
    %17 = llvm.mul %3, %1 overflow<nsw, nuw> : i64
    %18 = llvm.add %17, %5 overflow<nsw, nuw> : i64
    %19 = llvm.getelementptr inbounds|nuw %arg15[%18] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %20 = llvm.load %19 : !llvm.ptr -> f32
    %21 = llvm.fmul %12, %16 : f32
    %22 = llvm.fadd %20, %21 : f32
    %23 = llvm.mul %3, %1 overflow<nsw, nuw> : i64
    %24 = llvm.add %23, %5 overflow<nsw, nuw> : i64
    %25 = llvm.getelementptr inbounds|nuw %arg15[%24] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %22, %25 : f32, !llvm.ptr
    %26 = llvm.add %7, %2 : i64
    llvm.br ^bb3(%26 : i64)
  ^bb5:  // pred: ^bb3
    %27 = llvm.add %5, %2 : i64
    llvm.br ^bb2(%27 : i64)
  ^bb6:  // pred: ^bb2
    %28 = llvm.add %3, %2 : i64
    llvm.br ^bb1(%28 : i64)
  ^bb7:  // pred: ^bb1
    llvm.return
  }
}

