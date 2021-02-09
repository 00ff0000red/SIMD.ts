;; api

(import "wasm" "calculate_allocation" (func $calculate_allocation (result i32))) ;; (): (usize)
(import "wasm" "memory" (memory 4 4))
(import "Reflect" "construct" (func $Reflect::construct (param $target externref) (param $argumentsList externref) (result externref))) ;; <T : V128>(target: T, argumentsList: JSValue::Array): (new<T>)
(import "Reflect" "set" (func $Reflect::set (param externref i32 i32))) ;; (JSValue::Array usize usize): ()
(import "js" "arguments" (global $arguments externref)) ;; JSValue::Array [ ArrayBuffer, i32 ]
;; `arguments` is a staticially allocated, reused array

;; for use on the JS side
(func (export "unreachable") ;; (): !
	unreachable
)

(func $construct_from (param $ptr i32) (param $class externref) (result externref) ;; (usize T): (new<T>)
	global.get $arguments
	i32.const 1
	local.get $ptr
	call $Reflect::set

	local.get $class
	global.get $arguments
	return_call $Reflect::construct
)

;; polyfill
(func $dup (param i32) (result i32 i32)
	local.get 0
	local.get 0
)

;; set only once after construction; semanticially constant
(global $u8x16 (mut externref) ref.null extern)
(global $s8x16 (mut externref) ref.null extern)

(global $u16x8 (mut externref) ref.null extern)
(global $s16x8 (mut externref) ref.null extern)

(global $u32x4 (mut externref) ref.null extern)
(global $s32x4 (mut externref) ref.null extern)

(global $u64x2 (mut externref) ref.null extern)
(global $s64x2 (mut externref) ref.null extern)

(global $f32x4 (mut externref) ref.null extern)

(global $f64x2 (mut externref) ref.null extern)

;; internal API
(func (export "register_js_classes")
	(param $u8x16 externref)
	(param $s8x16 externref)
	(param $u16x8 externref)
	(param $s16x8 externref)
	(param $u32x4 externref)
	(param $s32x4 externref)
	(param $u64x2 externref)
	(param $s64x2 externref)
	(param $f32x4 externref)
	(param $f64x2 externref)

	local.get $u8x16
	global.set $u8x16

	local.get $s8x16
	global.set $s8x16

	local.get $u16x8
	global.set $u16x8

	local.get $s16x8
	global.set $s16x8

	local.get $u32x4
	global.set $u32x4

	local.get $s32x4
	global.set $s32x4

	local.get $u64x2
	global.set $u64x2

	local.get $s64x2
	global.set $s64x2

	local.get $f32x4
	global.set $f32x4

	local.get $f64x2
	global.set $f64x2
)

;; TxN.of
;; TODO: use Binaryen for compression

(type $i8x16 (func (param i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32) (result externref)))
(func (export "u8x16.of") (type $i8x16)
	call $calculate_allocation
	call $dup
	v128.const i8x16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
	local.get 15
	i8x16.replace_lane 15
	local.get 14
	i8x16.replace_lane 14
	local.get 13
	i8x16.replace_lane 13
	local.get 12
	i8x16.replace_lane 12
	local.get 11
	i8x16.replace_lane 11
	local.get 10
	i8x16.replace_lane 10
	local.get 09
	i8x16.replace_lane 09
	local.get 08
	i8x16.replace_lane 08
	local.get 07
	i8x16.replace_lane 07
	local.get 06
	i8x16.replace_lane 06
	local.get 05
	i8x16.replace_lane 05
	local.get 04
	i8x16.replace_lane 04
	local.get 03
	i8x16.replace_lane 03
	local.get 02
	i8x16.replace_lane 02
	local.get 01
	i8x16.replace_lane 01
	local.get 00
	i8x16.replace_lane 00
	v128.store
	global.get $u8x16
	return_call $construct_from
)

(func (export "s8x16.of") (type $i8x16)
	call $calculate_allocation
	call $dup
	v128.const i8x16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
	local.get 15
	i8x16.replace_lane 15
	local.get 14
	i8x16.replace_lane 14
	local.get 13
	i8x16.replace_lane 13
  	local.get 12
	i8x16.replace_lane 12
	local.get 11
	i8x16.replace_lane 11
	local.get 10
	i8x16.replace_lane 10
	local.get 09
	i8x16.replace_lane 09
	local.get 08
	i8x16.replace_lane 08
	local.get 07
	i8x16.replace_lane 07
	local.get 06
	i8x16.replace_lane 06
	local.get 05
	i8x16.replace_lane 05
  	local.get 04
	i8x16.replace_lane 04
	local.get 03
	i8x16.replace_lane 03
	local.get 02
	i8x16.replace_lane 02
	local.get 01
	i8x16.replace_lane 01
	local.get 00
	i8x16.replace_lane 00
	v128.store
	global.get $s8x16
	return_call $construct_from
)

(type $i16x8 (func (param i32 i32 i32 i32 i32 i32 i32 i32) (result externref)))
(func (export "u16x8.of") (type $i16x8)
	call $calculate_allocation
	call $dup
	v128.const i16x8 0 0 0 0 0 0 0 0
	local.get 7
	i16x8.replace_lane 7
	local.get 6
	i16x8.replace_lane 6
	local.get 5
	i16x8.replace_lane 5
  	local.get 4
	i16x8.replace_lane 4
	local.get 3
	i16x8.replace_lane 3
	local.get 2
	i16x8.replace_lane 2
	local.get 1
	i16x8.replace_lane 1
	local.get 0
	i16x8.replace_lane 0
	v128.store
	global.get $u16x8
	return_call $construct_from
)

(func (export "s16x8.of") (type $i16x8)
	call $calculate_allocation
	call $dup
	v128.const i16x8 0 0 0 0 0 0 0 0
	local.get 7
	i16x8.replace_lane 7
	local.get 6
	i16x8.replace_lane 6
	local.get 5
	i16x8.replace_lane 5
  	local.get 4
	i16x8.replace_lane 4
	local.get 3
	i16x8.replace_lane 3
	local.get 2
	i16x8.replace_lane 2
	local.get 1
	i16x8.replace_lane 1
	local.get 0
	i16x8.replace_lane 0
	v128.store
	global.get $s16x8
	return_call $construct_from
)

(type $i32x4 (func (param i32 i32 i32 i32) (result externref)))
(func (export "u32x4.of") (type $i32x4)
	call $calculate_allocation
	call $dup
	v128.const i32x4 0 0 0 0
	local.get 3
	i32x4.replace_lane 3
	local.get 2
	i32x4.replace_lane 2
	local.get 1
	i32x4.replace_lane 1
	local.get 0
	i32x4.replace_lane 0
	v128.store
	global.get $u32x4
	return_call $construct_from
)

(func (export "s32x4.of") (type $i32x4)
	call $calculate_allocation
	call $dup
	v128.const i32x4 0 0 0 0
	local.get 3
	i32x4.replace_lane 3
	local.get 2
	i32x4.replace_lane 2
	local.get 1
	i32x4.replace_lane 1
	local.get 0
	i32x4.replace_lane 0
	v128.store
	global.get $s32x4
	return_call $construct_from
)

(type $i64x2 (func (param i64 i64) (result externref)))
(func (export "u64x2.of") (type $i64x2)
	call $calculate_allocation
	call $dup
	v128.const i64x2 0 0
	local.get 1
	i64x2.replace_lane 1
	local.get 0
	i64x2.replace_lane 0
	v128.store
	global.get $u64x2
	return_call $construct_from
)

(func (export "s64x2.of") (type $i64x2)
	call $calculate_allocation
	call $dup
	v128.const i64x2 0 0
	local.get 1
	i64x2.replace_lane 1
	local.get 0
	i64x2.replace_lane 0
	v128.store
	global.get $s64x2
	return_call $construct_from
)

(type $f32x4 (func (param f32 f32 f32 f32) (result externref)))
(func (export "f32x4.of") (type $f32x4)
	call $calculate_allocation
	call $dup
	v128.const f32x4 0.0 0.0 0.0 0.0
	local.get 3
	f32x4.replace_lane 3
	local.get 2
	f32x4.replace_lane 2
	local.get 1
	f32x4.replace_lane 1
	local.get 0
	f32x4.replace_lane 0
	v128.store
	global.get $f32x4
	return_call $construct_from
)

(type $f64x2 (func (param f64 f64) (result externref)))
(func (export "f64x2.of") (type $f64x2)
	call $calculate_allocation
	call $dup
	v128.const f64x2 0.0 0.0
	local.get 1
	f64x2.replace_lane 1
	local.get 0
	f64x2.replace_lane 0
	v128.store
	global.get $f64x2
	return_call $construct_from
)

;; TxN.splat
;; TODO: optimize?

(func (export "u8x16.splat") (param i32) (result externref)
	call $calculate_allocation
	call $dup
	local.get 0
	i8x16.splat
	v128.store
	global.get $u8x16
	return_call $construct_from
)

(func (export "s8x16.splat") (param i32) (result externref)
	call $calculate_allocation
	call $dup
	local.get 0
	i8x16.splat
	v128.store
	global.get $s8x16
	return_call $construct_from
)

(func (export "u16x8.splat") (param i32) (result externref)
	call $calculate_allocation
	call $dup
	local.get 0
	i16x8.splat
	v128.store
	global.get $u16x8
	return_call $construct_from
)

(func (export "s16x8.splat") (param i32) (result externref)
	call $calculate_allocation
	call $dup
	local.get 0
	i16x8.splat
	v128.store
	global.get $s16x8
	return_call $construct_from
)

(func (export "u32x4.splat") (param i32) (result externref)
	call $calculate_allocation
	call $dup
	local.get 0
	i32x4.splat
	v128.store
	global.get $u32x4
	return_call $construct_from
)

(func (export "s32x4.splat") (param i32) (result externref)
	call $calculate_allocation
	call $dup
	local.get 0
	i32x4.splat
	v128.store
	global.get $s32x4
	return_call $construct_from
)

(func (export "u64x2.splat") (param i64) (result externref)
	call $calculate_allocation
	call $dup
	local.get 0
	i64x2.splat
	v128.store
	global.get $u64x2
	return_call $construct_from
)

(func (export "s64x2.splat") (param i64) (result externref)
	call $calculate_allocation
	call $dup
	local.get 0
	i64x2.splat
	v128.store
	global.get $s64x2
	return_call $construct_from
)

(func (export "f32x4.splat") (param f32) (result externref)
	call $calculate_allocation
	call $dup
	local.get 0
	f32x4.splat
	v128.store
	global.get $f32x4
	return_call $construct_from
)

(func (export "f64x2.splat") (param f64) (result externref)
	call $calculate_allocation
	call $dup
	local.get 0
	f64x2.splat
	v128.store
	global.get $f64x2
	return_call $construct_from
)
