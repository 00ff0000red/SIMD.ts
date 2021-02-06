/*
api: memory_allocate

memory: clear_and_calculate_offset

storage: calculate_allocate & memory_free

Linear dependency chain:
`storage` depends on `memory`
`api` depends on `storage`
`ops` depend on `api`

 memory
   |
storage
   |
  api
   |
  ops

TODO: add a module to replace the control flow that is currently in JS; maybe expose a static `is(x: unknown): x is T` on each class, and pass into Wasm?
*/

import {
	i32,
	f32,
	i64,
	f64,
	usize
} from "./low-level-types.ts";

// for instantiating Wasm
const fetch_mapper = async (file_name: string): Promise<ArrayBuffer> => (
	await fetch(
		// TODO: don't do this
		`https://github.com/00ff0000red/SIMD.ts/blob/main/src/bin/${file_name}.wasm?raw=true`
	)
).arrayBuffer();

// TODO: update this when Deno has working WebAssembly.{compileStreaming, instantiateStreaming}
const instantiate = async (
	promise_buffer: Promise<ArrayBuffer>,
	imports?: Parameters<typeof WebAssembly.instantiate>[1]
) => (await WebAssembly.instantiate(
	await promise_buffer,
	imports
)).instance.exports;

// read all Wasm files
const [
	memory_file,
	storage_file,
	api_file,
	ops_file
] = [
	"memory",
	"storage",
	"api",
	"ops"
].map(fetch_mapper);

// instantiate

const memory_mod = await instantiate(
	memory_file
) as {
	memory: WebAssembly.Memory
};

const storage_mod = await instantiate(
	storage_file, {
		wasm: memory_mod
		// throw: () => { throw new RangeError("Array buffer allocation failed"); };
	}
) as {
	calculate_allocation: () => usize,
	memory_free: (ptr: usize) => void
};

const api_mod = await instantiate(
	api_file, {
		wasm: {
			calculate_allocation: storage_mod.calculate_allocation,
			memory: memory_mod.memory
		},
		Reflect,
		js: {
			arguments: [ memory_mod.memory.buffer, 0 | 0 ] // VM hint to i32?
			// [ ArrayBuffer, i32 ]
		}
	}
) as {
	unreachable: () => never
};

type wasm_t = i32 | f32 | i64 | f64 | usize;

type wasm_func<T extends wasm_t[] = [], H = void> = (...[]: [ usize, ...T ]) => H;

type $op = wasm_func<[ usize ], usize>;

type wasm_splat_func<T extends wasm_t> = wasm_func<[ T ], usize>;

type $op_f32 = wasm_splat_func<f32>;

type $op_i32 = wasm_splat_func<i32>;

type $op_f64 = wasm_splat_func<f64>;

type $op_i64 = wasm_splat_func<i64>;

type $op_assign = wasm_func<[ i32 ]>;

type $op_f32_assign = wasm_func<[ f32 ]>;

type $op_i32_assign = wasm_func<[ i32 ]>;

type $op_f64_assign = wasm_func<[ f64 ]>;

type $op_i64_assign = wasm_func<[ i64 ]>

type $shift = wasm_func<[ i32 ], usize>;

type $shift_assign = wasm_func<[ i32 ]>;

type $unary = wasm_func<[], usize>;

type $unary_assign = wasm_func<[], void>;

/*
TODO: move this to docs or somewhere else

$op
takes an lhs (&v128) and rhs (&v128) and returns a reference to a newly allocated v128
ex:
i32[4] lhs = (25242, -18782, -15497, 140);
i32[4] rhs = (13937, 21521, 29317, 274);
lhs + rhs;
=> &(39179, 2739, 13820, 414)

$op_f32
$op_i32
$op_f64
$op_i64

take a lhs (&v128) and a literal value,
from which a v128 is created on the stack
and returns a pointer to a newly allocated v128
ex:
i32[4] lhs = (25242, -18782, -15497, 140);
lsh + 10;
=> &(25252, -18792, -15507, 150)

$op=
Compound assigning variant of $op, for efficiency.
ex:
i32x4 lhs = (25242, -18782, -15497, 140);
i32x4 rhs = (13937, 21521, 29317, 274);
lhs += rhs;
=> (void)

$op_f32=
$op_i32=
$op_f64=
$op_i64=
Compound assigning variants.
ex:
i32[4] lhs = (25242, -18782, -15497, 140);
lsh += 10;
=> (void)

$shift
Take a v128 and an integer to shift the vector by.
Only used for (<<) and (>>) operations.
ex:
i32x4 lhs = (25242, -18782, -15497, 140);
lhs << 2;
=> &(100968, -75128, -61988, 560)

$shift=
Compound assigning variant of $shift
ex:
i32x4 lhs = (25242, -18782, -15497, 140);
lhs <<= 2;
=> (void)

$unary
Dedicated to unary operations, ex: .neg, .abs, .floor

$unary=

i32x4 lhs = (25242, -18782, -15497, 140);
i32x4 rhs = (13937, 21521, 29317, 274);
lhs + rhs;
=> &(39179, 2739, 13820, 414)
*/

// TODO: implement missing operations, such as single parameter, splatting bit-wise operations. Ex: { new TxN(...)["&="](5) }
const ops_mod = await instantiate(
	ops_file, {
		wasm: {
			alloc: storage_mod.calculate_allocation,
			memory: memory_mod.memory
		}
	}
) as {
	"i32x4.add": $op,
	"i32x4.single.add": $op_i32,
	"i32x4.add=": $op_assign,
	"i32x4.single.add=": $op_i32_assign,
	"i64x2.add": $op,
	"i64x2.single.add": $op_i64,
	"i64x2.add=": $op_assign,
	"i64x2.single.add=": $op_i64_assign,
	"i16x8.add": $op,
	"i16x8.single.add": $op_i32,
	"i16x8.add=": $op_assign,
	"i16x8.single.add=": $op_i32_assign,
	"i8x16.add": $op,
	"i8x16.single.add": $op_i32,
	"i8x16.add=": $op_assign,
	"i8x16.single.add=": $op_i32_assign,
	"f32x4.add": $op,
	"f32x4.single.add": $op_f32,
	"f32x4.add=": $op_assign,
	"f32x4.single.add=": $op_f32_assign,
	"f64x2.add": $op,
	"f64x2.single.add": $op_f64,
	"f64x2.add=": $op_assign,
	"f64x2.single.add=": $op_f64_assign,
	"i32x4.sub": $op,
	"i32x4.single.sub": $op_i32,
	"i32x4.sub=": $op_assign,
	"i32x4.single.sub=": $op_i32_assign,
	"i64x2.sub": $op,
	"i64x2.single.sub": $op_i64,
	"i64x2.sub=": $op_assign,
	"i64x2.single.sub=": $op_i64_assign,
	"i16x8.sub": $op,
	"i16x8.single.sub": $op_i32,
	"i16x8.sub=": $op_assign,
	"i16x8.single.sub=": $op_i32_assign,
	"i8x16.sub": $op,
	"i8x16.single.sub": $op_i32,
	"i8x16.sub=": $op_assign,
	"i8x16.single.sub=": $op_i32_assign,
	"f32x4.sub": $op,
	"f32x4.single.sub": $op_f32,
	"f32x4.sub=": $op_assign,
	"f32x4.single.sub=": $op_f32_assign,
	"f64x2.sub": $op,
	"f64x2.single.sub": $op_f64,
	"f64x2.sub=": $op_assign,
	"f64x2.single.sub=": $op_f64_assign,
	"i32x4.mul": $op,
	"i32x4.single.mul": $op_i32,
	"i32x4.mul=": $op_assign,
	"i32x4.single.mul=": $op_i32_assign,
	"i64x2.mul": $op,
	"i64x2.single.mul": $op_i64,
	"i64x2.mul=": $op_assign,
	"i64x2.single.mul=": $op_i64_assign,
	"i16x8.mul": $op,
	"i16x8.single.mul": $op_i32,
	"i16x8.mul=": $op_assign,
	"i16x8.single.mul=": $op_i32_assign,
	"f32x4.mul": $op,
	"f32x4.single.mul": $op_f32,
	"f32x4.mul=": $op_assign,
	"f32x4.single.mul=": $op_f32_assign,
	"f64x2.mul": $op,
	"f64x2.single.mul": $op_f64,
	"f64x2.mul=": $op_assign,
	"f64x2.single.mul=": $op_f64_assign,
	"f32x4.div": $op,
	"f32x4.single.div": $op_f32,
	"f32x4.div=": $op_assign,
	"f32x4.single.div=": $op_f32_assign,
	"f64x2.div": $op,
	"f64x2.single.div": $op_f64,
	"f64x2.div=": $op_assign,
	"f64x2.single.div=": $op_f64_assign,
	"i32x4.shift.shr_s": $shift,
	"i32x4.shift.shr_s=": $shift_assign,
	"i64x2.shift.shr_s": $shift,
	"i64x2.shift.shr_s=": $shift_assign,
	"i16x8.shift.shr_s": $shift,
	"i16x8.shift.shr_s=": $shift_assign,
	"i8x16.shift.shr_s": $shift,
	"i8x16.shift.shr_s=": $shift_assign,
	"i32x4.shift.shr_u": $shift,
	"i32x4.shift.shr_u=": $shift_assign,
	"i64x2.shift.shr_u": $shift,
	"i64x2.shift.shr_u=": $shift_assign,
	"i16x8.shift.shr_u": $shift,
	"i16x8.shift.shr_u=": $shift_assign,
	"i8x16.shift.shr_u": $shift,
	"i8x16.shift.shr_u=": $shift_assign,
	"f32x4.min": $op,
	"f32x4.single.min": $op_f32,
	"f32x4.min=": $op_assign,
	"f32x4.single.min=": $op_f32_assign,
	"f64x2.min": $op,
	"f64x2.single.min": $op_f64,
	"f64x2.min=": $op_assign,
	"f64x2.single.min=": $op_f64_assign,
	"f32x4.max": $op,
	"f32x4.single.max": $op_f32,
	"f32x4.max=": $op_assign,
	"f32x4.single.max=": $op_f32_assign,
	"f64x2.max": $op,
	"f64x2.single.max": $op_f64,
	"f64x2.max=": $op_assign,
	"f64x2.single.max=": $op_f64_assign,
	"i32x4.unary.neg": $unary,
	"i32x4.unary.neg=": $unary_assign,
	"i64x2.unary.neg": $unary,
	"i64x2.unary.neg=": $unary_assign,
	"i16x8.unary.neg": $unary,
	"i16x8.unary.neg=": $unary_assign,
	"i8x16.unary.neg": $unary,
	"i8x16.unary.neg=": $unary_assign,
	"f32x4.unary.neg": $unary,
	"f32x4.unary.neg=": $unary_assign,
	"f64x2.unary.neg": $unary,
	"f64x2.unary.neg=": $unary_assign,
	"i32x4.unary.abs": $unary,
	"i32x4.unary.abs=": $unary_assign,
	"i16x8.unary.abs": $unary,
	"i16x8.unary.abs=": $unary_assign,
	"i8x16.unary.abs": $unary,
	"i8x16.unary.abs=": $unary_assign,
	"f32x4.unary.abs": $unary,
	"f32x4.unary.abs=": $unary_assign,
	"f64x2.unary.abs": $unary,
	"f64x2.unary.abs=": $unary_assign,
	"i32x4.shift.shl": $shift,
	"i32x4.shift.shl=": $shift_assign,
	"i64x2.shift.shl": $shift,
	"i64x2.shift.shl=": $shift_assign,
	"i16x8.shift.shl": $shift,
	"i16x8.shift.shl=": $shift_assign,
	"i8x16.shift.shl": $shift,
	"i8x16.shift.shl=": $shift_assign,
	"v128.and": $op,
	"v128.and=": $op_assign,
	"v128.or": $op,
	"v128.or=": $op_assign,
	"v128.xor": $op,
	"v128.xor=": $op_assign,
	"v128.unary.not": $unary,
	"v128.unary.not=": $unary_assign,
	"i32x4.eq": $op,
	"i32x4.single.eq": $op_i32,
	"i32x4.eq=": $op_assign,
	"i32x4.single.eq=": $op_i32_assign,
	"i16x8.eq": $op,
	"i16x8.single.eq": $op_i32,
	"i16x8.eq=": $op_assign,
	"i16x8.single.eq=": $op_i32_assign,
	"i8x16.eq": $op,
	"i8x16.single.eq": $op_i32,
	"i8x16.eq=": $op_assign,
	"i8x16.single.eq=": $op_i32_assign,
	"f32x4.eq": $op,
	"f32x4.single.eq": $op_f32,
	"f32x4.eq=": $op_assign,
	"f32x4.single.eq=": $op_f32_assign,
	"f64x2.eq": $op,
	"f64x2.single.eq": $op_f64,
	"f64x2.eq=": $op_assign,
	"f64x2.single.eq=": $op_f64_assign,
	"i32x4.ne": $op,
	"i32x4.single.ne": $op_i32,
	"i32x4.ne=": $op_assign,
	"i32x4.single.ne=": $op_i32_assign,
	"i16x8.ne": $op,
	"i16x8.single.ne": $op_i32,
	"i16x8.ne=": $op_assign,
	"i16x8.single.ne=": $op_i32_assign,
	"i8x16.ne": $op,
	"i8x16.single.ne": $op_i32,
	"i8x16.ne=": $op_assign,
	"i8x16.single.ne=": $op_i32_assign,
	"f32x4.ne": $op,
	"f32x4.single.ne": $op_f32,
	"f32x4.ne=": $op_assign,
	"f32x4.single.ne=": $op_f32_assign,
	"f64x2.ne": $op,
	"f64x2.single.ne": $op_f64,
	"f64x2.ne=": $op_assign,
	"f64x2.single.ne=": $op_f64_assign,
	"f32x4.lt": $op,
	"f32x4.single.lt": $op_f32,
	"f32x4.lt=": $op_assign,
	"f32x4.single.lt=": $op_f32_assign,
	"f64x2.lt": $op,
	"f64x2.single.lt": $op_f64,
	"f64x2.lt=": $op_assign,
	"f64x2.single.lt=": $op_f64_assign,
	"i32x4.lt_s": $op,
	"i32x4.single.lt_s": $op_i32,
	"i32x4.lt_s=": $op_assign,
	"i32x4.single.lt_s=": $op_i32_assign,
	"i16x8.lt_s": $op,
	"i16x8.single.lt_s": $op_i32,
	"i16x8.lt_s=": $op_assign,
	"i16x8.single.lt_s=": $op_i32_assign,
	"i8x16.lt_s": $op,
	"i8x16.single.lt_s": $op_i32,
	"i8x16.lt_s=": $op_assign,
	"i8x16.single.lt_s=": $op_i32_assign,
	"i32x4.lt_u": $op,
	"i32x4.single.lt_u": $op_i32,
	"i32x4.lt_u=": $op_assign,
	"i32x4.single.lt_u=": $op_i32_assign,
	"i16x8.lt_u": $op,
	"i16x8.single.lt_u": $op_i32,
	"i16x8.lt_u=": $op_assign,
	"i16x8.single.lt_u=": $op_i32_assign,
	"i8x16.lt_u": $op,
	"i8x16.single.lt_u": $op_i32,
	"i8x16.lt_u=": $op_assign,
	"i8x16.single.lt_u=": $op_i32_assign,
	"f32x4.le": $op,
	"f32x4.single.le": $op_f32,
	"f32x4.le=": $op_assign,
	"f32x4.single.le=": $op_f32_assign,
	"f64x2.le": $op,
	"f64x2.single.le": $op_f64,
	"f64x2.le=": $op_assign,
	"f64x2.single.le=": $op_f64_assign,
	"i32x4.le_s": $op,
	"i32x4.single.le_s": $op_i32,
	"i32x4.le_s=": $op_assign,
	"i32x4.single.le_s=": $op_i32_assign,
	"i16x8.le_s": $op,
	"i16x8.single.le_s": $op_i32,
	"i16x8.le_s=": $op_assign,
	"i16x8.single.le_s=": $op_i32_assign,
	"i8x16.le_s": $op,
	"i8x16.single.le_s": $op_i32,
	"i8x16.le_s=": $op_assign,
	"i8x16.single.le_s=": $op_i32_assign,
	"i32x4.le_u": $op,
	"i32x4.single.le_u": $op_i32,
	"i32x4.le_u=": $op_assign,
	"i32x4.single.le_u=": $op_i32_assign,
	"i16x8.le_u": $op,
	"i16x8.single.le_u": $op_i32,
	"i16x8.le_u=": $op_assign,
	"i16x8.single.le_u=": $op_i32_assign,
	"i8x16.le_u": $op,
	"i8x16.single.le_u": $op_i32,
	"i8x16.le_u=": $op_assign,
	"i8x16.single.le_u=": $op_i32_assign,
	"f32x4.gt": $op,
	"f32x4.single.gt": $op_f32,
	"f32x4.gt=": $op_assign,
	"f32x4.single.gt=": $op_f32_assign,
	"f64x2.gt": $op,
	"f64x2.single.gt": $op_f64,
	"f64x2.gt=": $op_assign,
	"f64x2.single.gt=": $op_f64_assign,
	"i32x4.gt_s": $op,
	"i32x4.single.gt_s": $op_i32,
	"i32x4.gt_s=": $op_assign,
	"i32x4.single.gt_s=": $op_i32_assign,
	"i16x8.gt_s": $op,
	"i16x8.single.gt_s": $op_i32,
	"i16x8.gt_s=": $op_assign,
	"i16x8.single.gt_s=": $op_i32_assign,
	"i8x16.gt_s": $op,
	"i8x16.single.gt_s": $op_i32,
	"i8x16.gt_s=": $op_assign,
	"i8x16.single.gt_s=": $op_i32_assign,
	"i32x4.gt_u": $op,
	"i32x4.single.gt_u": $op_i32,
	"i32x4.gt_u=": $op_assign,
	"i32x4.single.gt_u=": $op_i32_assign,
	"i16x8.gt_u": $op,
	"i16x8.single.gt_u": $op_i32,
	"i16x8.gt_u=": $op_assign,
	"i16x8.single.gt_u=": $op_i32_assign,
	"i8x16.gt_u": $op,
	"i8x16.single.gt_u": $op_i32,
	"i8x16.gt_u=": $op_assign,
	"i8x16.single.gt_u=": $op_i32_assign,
	"f32x4.ge": $op,
	"f32x4.single.ge": $op_f32,
	"f32x4.ge=": $op_assign,
	"f32x4.single.ge=": $op_f32_assign,
	"f64x2.ge": $op,
	"f64x2.single.ge": $op_f64,
	"f64x2.ge=": $op_assign,
	"f64x2.single.ge=": $op_f64_assign,
	"i32x4.ge_s": $op,
	"i32x4.single.ge_s": $op_i32,
	"i32x4.ge_s=": $op_assign,
	"i32x4.single.ge_s=": $op_i32_assign,
	"i16x8.ge_s": $op,
	"i16x8.single.ge_s": $op_i32,
	"i16x8.ge_s=": $op_assign,
	"i16x8.single.ge_s=": $op_i32_assign,
	"i8x16.ge_s": $op,
	"i8x16.single.ge_s": $op_i32,
	"i8x16.ge_s=": $op_assign,
	"i8x16.single.ge_s=": $op_i32_assign,
	"i32x4.ge_u": $op,
	"i32x4.single.ge_u": $op_i32,
	"i32x4.ge_u=": $op_assign,
	"i32x4.single.ge_u=": $op_i32_assign,
	"i16x8.ge_u": $op,
	"i16x8.single.ge_u": $op_i32,
	"i16x8.ge_u=": $op_assign,
	"i16x8.single.ge_u=": $op_i32_assign,
	"i8x16.ge_u": $op,
	"i8x16.single.ge_u": $op_i32,
	"i8x16.ge_u=": $op_assign,
	"i8x16.single.ge_u=": $op_i32_assign,
	"f32x4.pmin": $op,
	"f32x4.single.pmin": $op_f32,
	"f32x4.pmin=": $op_assign,
	"f32x4.single.pmin=": $op_f32_assign,
	"f64x2.pmin": $op,
	"f64x2.single.pmin": $op_f64,
	"f64x2.pmin=": $op_assign,
	"f64x2.single.pmin=": $op_f64_assign,
	"f32x4.pmax": $op,
	"f32x4.single.pmax": $op_f32,
	"f32x4.pmax=": $op_assign,
	"f32x4.single.pmax=": $op_f32_assign,
	"f64x2.pmax": $op,
	"f64x2.single.pmax": $op_f64,
	"f64x2.pmax=": $op_assign,
	"f64x2.single.pmax=": $op_f64_assign,
	"f32x4.unary.sqrt": $unary,
	"f32x4.unary.sqrt=": $unary_assign,
	"f64x2.unary.sqrt": $unary,
	"f64x2.unary.sqrt=": $unary_assign,
	"f32x4.unary.ceil": $unary,
	"f32x4.unary.ceil=": $unary_assign,
	"f64x2.unary.ceil": $unary,
	"f64x2.unary.ceil=": $unary_assign,
	"f32x4.unary.floor": $unary,
	"f32x4.unary.floor=": $unary_assign,
	"f64x2.unary.floor": $unary,
	"f64x2.unary.floor=": $unary_assign,
	"f32x4.unary.trunc": $unary,
	"f32x4.unary.trunc=": $unary_assign,
	"f64x2.unary.trunc": $unary,
	"f64x2.unary.trunc=": $unary_assign,
	"f32x4.unary.nearest": $unary,
	"f32x4.unary.nearest=": $unary_assign,
	"f64x2.unary.nearest": $unary,
	"f64x2.unary.nearest=": $unary_assign,
	"i32x4.min_s": $op,
	"i32x4.single.min_s": $op_i32,
	"i32x4.min_s=": $op_assign,
	"i32x4.single.min_s=": $op_i32_assign,
	"i16x8.min_s": $op,
	"i16x8.single.min_s": $op_i32,
	"i16x8.min_s=": $op_assign,
	"i16x8.single.min_s=": $op_i32_assign,
	"i8x16.min_s": $op,
	"i8x16.single.min_s": $op_i32,
	"i8x16.min_s=": $op_assign,
	"i8x16.single.min_s=": $op_i32_assign,
	"i32x4.min_u": $op,
	"i32x4.single.min_u": $op_i32,
	"i32x4.min_u=": $op_assign,
	"i32x4.single.min_u=": $op_i32_assign,
	"i16x8.min_u": $op,
	"i16x8.single.min_u": $op_i32,
	"i16x8.min_u=": $op_assign,
	"i16x8.single.min_u=": $op_i32_assign,
	"i8x16.min_u": $op,
	"i8x16.single.min_u": $op_i32,
	"i8x16.min_u=": $op_assign,
	"i8x16.single.min_u=": $op_i32_assign,
	"i32x4.max_s": $op,
	"i32x4.single.max_s": $op_i32,
	"i32x4.max_s=": $op_assign,
	"i32x4.single.max_s=": $op_i32_assign,
	"i16x8.max_s": $op,
	"i16x8.single.max_s": $op_i32,
	"i16x8.max_s=": $op_assign,
	"i16x8.single.max_s=": $op_i32_assign,
	"i8x16.max_s": $op,
	"i8x16.single.max_s": $op_i32,
	"i8x16.max_s=": $op_assign,
	"i8x16.single.max_s=": $op_i32_assign,
	"i32x4.max_u": $op,
	"i32x4.single.max_u": $op_i32,
	"i32x4.max_u=": $op_assign,
	"i32x4.single.max_u=": $op_i32_assign,
	"i16x8.max_u": $op,
	"i16x8.single.max_u": $op_i32,
	"i16x8.max_u=": $op_assign,
	"i16x8.single.max_u=": $op_i32_assign,
	"i8x16.max_u": $op,
	"i8x16.single.max_u": $op_i32,
	"i8x16.max_u=": $op_assign,
	"i8x16.single.max_u=": $op_i32_assign
};

export const {
	calculate_allocation: allocate,
	memory_free: free
} = storage_mod;

export const memory = memory_mod.memory.buffer;

export const {
	unreachable
} = api_mod;

export {
	api_mod as api,
	ops_mod as ops
};

export interface SIMD<T, num_t extends number | bigint, N extends usize> {
	readonly buffer: never;
	readonly byteOffset: never;

	// of: (...args: TupleOf<num_t | undefined, N>) => Uint8x16;
	// from: (args: TupleOf<num_t | undefined, N>) => Uint8x16;

	// new(): this;

	"+"?(rhs: T | num_t): T;
	"+="?(rhs: T | num_t): this;
	"-"?(rhs: T | num_t): T;
	"-="?(rhs: T | num_t): this;
	"*"?(rhs: T | num_t): T;
	"*="?(rhs: T | num_t): this;

	"/"?(rhs: T | num_t): T;
	"/="?(rhs: T | num_t): this;
	">>"?(rhs: num_t): T;
	">>="?(rhs: num_t): this;
	"<<"?(rhs: num_t): T;
	"<<="?(rhs: num_t): this;
	"min"?(rhs: T | num_t): T;
	"min="?(rhs: T | num_t): this;
	"max"?(rhs: T | num_t): T;
	"max="?(rhs: T | num_t): this;
	"neg"?(rhs: T | num_t): T;
	"neg="?(rhs: T | num_t): this;
	"abs"?(rhs: T | num_t): T;
	"abs="?(rhs: T | num_t): this;
	"&"?(rhs: T | num_t): T;
	"&="?(rhs: T | num_t): this;
	"|"?(rhs: T | num_t): T;
	"|="?(rhs: T | num_t): this;
	"^"?(rhs: T | num_t): T;
	"^="?(rhs: T | num_t): this;
	"~"?(): T;
	"~="?(): this;
	"=="?(rhs: T | num_t): SIMD<T, num_t, N>;
	// "==="?(rhs: T | num_t): this;
	// assigning equality...?
	"!="?(rhs: T | num_t): SIMD<T, num_t, N>;
	// "!=="?(rhs: T | num_t): this;
	// assigning inequality

	// assigning variants of both exist
	"<"?(rhs: T | num_t): SIMD<T, num_t, N>;
	"<="?(rhs: T | num_t): SIMD<T, num_t, N>;

	">"?(rhs: T | num_t): SIMD<T, num_t, N>;
	">="?(rhs: T | num_t): SIMD<T, num_t, N>;

	"pmin"?(rhs: T | num_t): T;
	"pmin="?(rhs: T | num_t): this;
	"pmax"?(rhs: T | num_t): T;
	"pmax="?(rhs: T | num_t): this;

	"sqrt"?(): T;
	"sqrt="?(): this;

	"ceil"?(): T;
	"ceil="?(): this;

	"floor"?(): T;
	"floor="?(): this;

	"trunc"?(): T;
	"trunc="?(): this;

	// is this nint?
	"nearest"?(): T;
	"nearest="?(): this;
}

declare class FinalizationRegistry<
	Target extends object,
	Value,
	Key extends object | undefined
> {
	register(
		target: Target,
		callback_val?: Value,
		deregister_key?: Key
	): void;

	constructor(callback: (input: Value) => void);
};

"hide source";
const GarbageCollector = class extends FinalizationRegistry<SIMD<unknown, number | bigint, 16 | 8 | 4 | 2>, usize, undefined> {}

// in case of prototype corruption
GarbageCollector.prototype.register = FinalizationRegistry.prototype.register;

export const garbageCollector = new GarbageCollector(free);
// calls Wasm `free` to mark the vector's memory as free, and clears memory with zeros
