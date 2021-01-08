;; storage

(import "env" "clear_and_calculate_offset" (func $clear_and_calculate_offset (param i32) (result i32)))
(memory (export "memory") 1 1)
(func (export "calculate_allocation") (result i32)
	(local i32)
	(local.set 0
		(i32.const 0)
	)
	(block $block ;; reverse iteration later
		(loop $loop
			(br_if $block
				(i32.eqz
					(i32.load8_u align=1
						(local.get 0)
					)
				)
			)
			(br_if $loop
				(i32.lt_u ;; i32.eq?
					(local.tee 0
						(i32.add
							(local.get 0)
							(i32.const 1)
						)
					)
					(i32.const 0x1000)
				)
			)
		)
		(unreachable)
	)
	(i32.store8 align=1
		(local.get 0)
		(i32.const 1)
	)
	(local.get 0)
)

(func (export "memory_free") (param i32)
	(i32.store8 align=1
		(call $clear_and_calculate_offset
			(local.get 0)
		)
		(i32.const 0)
	)
)