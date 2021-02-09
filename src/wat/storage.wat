;; storage

(import "wasm" "clear_and_calculate_offset" (func $clear_and_calculate_offset (param i32) (result i32))) ;; (usize): (usize)
(memory 1 1) ;; bool[0x10000]

;; equivalent to { Uint8Array(storage).indexOf(0) << 4 }, simply finds the first empty index; can this algorithm be improved?
(func $calculate_allocation (export "calculate_allocation") (result i32) ;; (): (usize)
	(local i32) ;; loop counter
	i32.const 0
	local.set 0

	;; TODO: vectorize this! The entire point of this is to use vectors
	;; alternatively use u64.clz/u64.ctz, and bitwise operations to determine offsets
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
	i32.const 4
	i32.shl ;; equivalent to (i * 16u); to offset loading a v128
	;; dup? Most, if not all operations dup the call afterward; except the JS calls
)

(; when using dup in alloc function
(func (export "js_alloc") (result i32) ;; (): (usize)
	call $calculate_allocation
	drop
)
;)

(func (export "memory_free") (param i32) ;; (): (usize)
	local.get 0
	call $clear_and_calculate_offset
	i32.const 0 ;; boolean: false
	i32.store8 align=1 ;; mark as free
)
