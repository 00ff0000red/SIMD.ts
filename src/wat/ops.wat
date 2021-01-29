;; ops

(import "wasm" "alloc" (func $alloc (result i32)))
(import "wasm" "memory" (memory 4 4))

(type $op (func (param i32 i32) (result i32)))
(type $op_f32 (func (param i32 f32) (result i32)))
(type $op_i32 (func (param i32 i32) (result i32)))
(type $op_f64 (func (param i32 f64) (result i32)))
(type $op_i64 (func (param i32 i64) (result i32)))
(type $op= (func (param i32 i32)))
(type $op_f32= (func (param i32 f32)))
(type $op_i32= (func (param i32 i32)))
(type $op_f64= (func (param i32 f64)))
(type $op_i64= (func (param i32 i64)))
(type $shift (func (param i32 i32) (result i32)))
(type $shift= (func (param i32 i32)))
(type $unary (func (param i32) (result i32)))
(type $unary= (func (param i32)))

;; temporary polyfill
(func $dup (param i32) (result i32 i32)
	local.get 0
	local.get 0
)

(func (export "i8x16.add") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.add
	v128.store align=16
)

(func (export "i8x16.single.add") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.add
	v128.store align=16
)

(func (export "i8x16.add=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.add
	v128.store align=16
)

(func (export "i8x16.single.add=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.add
	v128.store align=16
)

(func (export "i16x8.add") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.add
	v128.store align=16
)

(func (export "i16x8.single.add") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.add
	v128.store align=16
)

(func (export "i16x8.add=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.add
	v128.store align=16
)

(func (export "i16x8.single.add=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.add
	v128.store align=16
)

(func (export "i32x4.add") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.add
	v128.store align=16
)

(func (export "i32x4.single.add") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.add
	v128.store align=16
)

(func (export "i32x4.add=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.add
	v128.store align=16
)

(func (export "i32x4.single.add=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.add
	v128.store align=16
)

(func (export "i64x2.add") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i64x2.add
	v128.store align=16
)

(func (export "i64x2.single.add") (type $op_i64)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i64x2.splat
	i64x2.add
	v128.store align=16
)

(func (export "i64x2.add=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i64x2.add
	v128.store align=16
)

(func (export "i64x2.single.add=") (type $op_i64=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i64x2.splat
	i64x2.add
	v128.store align=16
)

(func (export "f32x4.add") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.add
	v128.store align=16
)

(func (export "f32x4.single.add") (type $op_f32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.add
	v128.store align=16
)

(func (export "f32x4.add=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.add
	v128.store align=16
)

(func (export "f32x4.single.add=") (type $op_f32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.add
	v128.store align=16
)

(func (export "f64x2.add") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.add
	v128.store align=16
)

(func (export "f64x2.single.add") (type $op_f64)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.add
	v128.store align=16
)

(func (export "f64x2.add=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.add
	v128.store align=16
)

(func (export "f64x2.single.add=") (type $op_f64=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.add
	v128.store align=16
)

(func (export "i8x16.sub") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.sub
	v128.store align=16
)

(func (export "i8x16.single.sub") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.sub
	v128.store align=16
)

(func (export "i8x16.sub=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.sub
	v128.store align=16
)

(func (export "i8x16.single.sub=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.sub
	v128.store align=16
)

(func (export "i16x8.sub") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.sub
	v128.store align=16
)

(func (export "i16x8.single.sub") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.sub
	v128.store align=16
)

(func (export "i16x8.sub=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.sub
	v128.store align=16
)

(func (export "i16x8.single.sub=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.sub
	v128.store align=16
)

(func (export "i32x4.sub") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.sub
	v128.store align=16
)

(func (export "i32x4.single.sub") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.sub
	v128.store align=16
)

(func (export "i32x4.sub=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.sub
	v128.store align=16
)

(func (export "i32x4.single.sub=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.sub
	v128.store align=16
)

(func (export "i64x2.sub") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i64x2.sub
	v128.store align=16
)

(func (export "i64x2.single.sub") (type $op_i64)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i64x2.splat
	i64x2.sub
	v128.store align=16
)

(func (export "i64x2.sub=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i64x2.sub
	v128.store align=16
)

(func (export "i64x2.single.sub=") (type $op_i64=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i64x2.splat
	i64x2.sub
	v128.store align=16
)

(func (export "f32x4.sub") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.sub
	v128.store align=16
)

(func (export "f32x4.single.sub") (type $op_f32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.sub
	v128.store align=16
)

(func (export "f32x4.sub=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.sub
	v128.store align=16
)

(func (export "f32x4.single.sub=") (type $op_f32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.sub
	v128.store align=16
)

(func (export "f64x2.sub") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.sub
	v128.store align=16
)

(func (export "f64x2.single.sub") (type $op_f64)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.sub
	v128.store align=16
)

(func (export "f64x2.sub=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.sub
	v128.store align=16
)

(func (export "f64x2.single.sub=") (type $op_f64=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.sub
	v128.store align=16
)

(func (export "i16x8.mul") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.mul
	v128.store align=16
)

(func (export "i16x8.single.mul") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.mul
	v128.store align=16
)

(func (export "i16x8.mul=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.mul
	v128.store align=16
)

(func (export "i16x8.single.mul=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.mul
	v128.store align=16
)

(func (export "i32x4.mul") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.mul
	v128.store align=16
)

(func (export "i32x4.single.mul") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.mul
	v128.store align=16
)

(func (export "i32x4.mul=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.mul
	v128.store align=16
)

(func (export "i32x4.single.mul=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.mul
	v128.store align=16
)

(func (export "i64x2.mul") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i64x2.mul
	v128.store align=16
)

(func (export "i64x2.single.mul") (type $op_i64)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i64x2.splat
	i64x2.mul
	v128.store align=16
)

(func (export "i64x2.mul=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i64x2.mul
	v128.store align=16
)

(func (export "i64x2.single.mul=") (type $op_i64=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i64x2.splat
	i64x2.mul
	v128.store align=16
)

(func (export "f32x4.mul") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.mul
	v128.store align=16
)

(func (export "f32x4.single.mul") (type $op_f32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.mul
	v128.store align=16
)

(func (export "f32x4.mul=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.mul
	v128.store align=16
)

(func (export "f32x4.single.mul=") (type $op_f32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.mul
	v128.store align=16
)

(func (export "f64x2.mul") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.mul
	v128.store align=16
)

(func (export "f64x2.single.mul") (type $op_f64)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.mul
	v128.store align=16
)

(func (export "f64x2.mul=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.mul
	v128.store align=16
)

(func (export "f64x2.single.mul=") (type $op_f64=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.mul
	v128.store align=16
)

(func (export "f32x4.div") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.div
	v128.store align=16
)

(func (export "f32x4.single.div") (type $op_f32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.div
	v128.store align=16
)

(func (export "f32x4.div=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.div
	v128.store align=16
)

(func (export "f32x4.single.div=") (type $op_f32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.div
	v128.store align=16
)

(func (export "f64x2.div") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.div
	v128.store align=16
)

(func (export "f64x2.single.div") (type $op_f64)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.div
	v128.store align=16
)

(func (export "f64x2.div=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.div
	v128.store align=16
)

(func (export "f64x2.single.div=") (type $op_f64=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.div
	v128.store align=16
)

(func (export "i8x16.shift.shr_s") (type $shift)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.shr_s
	v128.store align=16
)

(func (export "i8x16.shift.shr_s=") (type $shift=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.shr_s
	v128.store align=16
)

(func (export "i16x8.shift.shr_s") (type $shift)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.shr_s
	v128.store align=16
)

(func (export "i16x8.shift.shr_s=") (type $shift=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.shr_s
	v128.store align=16
)

(func (export "i32x4.shift.shr_s") (type $shift)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.shr_s
	v128.store align=16
)

(func (export "i32x4.shift.shr_s=") (type $shift=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.shr_s
	v128.store align=16
)

(func (export "i64x2.shift.shr_s") (type $shift)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i64x2.shr_s
	v128.store align=16
)

(func (export "i64x2.shift.shr_s=") (type $shift=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i64x2.shr_s
	v128.store align=16
)

(func (export "i8x16.shift.shr_u") (type $shift)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.shr_u
	v128.store align=16
)

(func (export "i8x16.shift.shr_u=") (type $shift=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.shr_u
	v128.store align=16
)

(func (export "i16x8.shift.shr_u") (type $shift)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.shr_u
	v128.store align=16
)

(func (export "i16x8.shift.shr_u=") (type $shift=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.shr_u
	v128.store align=16
)

(func (export "i32x4.shift.shr_u") (type $shift)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.shr_u
	v128.store align=16
)

(func (export "i32x4.shift.shr_u=") (type $shift=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.shr_u
	v128.store align=16
)

(func (export "i64x2.shift.shr_u") (type $shift)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i64x2.shr_u
	v128.store align=16
)

(func (export "i64x2.shift.shr_u=") (type $shift=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i64x2.shr_u
	v128.store align=16
)

(func (export "f32x4.min") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.min
	v128.store align=16
)

(func (export "f32x4.single.min") (type $op_f32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.min
	v128.store align=16
)

(func (export "f32x4.min=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.min
	v128.store align=16
)

(func (export "f32x4.single.min=") (type $op_f32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.min
	v128.store align=16
)

(func (export "f64x2.min") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.min
	v128.store align=16
)

(func (export "f64x2.single.min") (type $op_f64)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.min
	v128.store align=16
)

(func (export "f64x2.min=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.min
	v128.store align=16
)

(func (export "f64x2.single.min=") (type $op_f64=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.min
	v128.store align=16
)

(func (export "f32x4.max") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.max
	v128.store align=16
)

(func (export "f32x4.single.max") (type $op_f32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.max
	v128.store align=16
)

(func (export "f32x4.max=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.max
	v128.store align=16
)

(func (export "f32x4.single.max=") (type $op_f32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.max
	v128.store align=16
)

(func (export "f64x2.max") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.max
	v128.store align=16
)

(func (export "f64x2.single.max") (type $op_f64)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.max
	v128.store align=16
)

(func (export "f64x2.max=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.max
	v128.store align=16
)

(func (export "f64x2.single.max=") (type $op_f64=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.max
	v128.store align=16
)

(func (export "i8x16.unary.neg") (type $unary)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	i8x16.neg
	v128.store align=16
)

(func (export "i8x16.unary.neg=") (type $unary=)
	local.get 0
	local.get 0
	v128.load align=16
	i8x16.neg
	v128.store align=16
)

(func (export "i16x8.unary.neg") (type $unary)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	i16x8.neg
	v128.store align=16
)

(func (export "i16x8.unary.neg=") (type $unary=)
	local.get 0
	local.get 0
	v128.load align=16
	i16x8.neg
	v128.store align=16
)

(func (export "i32x4.unary.neg") (type $unary)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	i32x4.neg
	v128.store align=16
)

(func (export "i32x4.unary.neg=") (type $unary=)
	local.get 0
	local.get 0
	v128.load align=16
	i32x4.neg
	v128.store align=16
)

(func (export "i64x2.unary.neg") (type $unary)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	i64x2.neg
	v128.store align=16
)

(func (export "i64x2.unary.neg=") (type $unary=)
	local.get 0
	local.get 0
	v128.load align=16
	i64x2.neg
	v128.store align=16
)

(func (export "f32x4.unary.neg") (type $unary)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	f32x4.neg
	v128.store align=16
)

(func (export "f32x4.unary.neg=") (type $unary=)
	local.get 0
	local.get 0
	v128.load align=16
	f32x4.neg
	v128.store align=16
)

(func (export "f64x2.unary.neg") (type $unary)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	f64x2.neg
	v128.store align=16
)

(func (export "f64x2.unary.neg=") (type $unary=)
	local.get 0
	local.get 0
	v128.load align=16
	f64x2.neg
	v128.store align=16
)

(func (export "i8x16.unary.abs") (type $unary)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	i8x16.abs
	v128.store align=16
)

(func (export "i8x16.unary.abs=") (type $unary=)
	local.get 0
	local.get 0
	v128.load align=16
	i8x16.abs
	v128.store align=16
)

(func (export "i16x8.unary.abs") (type $unary)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	i16x8.abs
	v128.store align=16
)

(func (export "i16x8.unary.abs=") (type $unary=)
	local.get 0
	local.get 0
	v128.load align=16
	i16x8.abs
	v128.store align=16
)

(func (export "i32x4.unary.abs") (type $unary)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	i32x4.abs
	v128.store align=16
)

(func (export "i32x4.unary.abs=") (type $unary=)
	local.get 0
	local.get 0
	v128.load align=16
	i32x4.abs
	v128.store align=16
)

(func (export "f32x4.unary.abs") (type $unary)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	f32x4.abs
	v128.store align=16
)

(func (export "f32x4.unary.abs=") (type $unary=)
	local.get 0
	local.get 0
	v128.load align=16
	f32x4.abs
	v128.store align=16
)

(func (export "f64x2.unary.abs") (type $unary)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	f64x2.abs
	v128.store align=16
)

(func (export "f64x2.unary.abs=") (type $unary=)
	local.get 0
	local.get 0
	v128.load align=16
	f64x2.abs
	v128.store align=16
)

(func (export "i8x16.shift.shl") (type $shift)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.shl
	v128.store align=16
)

(func (export "i8x16.shift.shl=") (type $shift=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.shl
	v128.store align=16
)

(func (export "i16x8.shift.shl") (type $shift)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.shl
	v128.store align=16
)

(func (export "i16x8.shift.shl=") (type $shift=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.shl
	v128.store align=16
)

(func (export "i32x4.shift.shl") (type $shift)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.shl
	v128.store align=16
)

(func (export "i32x4.shift.shl=") (type $shift=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.shl
	v128.store align=16
)

(func (export "i64x2.shift.shl") (type $shift)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i64x2.shl
	v128.store align=16
)

(func (export "i64x2.shift.shl=") (type $shift=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i64x2.shl
	v128.store align=16
)

(func (export "v128.and") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	v128.and
	v128.store align=16
)

(func (export "v128.or") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	v128.or
	v128.store align=16
)

(func (export "v128.xor") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	v128.xor
	v128.store align=16
)

(func (export "i8x16.eq") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.eq
	v128.store align=16
)

(func (export "i8x16.single.eq") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.eq
	v128.store align=16
)

(func (export "i8x16.eq=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.eq
	v128.store align=16
)

(func (export "i8x16.single.eq=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.eq
	v128.store align=16
)

(func (export "i16x8.eq") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.eq
	v128.store align=16
)

(func (export "i16x8.single.eq") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.eq
	v128.store align=16
)

(func (export "i16x8.eq=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.eq
	v128.store align=16
)

(func (export "i16x8.single.eq=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.eq
	v128.store align=16
)

(func (export "i32x4.eq") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.eq
	v128.store align=16
)

(func (export "i32x4.single.eq") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.eq
	v128.store align=16
)

(func (export "i32x4.eq=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.eq
	v128.store align=16
)

(func (export "i32x4.single.eq=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.eq
	v128.store align=16
)

(func (export "f32x4.eq") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.eq
	v128.store align=16
)

(func (export "f32x4.single.eq") (type $op_f32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.eq
	v128.store align=16
)

(func (export "f32x4.eq=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.eq
	v128.store align=16
)

(func (export "f32x4.single.eq=") (type $op_f32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.eq
	v128.store align=16
)

(func (export "f64x2.eq") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.eq
	v128.store align=16
)

(func (export "f64x2.single.eq") (type $op_f64)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.eq
	v128.store align=16
)

(func (export "f64x2.eq=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.eq
	v128.store align=16
)

(func (export "f64x2.single.eq=") (type $op_f64=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.eq
	v128.store align=16
)

(func (export "i8x16.ne") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.ne
	v128.store align=16
)

(func (export "i8x16.single.ne") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.ne
	v128.store align=16
)

(func (export "i8x16.ne=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.ne
	v128.store align=16
)

(func (export "i8x16.single.ne=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.ne
	v128.store align=16
)

(func (export "i16x8.ne") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.ne
	v128.store align=16
)

(func (export "i16x8.single.ne") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.ne
	v128.store align=16
)

(func (export "i16x8.ne=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.ne
	v128.store align=16
)

(func (export "i16x8.single.ne=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.ne
	v128.store align=16
)

(func (export "i32x4.ne") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.ne
	v128.store align=16
)

(func (export "i32x4.single.ne") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.ne
	v128.store align=16
)

(func (export "i32x4.ne=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.ne
	v128.store align=16
)

(func (export "i32x4.single.ne=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.ne
	v128.store align=16
)

(func (export "f32x4.ne") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.ne
	v128.store align=16
)

(func (export "f32x4.single.ne") (type $op_f32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.ne
	v128.store align=16
)

(func (export "f32x4.ne=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.ne
	v128.store align=16
)

(func (export "f32x4.single.ne=") (type $op_f32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.ne
	v128.store align=16
)

(func (export "f64x2.ne") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.ne
	v128.store align=16
)

(func (export "f64x2.single.ne") (type $op_f64)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.ne
	v128.store align=16
)

(func (export "f64x2.ne=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.ne
	v128.store align=16
)

(func (export "f64x2.single.ne=") (type $op_f64=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.ne
	v128.store align=16
)

(func (export "f32x4.lt") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.lt
	v128.store align=16
)

(func (export "f32x4.single.lt") (type $op_f32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.lt
	v128.store align=16
)

(func (export "f32x4.lt=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.lt
	v128.store align=16
)

(func (export "f32x4.single.lt=") (type $op_f32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.lt
	v128.store align=16
)

(func (export "f64x2.lt") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.lt
	v128.store align=16
)

(func (export "f64x2.single.lt") (type $op_f64)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.lt
	v128.store align=16
)

(func (export "f64x2.lt=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.lt
	v128.store align=16
)

(func (export "f64x2.single.lt=") (type $op_f64=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.lt
	v128.store align=16
)

(func (export "i8x16.lt_s") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.lt_s
	v128.store align=16
)

(func (export "i8x16.single.lt_s") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.lt_s
	v128.store align=16
)

(func (export "i8x16.lt_s=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.lt_s
	v128.store align=16
)

(func (export "i8x16.single.lt_s=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.lt_s
	v128.store align=16
)

(func (export "i16x8.lt_s") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.lt_s
	v128.store align=16
)

(func (export "i16x8.single.lt_s") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.lt_s
	v128.store align=16
)

(func (export "i16x8.lt_s=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.lt_s
	v128.store align=16
)

(func (export "i16x8.single.lt_s=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.lt_s
	v128.store align=16
)

(func (export "i32x4.lt_s") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.lt_s
	v128.store align=16
)

(func (export "i32x4.single.lt_s") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.lt_s
	v128.store align=16
)

(func (export "i32x4.lt_s=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.lt_s
	v128.store align=16
)

(func (export "i32x4.single.lt_s=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.lt_s
	v128.store align=16
)

(func (export "i8x16.lt_u") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.lt_u
	v128.store align=16
)

(func (export "i8x16.single.lt_u") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.lt_u
	v128.store align=16
)

(func (export "i8x16.lt_u=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.lt_u
	v128.store align=16
)

(func (export "i8x16.single.lt_u=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.lt_u
	v128.store align=16
)

(func (export "i16x8.lt_u") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.lt_u
	v128.store align=16
)

(func (export "i16x8.single.lt_u") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.lt_u
	v128.store align=16
)

(func (export "i16x8.lt_u=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.lt_u
	v128.store align=16
)

(func (export "i16x8.single.lt_u=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.lt_u
	v128.store align=16
)

(func (export "i32x4.lt_u") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.lt_u
	v128.store align=16
)

(func (export "i32x4.single.lt_u") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.lt_u
	v128.store align=16
)

(func (export "i32x4.lt_u=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.lt_u
	v128.store align=16
)

(func (export "i32x4.single.lt_u=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.lt_u
	v128.store align=16
)

(func (export "f32x4.le") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.le
	v128.store align=16
)

(func (export "f32x4.single.le") (type $op_f32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.le
	v128.store align=16
)

(func (export "f32x4.le=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.le
	v128.store align=16
)

(func (export "f32x4.single.le=") (type $op_f32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.le
	v128.store align=16
)

(func (export "f64x2.le") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.le
	v128.store align=16
)

(func (export "f64x2.single.le") (type $op_f64)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.le
	v128.store align=16
)

(func (export "f64x2.le=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.le
	v128.store align=16
)

(func (export "f64x2.single.le=") (type $op_f64=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.le
	v128.store align=16
)

(func (export "i8x16.le_s") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.le_s
	v128.store align=16
)

(func (export "i8x16.single.le_s") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.le_s
	v128.store align=16
)

(func (export "i8x16.le_s=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.le_s
	v128.store align=16
)

(func (export "i8x16.single.le_s=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.le_s
	v128.store align=16
)

(func (export "i16x8.le_s") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.le_s
	v128.store align=16
)

(func (export "i16x8.single.le_s") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.le_s
	v128.store align=16
)

(func (export "i16x8.le_s=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.le_s
	v128.store align=16
)

(func (export "i16x8.single.le_s=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.le_s
	v128.store align=16
)

(func (export "i32x4.le_s") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.le_s
	v128.store align=16
)

(func (export "i32x4.single.le_s") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.le_s
	v128.store align=16
)

(func (export "i32x4.le_s=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.le_s
	v128.store align=16
)

(func (export "i32x4.single.le_s=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.le_s
	v128.store align=16
)

(func (export "i8x16.le_u") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.le_u
	v128.store align=16
)

(func (export "i8x16.single.le_u") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.le_u
	v128.store align=16
)

(func (export "i8x16.le_u=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.le_u
	v128.store align=16
)

(func (export "i8x16.single.le_u=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.le_u
	v128.store align=16
)

(func (export "i16x8.le_u") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.le_u
	v128.store align=16
)

(func (export "i16x8.single.le_u") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.le_u
	v128.store align=16
)

(func (export "i16x8.le_u=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.le_u
	v128.store align=16
)

(func (export "i16x8.single.le_u=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.le_u
	v128.store align=16
)

(func (export "i32x4.le_u") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.le_u
	v128.store align=16
)

(func (export "i32x4.single.le_u") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.le_u
	v128.store align=16
)

(func (export "i32x4.le_u=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.le_u
	v128.store align=16
)

(func (export "i32x4.single.le_u=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.le_u
	v128.store align=16
)

(func (export "f32x4.gt") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.gt
	v128.store align=16
)

(func (export "f32x4.single.gt") (type $op_f32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.gt
	v128.store align=16
)

(func (export "f32x4.gt=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.gt
	v128.store align=16
)

(func (export "f32x4.single.gt=") (type $op_f32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.gt
	v128.store align=16
)

(func (export "f64x2.gt") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.gt
	v128.store align=16
)

(func (export "f64x2.single.gt") (type $op_f64)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.gt
	v128.store align=16
)

(func (export "f64x2.gt=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.gt
	v128.store align=16
)

(func (export "f64x2.single.gt=") (type $op_f64=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.gt
	v128.store align=16
)

(func (export "i8x16.gt_s") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.gt_s
	v128.store align=16
)

(func (export "i8x16.single.gt_s") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.gt_s
	v128.store align=16
)

(func (export "i8x16.gt_s=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.gt_s
	v128.store align=16
)

(func (export "i8x16.single.gt_s=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.gt_s
	v128.store align=16
)

(func (export "i16x8.gt_s") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.gt_s
	v128.store align=16
)

(func (export "i16x8.single.gt_s") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.gt_s
	v128.store align=16
)

(func (export "i16x8.gt_s=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.gt_s
	v128.store align=16
)

(func (export "i16x8.single.gt_s=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.gt_s
	v128.store align=16
)

(func (export "i32x4.gt_s") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.gt_s
	v128.store align=16
)

(func (export "i32x4.single.gt_s") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.gt_s
	v128.store align=16
)

(func (export "i32x4.gt_s=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.gt_s
	v128.store align=16
)

(func (export "i32x4.single.gt_s=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.gt_s
	v128.store align=16
)

(func (export "i8x16.gt_u") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.gt_u
	v128.store align=16
)

(func (export "i8x16.single.gt_u") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.gt_u
	v128.store align=16
)

(func (export "i8x16.gt_u=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.gt_u
	v128.store align=16
)

(func (export "i8x16.single.gt_u=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.gt_u
	v128.store align=16
)

(func (export "i16x8.gt_u") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.gt_u
	v128.store align=16
)

(func (export "i16x8.single.gt_u") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.gt_u
	v128.store align=16
)

(func (export "i16x8.gt_u=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.gt_u
	v128.store align=16
)

(func (export "i16x8.single.gt_u=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.gt_u
	v128.store align=16
)

(func (export "i32x4.gt_u") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.gt_u
	v128.store align=16
)

(func (export "i32x4.single.gt_u") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.gt_u
	v128.store align=16
)

(func (export "i32x4.gt_u=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.gt_u
	v128.store align=16
)

(func (export "i32x4.single.gt_u=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.gt_u
	v128.store align=16
)

(func (export "f32x4.ge") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.ge
	v128.store align=16
)

(func (export "f32x4.single.ge") (type $op_f32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.ge
	v128.store align=16
)

(func (export "f32x4.ge=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.ge
	v128.store align=16
)

(func (export "f32x4.single.ge=") (type $op_f32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.ge
	v128.store align=16
)

(func (export "f64x2.ge") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.ge
	v128.store align=16
)

(func (export "f64x2.single.ge") (type $op_f64)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.ge
	v128.store align=16
)

(func (export "f64x2.ge=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.ge
	v128.store align=16
)

(func (export "f64x2.single.ge=") (type $op_f64=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.ge
	v128.store align=16
)

(func (export "i8x16.ge_s") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.ge_s
	v128.store align=16
)

(func (export "i8x16.single.ge_s") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.ge_s
	v128.store align=16
)

(func (export "i8x16.ge_s=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.ge_s
	v128.store align=16
)

(func (export "i8x16.single.ge_s=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.ge_s
	v128.store align=16
)

(func (export "i16x8.ge_s") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.ge_s
	v128.store align=16
)

(func (export "i16x8.single.ge_s") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.ge_s
	v128.store align=16
)

(func (export "i16x8.ge_s=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.ge_s
	v128.store align=16
)

(func (export "i16x8.single.ge_s=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.ge_s
	v128.store align=16
)

(func (export "i32x4.ge_s") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.ge_s
	v128.store align=16
)

(func (export "i32x4.single.ge_s") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.ge_s
	v128.store align=16
)

(func (export "i32x4.ge_s=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.ge_s
	v128.store align=16
)

(func (export "i32x4.single.ge_s=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.ge_s
	v128.store align=16
)

(func (export "i8x16.ge_u") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.ge_u
	v128.store align=16
)

(func (export "i8x16.single.ge_u") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.ge_u
	v128.store align=16
)

(func (export "i8x16.ge_u=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.ge_u
	v128.store align=16
)

(func (export "i8x16.single.ge_u=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.ge_u
	v128.store align=16
)

(func (export "i16x8.ge_u") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.ge_u
	v128.store align=16
)

(func (export "i16x8.single.ge_u") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.ge_u
	v128.store align=16
)

(func (export "i16x8.ge_u=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.ge_u
	v128.store align=16
)

(func (export "i16x8.single.ge_u=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.ge_u
	v128.store align=16
)

(func (export "i32x4.ge_u") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.ge_u
	v128.store align=16
)

(func (export "i32x4.single.ge_u") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.ge_u
	v128.store align=16
)

(func (export "i32x4.ge_u=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.ge_u
	v128.store align=16
)

(func (export "i32x4.single.ge_u=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.ge_u
	v128.store align=16
)

(func (export "f32x4.pmin") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.pmin
	v128.store align=16
)

(func (export "f32x4.single.pmin") (type $op_f32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.pmin
	v128.store align=16
)

(func (export "f32x4.pmin=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.pmin
	v128.store align=16
)

(func (export "f32x4.single.pmin=") (type $op_f32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.pmin
	v128.store align=16
)

(func (export "f64x2.pmin") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.pmin
	v128.store align=16
)

(func (export "f64x2.single.pmin") (type $op_f64)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.pmin
	v128.store align=16
)

(func (export "f64x2.pmin=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.pmin
	v128.store align=16
)

(func (export "f64x2.single.pmin=") (type $op_f64=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.pmin
	v128.store align=16
)

(func (export "f32x4.pmax") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.pmax
	v128.store align=16
)

(func (export "f32x4.single.pmax") (type $op_f32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.pmax
	v128.store align=16
)

(func (export "f32x4.pmax=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f32x4.pmax
	v128.store align=16
)

(func (export "f32x4.single.pmax=") (type $op_f32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f32x4.splat
	f32x4.pmax
	v128.store align=16
)

(func (export "f64x2.pmax") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.pmax
	v128.store align=16
)

(func (export "f64x2.single.pmax") (type $op_f64)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.pmax
	v128.store align=16
)

(func (export "f64x2.pmax=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	f64x2.pmax
	v128.store align=16
)

(func (export "f64x2.single.pmax=") (type $op_f64=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	f64x2.splat
	f64x2.pmax
	v128.store align=16
)

(func (export "f32x4.unary.sqrt") (type $unary)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	f32x4.sqrt
	v128.store align=16
)

(func (export "f32x4.unary.sqrt=") (type $unary=)
	local.get 0
	local.get 0
	v128.load align=16
	f32x4.sqrt
	v128.store align=16
)

(func (export "f64x2.unary.sqrt") (type $unary)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	f64x2.sqrt
	v128.store align=16
)

(func (export "f64x2.unary.sqrt=") (type $unary=)
	local.get 0
	local.get 0
	v128.load align=16
	f64x2.sqrt
	v128.store align=16
)

(func (export "f32x4.unary.ceil") (type $unary)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	f32x4.ceil
	v128.store align=16
)

(func (export "f32x4.unary.ceil=") (type $unary=)
	local.get 0
	local.get 0
	v128.load align=16
	f32x4.ceil
	v128.store align=16
)

(func (export "f64x2.unary.ceil") (type $unary)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	f64x2.ceil
	v128.store align=16
)

(func (export "f64x2.unary.ceil=") (type $unary=)
	local.get 0
	local.get 0
	v128.load align=16
	f64x2.ceil
	v128.store align=16
)

(func (export "f32x4.unary.floor") (type $unary)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	f32x4.floor
	v128.store align=16
)

(func (export "f32x4.unary.floor=") (type $unary=)
	local.get 0
	local.get 0
	v128.load align=16
	f32x4.floor
	v128.store align=16
)

(func (export "f64x2.unary.floor") (type $unary)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	f64x2.floor
	v128.store align=16
)

(func (export "f64x2.unary.floor=") (type $unary=)
	local.get 0
	local.get 0
	v128.load align=16
	f64x2.floor
	v128.store align=16
)

(func (export "f32x4.unary.trunc") (type $unary)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	f32x4.trunc
	v128.store align=16
)

(func (export "f32x4.unary.trunc=") (type $unary=)
	local.get 0
	local.get 0
	v128.load align=16
	f32x4.trunc
	v128.store align=16
)

(func (export "f64x2.unary.trunc") (type $unary)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	f64x2.trunc
	v128.store align=16
)

(func (export "f64x2.unary.trunc=") (type $unary=)
	local.get 0
	local.get 0
	v128.load align=16
	f64x2.trunc
	v128.store align=16
)

(func (export "f32x4.unary.nearest") (type $unary)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	f32x4.nearest
	v128.store align=16
)

(func (export "f32x4.unary.nearest=") (type $unary=)
	local.get 0
	local.get 0
	v128.load align=16
	f32x4.nearest
	v128.store align=16
)

(func (export "f64x2.unary.nearest") (type $unary)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	f64x2.nearest
	v128.store align=16
)

(func (export "f64x2.unary.nearest=") (type $unary=)
	local.get 0
	local.get 0
	v128.load align=16
	f64x2.nearest
	v128.store align=16
)

(func (export "i8x16.min_s") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.min_s
	v128.store align=16
)

(func (export "i8x16.single.min_s") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.min_s
	v128.store align=16
)

(func (export "i8x16.min_s=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.min_s
	v128.store align=16
)

(func (export "i8x16.single.min_s=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.min_s
	v128.store align=16
)

(func (export "i16x8.min_s") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.min_s
	v128.store align=16
)

(func (export "i16x8.single.min_s") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.min_s
	v128.store align=16
)

(func (export "i16x8.min_s=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.min_s
	v128.store align=16
)

(func (export "i16x8.single.min_s=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.min_s
	v128.store align=16
)

(func (export "i32x4.min_s") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.min_s
	v128.store align=16
)

(func (export "i32x4.single.min_s") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.min_s
	v128.store align=16
)

(func (export "i32x4.min_s=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.min_s
	v128.store align=16
)

(func (export "i32x4.single.min_s=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.min_s
	v128.store align=16
)

(func (export "i8x16.min_u") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.min_u
	v128.store align=16
)

(func (export "i8x16.single.min_u") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.min_u
	v128.store align=16
)

(func (export "i8x16.min_u=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.min_u
	v128.store align=16
)

(func (export "i8x16.single.min_u=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.min_u
	v128.store align=16
)

(func (export "i16x8.min_u") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.min_u
	v128.store align=16
)

(func (export "i16x8.single.min_u") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.min_u
	v128.store align=16
)

(func (export "i16x8.min_u=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.min_u
	v128.store align=16
)

(func (export "i16x8.single.min_u=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.min_u
	v128.store align=16
)

(func (export "i32x4.min_u") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.min_u
	v128.store align=16
)

(func (export "i32x4.single.min_u") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.min_u
	v128.store align=16
)

(func (export "i32x4.min_u=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.min_u
	v128.store align=16
)

(func (export "i32x4.single.min_u=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.min_u
	v128.store align=16
)

(func (export "i8x16.max_s") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.max_s
	v128.store align=16
)

(func (export "i8x16.single.max_s") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.max_s
	v128.store align=16
)

(func (export "i8x16.max_s=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.max_s
	v128.store align=16
)

(func (export "i8x16.single.max_s=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.max_s
	v128.store align=16
)

(func (export "i16x8.max_s") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.max_s
	v128.store align=16
)

(func (export "i16x8.single.max_s") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.max_s
	v128.store align=16
)

(func (export "i16x8.max_s=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.max_s
	v128.store align=16
)

(func (export "i16x8.single.max_s=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.max_s
	v128.store align=16
)

(func (export "i32x4.max_s") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.max_s
	v128.store align=16
)

(func (export "i32x4.single.max_s") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.max_s
	v128.store align=16
)

(func (export "i32x4.max_s=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.max_s
	v128.store align=16
)

(func (export "i32x4.single.max_s=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.max_s
	v128.store align=16
)

(func (export "i8x16.max_u") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.max_u
	v128.store align=16
)

(func (export "i8x16.single.max_u") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.max_u
	v128.store align=16
)

(func (export "i8x16.max_u=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i8x16.max_u
	v128.store align=16
)

(func (export "i8x16.single.max_u=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i8x16.splat
	i8x16.max_u
	v128.store align=16
)

(func (export "i16x8.max_u") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.max_u
	v128.store align=16
)

(func (export "i16x8.single.max_u") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.max_u
	v128.store align=16
)

(func (export "i16x8.max_u=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i16x8.max_u
	v128.store align=16
)

(func (export "i16x8.single.max_u=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i16x8.splat
	i16x8.max_u
	v128.store align=16
)

(func (export "i32x4.max_u") (type $op)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.max_u
	v128.store align=16
)

(func (export "i32x4.single.max_u") (type $op_i32)
	call $alloc
	call $dup
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.max_u
	v128.store align=16
)

(func (export "i32x4.max_u=") (type $op=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	v128.load align=16
	i32x4.max_u
	v128.store align=16
)

(func (export "i32x4.single.max_u=") (type $op_i32=)
	local.get 0
	local.get 0
	v128.load align=16
	local.get 1
	i32x4.splat
	i32x4.max_u
	v128.store align=16
)
