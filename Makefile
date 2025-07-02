PROJECT_DIR ?= $(shell git rev-parse --show-toplevel)
LLVM_BUILD_DIR ?= $(PROJECT_DIR)/llvm-project/build

MLIR_OPT ?= $(LLVM_BUILD_DIR)/bin/mlir-opt
MLIR_TRANSLATE ?= $(LLVM_BUILD_DIR)/bin/mlir-translate
LLC ?= $(LLVM_BUILD_DIR)/bin/llc

.PHONY: all

all: matmul.o

matmul.o: matmul.ll
	$(LLC) -o $@ -filetype=obj $<

matmul.ll: matmul.llvm
	$(MLIR_TRANSLATE) -o $@ -mlir-to-llvmir $<

matmul.llvm: matmul.mlir
	$(MLIR_OPT) -o $@ -convert-linalg-to-loops -gpu-lower-to-nvvm-pipeline -mlir-print-ir-after-all -mlir-print-ir-tree-dir . $<

clean:
	rm -f matmul.llvm matmul.ll matmul.o
	rm -rf builtin_module_no-symbol-name
