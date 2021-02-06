// Types reused across the TS
// individually export because of --isolated-modules
// most are for readability + semantics, these provide no "real" safety

export type i8 = number;
export type i16 = number;
export type i32 = number;
export type i64 = bigint;

export type u8 = i8;
export type u16 = i16;
export type u32 = i32;
export type u64 = i64;

export type s8 = i8;
export type s16 = i16;
export type s32 = i32;
export type s64 = i64;

export type f32 = number;
export type f64 = number;

export type usize = u32; // Wasm is a 32-bit VM

// for consistency
export type Uint64Array = BigUint64Array;
export type Int64Array = BigInt64Array;
export const Uint64Array = BigUint64Array;
export const Int64Array = BigInt64Array;

// is there a better way to do this?
export type TypedArray =
	  Uint8Array
	| Uint16Array
	| Uint32Array
	| Uint64Array
	| Int8Array
	| Int16Array
	| Int32Array
	| Int64Array
	| Float32Array
	| Float64Array;
	// Uint8ClampedArray etc later

// Problems:
// TS2376
// TS17009
// TS18019
// TS18022
// TS2775
// TS18019
