;; memory

(memory (export "memory") 4 4)
(func (export "clear_and_calculate_offset") (param i32) (result i32) ;; (usize): (usize)
	(v128.store align=16
		(local.get 0)
		(v128.const i64x2 0 0)
	)
	(i32.shr_u
		(local.get 0)
		(i32.const 4)
	)
)
