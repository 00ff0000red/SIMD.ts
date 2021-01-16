;; api

(import "wasm" "calculate_allocation" (func $calculate_allocation (result i32))) ;; (): (usize)
(import "wasm" "memory" (memory 4 4))

(func (export "unreachable")
	unreachable
)

(func (export "i8x16.splat") (param i32) (result i32)
	(local $ptr i32)

	call $calculate_allocation
	local.tee $ptr

	local.get 0
	i8x16.splat

	v128.store

	local.get $ptr
)

(func (export "i16x8.splat") (param i32) (result i32)
	(local $ptr i32)

	call $calculate_allocation
	local.tee $ptr

	local.get 0
	i16x8.splat

	v128.store

	local.get $ptr
)

(func (export "i32x4.splat") (param i32) (result i32)
	(local $ptr i32)

	call $calculate_allocation
	local.tee $ptr

	local.get 0
	i32x4.splat

	v128.store

	local.get $ptr
)

(func (export "i64x2.splat") (param i64) (result i32)
	(local $ptr i32)

	call $calculate_allocation
	local.tee $ptr

	local.get 0
	i64x2.splat

	v128.store

	local.get $ptr
)

(func (export "f32x4.splat") (param f32) (result i32)
	(local $ptr i32)

	call $calculate_allocation
	local.tee $ptr

	local.get 0
	f32x4.splat

	v128.store

	local.get $ptr
)

(func (export "f64x2.splat") (param f64) (result i32)
	(local $ptr i32)

	call $calculate_allocation
	local.tee $ptr

	local.get 0
	f64x2.splat

	v128.store

	local.get $ptr
)
