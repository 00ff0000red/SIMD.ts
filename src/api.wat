;; api

(import "env" "calculate_allocation" (func $calculate_allocation (result i32)))
(func (export "memory_allocate") (result i32) ;; (): usize
	(i32.shl
		(call $calculate_allocation)
		(i32.const 4) ;; equivalent to * 16; to offset loading a v128
	)
)