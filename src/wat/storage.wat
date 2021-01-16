;; storage

(import "wasm" "clear_and_calculate_offset" (func $clear_and_calculate_offset (param i32) (result i32))) ;; (usize): (usize)
(memory (export "storage") 1 1) ;; bool[0x10000]
(func (export "calculate_allocation") (result i32) ;; (): (usize)
	(local i32)
	i32.const 0
	local.set 0

	block $block ;; reverse iteration later
		loop $loop
			local.get 0
			i32.load8_u align=1 ;; bool
			i32.eqz ;; if false
			br_if $block ;; return

			local.get 0
			i32.const 1
			i32.add
			local.tee 0 ;; ++local 0
			i32.const 0x10000 ;; sizeof storage
			i32.lt_u ;; i32.eq?
			br_if $loop ;; prevent OOB access; throw
		end
		;; on OOB
		unreachable
	end
	local.get 0
	i32.const 1
	i32.store8 align=1

	local.get 0 ;; return iterator
	i32.const 4 ;; equivalent to * 16; to offset loading a v128
	i32.shl
)

(func (export "memory_free") (param i32) ;; (): (usize)
	local.get 0
	call $clear_and_calculate_offset
	i32.const 0 ;; boolean: false
	i32.store8 align=1 ;; mark as free
)
