"hide source";

import {
	api,
	free,
	memory,
	allocate,
	ops,
	garbageCollector,
	unreachable
} from "./v128.ts";

import { Uint64Array, Int64Array } from "./low-level-types.ts";

// forward declarations
const { TypeError, Set, Object } = self;

const Uint8x16 = class extends Uint8Array {
	#ptr;

	static splat = api["u8x16.splat"];
	static of = api["u8x16.of"];

	// #instanceof exists because one can apply an arbitrary proto to anything
	static #instanceof(lhs, rhs) {
		"sensitive";

		// if (!(#ptr in lhs)) { throw ... }
		try {
			lhs.#ptr;
		} catch {
			throw new TypeError("this is not a Uint8x16.");
		}

		// return #ptr in rhs;
		try {
			rhs.#ptr;
			return true;
		} catch {
			return false;
		}
	}

	"&"(rhs) {
		const ptr = Uint8x16.#instanceof(this, rhs)
			? ops["v128.and"](this.#ptr, rhs.#ptr)
			: unreachable();
			// ops["v128.single.and"](this.#ptr, +rhs);

		// single ops are missing, fill these in soon!

		return new Uint8x16(memory, ptr);
	}

	"&="(rhs) {
		Uint8x16.#instanceof(this, rhs)
			? ops["v128.and="](this.#ptr, rhs.#ptr)
			: unreachable();
			// ops["v128.single.and="](this.#ptr, +rhs);

		return this;
	}

	"|"(rhs) {
		const ptr = Uint8x16.#instanceof(this, rhs)
			? ops["v128.or"](this.#ptr, rhs.#ptr)
			: unreachable();
			// ops["v128.single.or"](this.#ptr, +rhs);

		return new Uint8x16(memory, ptr);
	}

	"|="(rhs) {
		const ptr = Uint8x16.#instanceof(this, rhs)
			? ops["v128.or="](this.#ptr, rhs.#ptr)
			: unreachable();
			// ops["v128.single.or="](this.#ptr, +rhs);

		return this;
	}

	"^"(rhs) {
		const ptr = Uint8x16.#instanceof(this, rhs)
			? ops["v128.xor"](this.#ptr, rhs.#ptr)
			: unreachable();
			// ops["v128.single.or"](this.#ptr, +rhs);

		return new Uint8x16(memory, ptr);
	}

	"^="(rhs) {
		Uint8x16.#instanceof(this, rhs)
			? ops["v128.xor="](this.#ptr, rhs.#ptr)
			: unreachable();
			// ops["v128.single.xor="](this.#ptr, +rhs);

		return this;
	}

	"~"() {
		Uint8x16.#instanceof(this, this);

		const ptr = ops["v128.unary.not"](this.#ptr);

		return new Uint8x16(memory, ptr);
	}

	"~="() {
		Uint8x16.#instanceof(this, this);

		ops["v128.unary.not="](this.#ptr);

		return this;
	}

	"+"(rhs) {
		const ptr = Uint8x16.#instanceof(this, rhs)
			? ops["i8x16.add"](this.#ptr, rhs.#ptr)
			: ops["i8x16.single.add"](this.#ptr, +rhs);

		return new Uint8x16(memory, ptr);
	}

	/*
	local.get this.#ptr
	local.get rhs
	Uint8x16.#instanceof
	if (param usize)
		local.get rhs.#ptr
		call ops["i8x16.add"]
	else
		local.get rhs
		call ops["i8x16.single.add"]
	end
	local.set ptr
	*/

	"+="(rhs) {
		Uint8x16.#instanceof(this, rhs)
			? ops["i8x16.add="](this.#ptr, rhs.#ptr)
			: ops["i8x16.single.add="](this.#ptr, +rhs);

		return this;
	}

	"-"(rhs) {
		const ptr = Uint8x16.#instanceof(this, rhs)
			? ops["i8x16.sub"](this.#ptr, rhs.#ptr)
			: ops["i8x16.single.sub"](this.#ptr, +rhs);

		return new Uint8x16(memory, ptr);
	}

	"-="(rhs) {
		Uint8x16.#instanceof(this, rhs)
			? ops["i8x16.sub="](this.#ptr, rhs.#ptr)
			: ops["i8x16.single.sub="](this.#ptr, +rhs);

		return this;
	}

	">>"(rhs) {
		// assert self; ignore result in shift ops
		Uint8x16.#instanceof(this, this);

		const ptr = ops["i8x16.shift.shr_u"](this.#ptr, +rhs);

		return new Uint8x16(memory, ptr);
	}

	">>="(rhs) {
		Uint8x16.#instanceof(this, this);

		ops["i8x16.shift.shr_u="](this.#ptr, +rhs);

		return this;
	}

	"neg"() {
		Uint8x16.#instanceof(this, this);

		const ptr = ops["v128.unary.neg"](this.#ptr);

		return new Uint8x16(memory, ptr);
	}

	"neg="() {
		Uint8x16.#instanceof(this, this);

		ops["v128.unary.neg="](this.#ptr);

		return this;
	}

	"abs"() {
		Uint8x16.#instanceof(this, this);

		const ptr = ops["v128.unary.abs"](this.#ptr);

		return new Uint8x16(memory, ptr);
	}

	"abs="() {
		Uint8x16.#instanceof(this, this);

		ops["v128.unary.abs="](this.#ptr);

		return this;
	}

	"<<"(rhs) {
		Uint8x16.#instanceof(this, this);

		const ptr = ops["i8x16.shift.shl"](this.#ptr, +rhs);

		return new Uint8x16(memory, ptr);
	}

	"<<="(rhs) {
		Uint8x16.#instanceof(this, this);

		ops["i8x16.shift.shl="](this.#ptr, +rhs);

		return this;
	}

/*
these are scary

"i8x16.eq" $op
"i8x16.single.eq" $op_i32
"i8x16.eq=" $op=
"i8x16.single.eq=" $op_i32=
"i8x16.ne" $op
"i8x16.single.ne" $op_i32
"i8x16.ne=" $op=
"i8x16.single.ne=" $op_i32=
"i8x16.lt_s" $op
"i8x16.single.lt_s" $op_i32
"i8x16.lt_s=" $op=
"i8x16.single.lt_s=" $op_i32=
"i8x16.lt_u" $op
"i8x16.single.lt_u" $op_i32
"i8x16.lt_u=" $op=
"i8x16.single.lt_u=" $op_i32=
"i8x16.le_s" $op
"i8x16.single.le_s" $op_i32
"i8x16.le_s=" $op=
"i8x16.single.le_s=" $op_i32=
"i8x16.le_u" $op
"i8x16.single.le_u" $op_i32
"i8x16.le_u=" $op=
"i8x16.single.le_u=" $op_i32=
"i8x16.gt_s" $op
"i8x16.single.gt_s" $op_i32
"i8x16.gt_s=" $op=
"i8x16.single.gt_s=" $op_i32=
"i8x16.gt_u" $op
"i8x16.single.gt_u" $op_i32
"i8x16.gt_u=" $op=
"i8x16.single.gt_u=" $op_i32=
"i8x16.ge_s" $op
"i8x16.single.ge_s" $op_i32
"i8x16.ge_s=" $op=
"i8x16.single.ge_s=" $op_i32=
"i8x16.ge_u" $op
"i8x16.single.ge_u" $op_i32
"i8x16.ge_u=" $op=
"i8x16.single.ge_u=" $op_i32=
*/

	"min"(rhs) {
		const ptr = Uint8x16.#instanceof(this, rhs)
			? ops["i8x16.min_u"](this.#ptr, rhs.#ptr)
			: ops["i8x16.single.min_u"](this.#ptr, +rhs);

		return new Uint8x16(memory, ptr);
	}

	"min="(rhs) {
		Uint8x16.#instanceof(this, rhs)
			? ops["i8x16.min_u="](this.#ptr, rhs.#ptr)
			: ops["i8x16.single.min_u="](this.#ptr, +rhs);

		return this;
	}

	"max"(rhs) {
		const ptr = Uint8x16.#instanceof(this, rhs)
			? ops["i8x16.max_u"](this.#ptr, rhs.#ptr)
			: ops["i8x16.single.max_u"](this.#ptr, +rhs);

		return new Uint8x16(memory, ptr);
	}

	"max="(rhs) {
		Uint8x16.#instanceof(this, rhs)
			? ops["i8x16.max_u="](this.#ptr, rhs.#ptr)
			: ops["i8x16.single.max_u="](this.#ptr, +rhs);

		return this;
	}

	constructor(
		buffer,
		byteOffset
	) {
		const ptr = buffer === memory
			? +byteOffset
			: allocate();

		garbageCollector.register(
			super(memory, ptr, 16),
			this.#ptr = ptr
		);
/*
	(func (@js constructor) (param $buffer eqref) (param $byteOffset i32) (result externref)
		(local $ptr i32)

		local.get $buffer
		local.get $memory
		eqref.eq
		if (result i32)
			local.get $byteOffset
		else
			call $allocate
		end
		local.set $ptr

		local.get $memory
		local.get $ptr
		i32.const 16
		call $super
	)
*/
	}
};

const Int8x16 = class extends Int8Array {
	#ptr;

	static splat = api["s8x16.splat"];
	static of = api["s8x16.of"];

	static #instanceof(lhs, rhs) {
		"sensitive";

		try {
			lhs.#ptr;
		} catch {
			throw new TypeError("this is not a Int8x16.");
		}

		try {
			rhs.#ptr;
			return true;
		} catch {
			return false;
		}
	}

	"+"(rhs) {
		const ptr = Int8x16.#instanceof(this, rhs)
			? ops["i8x16.add"](this.#ptr, rhs.#ptr)
			: ops["i8x16.single.add"](this.#ptr, +rhs);

		return new Int8x16(memory, ptr);
	}

	"+="(rhs) {
		Int8x16.#instanceof(this, rhs)
			? ops["i8x16.add="](this.#ptr, rhs.#ptr)
			: ops["i8x16.single.add="](this.#ptr, +rhs);

		return this;
	}

	constructor(
		buffer,
		byteOffset
	) {
		const ptr = buffer === memory
			? +byteOffset
			: allocate();

		garbageCollector.register(
			super(memory, ptr, 16),
			this.#ptr = ptr
		);
	}
};

const Uint16x8 = class extends Uint16Array {
	#ptr;

	static splat = api["u16x8.splat"];
	static of = api["u16x8.of"];

	static #instanceof(lhs, rhs) {
		"sensitive";

		try {
			lhs.#ptr;
		} catch {
			throw new TypeError("this is not a Uint16x8.");
		}

		try {
			rhs.#ptr;
			return true;
		} catch {
			return false;
		}
	}

	"+"(rhs) {
		const ptr = Uint16x8.#instanceof(this, rhs)
			? ops["i16x8.add"](this.#ptr, rhs.#ptr)
			: ops["i16x8.single.add"](this.#ptr, +rhs);

		return new Uint16x8(memory, ptr);
	}

	"+="(rhs) {
		Uint16x8.#instanceof(this, rhs)
			? ops["i16x8.add="](this.#ptr, rhs.#ptr)
			: ops["i16x8.single.add="](this.#ptr, +rhs);

		return this;
	}

	"-"(rhs) {
		const ptr = Uint16x8.#instanceof(this, rhs)
			? ops["i16x8.sub"](this.#ptr, rhs.#ptr)
			: ops["i16x8.single.sub"](this.#ptr, +rhs);

		return new Uint16x8(memory, ptr);
	}

	"-="(rhs) {
		Uint16x8.#instanceof(this, rhs)
			? ops["i16x8.sub="](this.#ptr, rhs.#ptr)
			: ops["i16x8.single.sub="](this.#ptr, +rhs);

		return this;
	}

	"*"(rhs) {
		const ptr = Uint16x8.#instanceof(this, rhs)
			? ops["i16x8.mul"](this.#ptr, rhs.#ptr)
			: ops["i16x8.single.mul"](this.#ptr, +rhs);

		return new Uint16x8(memory, ptr);
	}

	"*="(rhs) {
		Uint16x8.#instanceof(this, rhs)
			? ops["i16x8.mul="](this.#ptr, rhs.#ptr)
			: ops["i16x8.single.mul="](this.#ptr, +rhs);

		return this;
	}

	">>"(rhs) {
		Uint16x8.#instanceof(this, this);

		const ptr = ops["i16x8.shift.shr_u"](this.#ptr, +rhs);

		return new Uint16x8(memory, ptr);
	}

	">>="(rhs) {
		Uint16x8.#instanceof(this, this);

		ops["i16x8.shift.shr_u="](this.#ptr, +rhs);

		return this;
	}

	"neg"() {
		Uint16x8.#instanceof(this, this);

		const ptr = ops["i16x8.unary.neg"](this.#ptr);

		return new Uint16x8(memory, ptr);
	}

	"neg="() {
		Uint16x8.#instanceof(this, this);

		ops["i16x8.unary.neg="](this.#ptr);

		return this;
	}

	"abs"() {
		Uint16x8.#instanceof(this, this);

		const ptr = ops["i16x8.unary.abs"](this.#ptr);

		return new Uint16x8(memory, ptr);
	}

	"abs="() {
		Uint16x8.#instanceof(this, this);

		ops["i16x8.unary.abs="](this.#ptr);

		return this;
	}

	"<<"(rhs) {
		Uint16x8.#instanceof(this, this);

		const ptr = ops["i16x8.shift.shl"](this.#ptr, +rhs);

		return new Uint16x8(memory, ptr);
	}

	"<<="(rhs) {
		Uint16x8.#instanceof(this, this);

		ops["i16x8.shift.shl="](this.#ptr, +rhs);

		return this;
	}
/*
"i16x8.eq" $op
"i16x8.single.eq" $op_i32
"i16x8.eq=" $op=
"i16x8.single.eq=" $op_i32=
"i16x8.ne" $op
"i16x8.single.ne" $op_i32
"i16x8.ne=" $op=
"i16x8.single.ne=" $op_i32=
"i16x8.lt_s" $op
"i16x8.single.lt_s" $op_i32
"i16x8.lt_s=" $op=
"i16x8.single.lt_s=" $op_i32=
"i16x8.lt_u" $op
"i16x8.single.lt_u" $op_i32
"i16x8.lt_u=" $op=
"i16x8.single.lt_u=" $op_i32=
"i16x8.le_s" $op
"i16x8.single.le_s" $op_i32
"i16x8.le_s=" $op=
"i16x8.single.le_s=" $op_i32=
"i16x8.le_u" $op
"i16x8.single.le_u" $op_i32
"i16x8.le_u=" $op=
"i16x8.single.le_u=" $op_i32=
"i16x8.gt_s" $op
"i16x8.single.gt_s" $op_i32
"i16x8.gt_s=" $op=
"i16x8.single.gt_s=" $op_i32=
"i16x8.gt_u" $op
"i16x8.single.gt_u" $op_i32
"i16x8.gt_u=" $op=
"i16x8.single.gt_u=" $op_i32=
"i16x8.ge_s" $op
"i16x8.single.ge_s" $op_i32
"i16x8.ge_s=" $op=
"i16x8.single.ge_s=" $op_i32=
"i16x8.ge_u" $op
"i16x8.single.ge_u" $op_i32
"i16x8.ge_u=" $op=
"i16x8.single.ge_u=" $op_i32=
*/

	"min"(rhs) {
		const ptr = Uint16x8.#instanceof(this, rhs)
			? ops["i16x8.min_u"](this.#ptr, rhs.#ptr)
			: ops["i16x8.single.min_u"](this.#ptr, +rhs);

		return new Uint16x8(memory, ptr);
	}

	"min="(rhs) {
		Uint16x8.#instanceof(this, rhs)
			? ops["i16x8.min_u="](this.#ptr, rhs.#ptr)
			: ops["i16x8.single.min_u="](this.#ptr, +rhs);

		return this;
	}

	"max"(rhs) {
		const ptr = Uint16x8.#instanceof(this, rhs)
			? ops["i16x8.max_u"](this.#ptr, rhs.#ptr)
			: ops["i16x8.single.max_u"](this.#ptr, +rhs);

		return new Uint16x8(memory, ptr);
	}

	"max="(rhs) {
		Uint16x8.#instanceof(this, rhs)
			? ops["i16x8.max_u="](this.#ptr, rhs.#ptr)
			: ops["i16x8.single.max_u="](this.#ptr, +rhs);

		return this;
	}

	constructor(
		buffer,
		byteOffset
	) {
		const ptr = buffer === memory
			? +byteOffset
			: allocate();

		garbageCollector.register(
			super(memory, ptr, 8),
			this.#ptr = ptr
		);
	}
};

const Int16x8 = class extends Int16Array {
	#ptr;

	static splat = api["s16x8.splat"];
	static of = api["s16x8.of"];

	static #instanceof(lhs, rhs) {
		"sensitive";

		try {
			lhs.#ptr;
		} catch {
			throw new TypeError("this is not a Int16x8.");
		}

		try {
			rhs.#ptr;
			return true;
		} catch {
			return false;
		}
	}

	constructor(
		buffer,
		byteOffset
	) {
		const ptr = buffer === memory
			? +byteOffset
			: allocate();

		garbageCollector.register(
			super(memory, ptr, 8),
			this.#ptr = ptr
		);
	}
};

const Uint32x4 = class extends Uint32Array {
	#ptr;

	static splat = api["u32x4.splat"];
	static of = api["u32x4.of"];

	static #instanceof(lhs, rhs) {
		"sensitive";

		try {
			lhs.#ptr;
		} catch {
			throw new TypeError("this is not a Uint32x4.");
		}

		try {
			rhs.#ptr;
			return true;
		} catch {
			return false;
		}
	}

	"+"(rhs) {
		const ptr = Uint32x4.#instanceof(this, rhs)
			? ops["i32x4.add"](this.#ptr, rhs.#ptr)
			: ops["i32x4.single.add"](this.#ptr, +rhs);

		return new Uint32x4(memory, ptr);
	}

	"+="(rhs) {
		Uint32x4.#instanceof(this, rhs)
			? ops["i32x4.add="](this.#ptr, rhs.#ptr)
			: ops["i32x4.single.add="](this.#ptr, +rhs);

		return this;
	}

/*
"i32x4.sub" $op
"i32x4.single.sub" $op_i32
"i32x4.sub=" $op=
"i32x4.single.sub=" $op_i32=
"i32x4.mul" $op
"i32x4.single.mul" $op_i32
"i32x4.mul=" $op=
"i32x4.single.mul=" $op_i32=
"i32x4.shift.shr_s" $shift
"i32x4.shift.shr_s=" $shift=
"i32x4.shift.shr_u" $shift
"i32x4.shift.shr_u=" $shift=
"i32x4.unary.neg" $unary
"i32x4.unary.neg=" $unary=
"i32x4.unary.abs" $unary
"i32x4.unary.abs=" $unary=
"i32x4.shift.shl" $shift
"i32x4.shift.shl=" $shift=
"i32x4.eq" $op
"i32x4.single.eq" $op_i32
"i32x4.eq=" $op=
"i32x4.single.eq=" $op_i32=
"i32x4.ne" $op
"i32x4.single.ne" $op_i32
"i32x4.ne=" $op=
"i32x4.single.ne=" $op_i32=
"i32x4.lt_s" $op
"i32x4.single.lt_s" $op_i32
"i32x4.lt_s=" $op=
"i32x4.single.lt_s=" $op_i32=
"i32x4.lt_u" $op
"i32x4.single.lt_u" $op_i32
"i32x4.lt_u=" $op=
"i32x4.single.lt_u=" $op_i32=
"i32x4.le_s" $op
"i32x4.single.le_s" $op_i32
"i32x4.le_s=" $op=
"i32x4.single.le_s=" $op_i32=
"i32x4.le_u" $op
"i32x4.single.le_u" $op_i32
"i32x4.le_u=" $op=
"i32x4.single.le_u=" $op_i32=
"i32x4.gt_s" $op
"i32x4.single.gt_s" $op_i32
"i32x4.gt_s=" $op=
"i32x4.single.gt_s=" $op_i32=
"i32x4.gt_u" $op
"i32x4.single.gt_u" $op_i32
"i32x4.gt_u=" $op=
"i32x4.single.gt_u=" $op_i32=
"i32x4.ge_s" $op
"i32x4.single.ge_s" $op_i32
"i32x4.ge_s=" $op=
"i32x4.single.ge_s=" $op_i32=
"i32x4.ge_u" $op
"i32x4.single.ge_u" $op_i32
"i32x4.ge_u=" $op=
"i32x4.single.ge_u=" $op_i32=
"i32x4.min_s" $op
"i32x4.single.min_s" $op_i32
"i32x4.min_s=" $op=
"i32x4.single.min_s=" $op_i32=
"i32x4.min_u" $op
"i32x4.single.min_u" $op_i32
"i32x4.min_u=" $op=
"i32x4.single.min_u=" $op_i32=
"i32x4.max_s" $op
"i32x4.single.max_s" $op_i32
"i32x4.max_s=" $op=
"i32x4.single.max_s=" $op_i32=
"i32x4.max_u" $op
"i32x4.single.max_u" $op_i32
"i32x4.max_u=" $op=
"i32x4.single.max_u=" $op_i32=
*/

	constructor(
		buffer,
		byteOffset
	) {
		const ptr = buffer === memory
			? +byteOffset
			: allocate();

		garbageCollector.register(
			super(memory, ptr, 4),
			this.#ptr = ptr
		);
	}
};

const Int32x4 = class extends Int32Array {
	#ptr;

	static splat = api["s32x4.splat"];
	static of = api["s32x4.of"];

	static #instanceof(lhs, rhs) {
		"sensitive";

		try {
			lhs.#ptr;
		} catch {
			throw new TypeError("this is not a Int32x4.");
		}

		try {
			rhs.#ptr;
			return true;
		} catch {
			return false;
		}
	}

	"+"(rhs) {
		const ptr = Int32x4.#instanceof(this, rhs)
			? ops["i32x4.add"](this.#ptr, rhs.#ptr)
			: ops["i32x4.single.add"](this.#ptr, +rhs);

		return new Int32x4(memory, ptr);
	}

	"+="(rhs) {
		Int32x4.#instanceof(this, rhs)
			? ops["i32x4.add="](this.#ptr, rhs.#ptr)
			: ops["i32x4.single.add="](this.#ptr, +rhs);

		return this;
	}

	constructor(
		buffer,
		byteOffset
	) {
		const ptr = buffer === memory
			? +byteOffset
			: allocate();

		garbageCollector.register(
			super(memory, ptr, 4),
			this.#ptr = ptr
		);
	}
};

const Uint64x2 = class extends Uint64Array {
	#ptr;

	static splat = api["u64x2.splat"];
	static of = api["u64x2.of"];

	static #instanceof(lhs, rhs) {
		"sensitive";

		try {
			lhs.#ptr;
		} catch {
			throw new TypeError("this is not a Uint64x2.");
		}

		try {
			rhs.#ptr;
			return true;
		} catch {
			return false;
		}
	}

	"+"(rhs) {
		const ptr = Uint64x2.#instanceof(this, rhs)
			? ops["i64x2.add"](this.#ptr, rhs.#ptr)
			: ops["i64x2.single.add"](this.#ptr, +rhs);

		return new Uint64x2(memory, ptr);
	}

	"+="(rhs) {
		Uint64x2.#instanceof(this, rhs)
			? ops["i64x2.add="](this.#ptr, rhs.#ptr)
			: ops["i64x2.single.add="](this.#ptr, +rhs);

		return this;
	}
/*
"i64x2.sub" $op
"i64x2.single.sub" $op_i64
"i64x2.sub=" $op=
"i64x2.single.sub=" $op_i64=
"i64x2.mul" $op
"i64x2.single.mul" $op_i64
"i64x2.mul=" $op=
"i64x2.single.mul=" $op_i64=
"i64x2.shift.shr_s" $shift
"i64x2.shift.shr_s=" $shift=
"i64x2.shift.shr_u" $shift
"i64x2.shift.shr_u=" $shift=
"i64x2.unary.neg" $unary
"i64x2.unary.neg=" $unary=
"i64x2.shift.shl" $shift
"i64x2.shift.shl=" $shift=
*/

	constructor(
		buffer,
		byteOffset
	) {
		const ptr = buffer === memory
			? +byteOffset
			: allocate();

		garbageCollector.register(
			super(memory, ptr, 2),
			this.#ptr = ptr
		);
	}
};

const Int64x2 = class extends Int64Array {
	#ptr;

	static splat = api["s64x2.splat"];
	static of = api["s64x2.of"];

	static #instanceof(lhs, rhs) {
		"sensitive";

		try {
			lhs.#ptr;
		} catch {
			throw new TypeError("this is not a Int64x2.");
		}

		try {
			rhs.#ptr;
			return true;
		} catch {
			return false;
		}
	}

	constructor(
		buffer,
		byteOffset
	) {
		const ptr = buffer === memory
			? +byteOffset
			: allocate();

		garbageCollector.register(
			super(memory, ptr, 2),
			this.#ptr = ptr
		);
	}
};

const Float32x4 = class extends Float32Array {
	#ptr;

	static splat = api["f32x4.splat"];
	static of = api["f32x4.of"];

	static #instanceof(lhs, rhs) {
		"sensitive";

		try {
			lhs.#ptr;
		} catch {
			throw new TypeError("this is not a Float32x4.");
		}

		try {
			rhs.#ptr;
			return true;
		} catch {
			return false;
		}
	}

	"+"(rhs) {
		const ptr = Float32x4.#instanceof(this, rhs)
			? ops["f32x4.add"](this.#ptr, rhs.#ptr)
			: ops["f32x4.single.add"](this.#ptr, +rhs);

		return new Float32x4(memory, ptr);
	}

	"+="(rhs) {
		Float32x4.#instanceof(this, rhs)
			? ops["f32x4.add="](this.#ptr, rhs.#ptr)
			: ops["f32x4.single.add="](this.#ptr, +rhs);

		return this;
	}

	"-"(rhs) {
		const ptr = Float32x4.#instanceof(this, rhs)
			? ops["f32x4.sub"](this.#ptr, rhs.#ptr)
			: ops["f32x4.single.sub"](this.#ptr, +rhs);

		return new Float32x4(memory, ptr);
	}

	"-="(rhs) {
		Float32x4.#instanceof(this, rhs)
			? ops["f32x4.sub="](this.#ptr, rhs.#ptr)
			: ops["f32x4.single.sub="](this.#ptr, +rhs);

		return this;
	}

	"*"(rhs) {
		const ptr = Float32x4.#instanceof(this, rhs)
			? ops["f32x4.mul"](this.#ptr, rhs.#ptr)
			: ops["f32x4.single.mul"](this.#ptr, +rhs);

		return new Float32x4(memory, ptr);
	}

	"*="(rhs) {
		Float32x4.#instanceof(this, rhs)
			? ops["f32x4.mul="](this.#ptr, rhs.#ptr)
			: ops["f32x4.single.mul="](this.#ptr, +rhs);

		return this;
	}

	"/"(rhs) {
		const ptr = Float32x4.#instanceof(this, rhs)
			? ops["f32x4.div"](this.#ptr, rhs.#ptr)
			: ops["f32x4.single.div"](this.#ptr, +rhs);

		return new Float32x4(memory, ptr);
	}

	"/="(rhs) {
		Float32x4.#instanceof(this, rhs)
			? ops["f32x4.div="](this.#ptr, rhs.#ptr)
			: ops["f32x4.single.div="](this.#ptr, +rhs);

		return this;
	}

	"min"(rhs) {
		const ptr = Float32x4.#instanceof(this, rhs)
			? ops["f32x4.min"](this.#ptr, rhs.#ptr)
			: ops["f32x4.single.min"](this.#ptr, +rhs);

		return new Float32x4(memory, ptr);
	}

	"min="(rhs) {
		Float32x4.#instanceof(this, rhs)
			? ops["f32x4.min="](this.#ptr, rhs.#ptr)
			: ops["f32x4.single.min="](this.#ptr, +rhs);

		return this;
	}

	"max"(rhs) {
		const ptr = Float32x4.#instanceof(this, rhs)
			? ops["f32x4.max"](this.#ptr, rhs.#ptr)
			: ops["f32x4.single.max"](this.#ptr, +rhs);

		return new Float32x4(memory, ptr);
	}

	"max="(rhs) {
		Float32x4.#instanceof(this, rhs)
			? ops["f32x4.max="](this.#ptr, rhs.#ptr)
			: ops["f32x4.single.max="](this.#ptr, +rhs);

		return this;
	}

	"max"(rhs) {
		const ptr = Float32x4.#instanceof(this, rhs)
			? ops["f32x4.max"](this.#ptr, rhs.#ptr)
			: ops["f32x4.single.max"](this.#ptr, +rhs);

		return new Float32x4(memory, ptr);
	}

	"max="(rhs) {
		Float32x4.#instanceof(this, rhs)
			? ops["f32x4.max="](this.#ptr, rhs.#ptr)
			: ops["f32x4.single.max="](this.#ptr, +rhs);

		return this;
	}

	"neg"() {
		Float32x4.#instanceof(this, this);

		const ptr = ops["f32x4.unary.neg"](this.#ptr);

		return new Float32x4(memory, ptr);
	}

	"neg="() {
		Float32x4.#instanceof(this, this);

		ops["f32x4.unary.neg="](this.#ptr, rhs.#ptr);

		return this;
	}

	"abs"(rhs) {
		Float32x4.#instanceof(this, this);

		const ptr = ops["f32x4.unary.abs"](this.#ptr);

		return new Float32x4(memory, ptr);
	}

	"abs="(rhs) {
		Float32x4.#instanceof(this, this);

		ops["f32x4.unary.abs="](this.#ptr);

		return this;
	}
/*
"f32x4.eq" $op
"f32x4.single.eq" $op_f32
"f32x4.eq=" $op=
"f32x4.single.eq=" $op_f32=
"f32x4.ne" $op
"f32x4.single.ne" $op_f32
"f32x4.ne=" $op=
"f32x4.single.ne=" $op_f32=
"f32x4.lt" $op
"f32x4.single.lt" $op_f32
"f32x4.lt=" $op=
"f32x4.single.lt=" $op_f32=
"f32x4.le" $op
"f32x4.single.le" $op_f32
"f32x4.le=" $op=
"f32x4.single.le=" $op_f32=
"f32x4.gt" $op
"f32x4.single.gt" $op_f32
"f32x4.gt=" $op=
"f32x4.single.gt=" $op_f32=
"f32x4.ge" $op
"f32x4.single.ge" $op_f32
"f32x4.ge=" $op=
"f32x4.single.ge=" $op_f32=
*/

	"pmin"(rhs) {
		const ptr = Float32x4.#instanceof(this, rhs)
			? ops["f32x4.pmin"](this.#ptr, rhs.#ptr)
			: ops["f32x4.single.pmin"](this.#ptr, +rhs);

		return new Float32x4(memory, ptr);
	}

	"pmin="(rhs) {
		Float32x4.#instanceof(this, rhs)
			? ops["f32x4.pmin="](this.#ptr, rhs.#ptr)
			: ops["f32x4.single.pmin="](this.#ptr, +rhs);

		return this;
	}

	"pmax"(rhs) {
		const ptr = Float32x4.#instanceof(this, rhs)
			? ops["f32x4.pmax"](this.#ptr, rhs.#ptr)
			: ops["f32x4.single.pmax"](this.#ptr, +rhs);

		return new Float32x4(memory, ptr);
	}

	"pmax="(rhs) {
		Float32x4.#instanceof(this, rhs)
			? ops["f32x4.pmax="](this.#ptr, rhs.#ptr)
			: ops["f32x4.single.pmax="](this.#ptr, +rhs);

		return this;
	}

	"sqrt"(rhs) {
		Float32x4.#instanceof(this, this);

		const ptr = ops["f32x4.unary.sqrt"](this.#ptr);

		return new Float32x4(memory, ptr);
	}

	"sqrt="(rhs) {
		Float32x4.#instanceof(this, this);

		ops["f32x4.unary.sqrt="](this.#ptr);

		return this;
	}

	"ceil"(rhs) {
		Float32x4.#instanceof(this, this);

		const ptr = ops["f32x4.unary.ceil"](this.#ptr);

		return new Float32x4(memory, ptr);
	}

	"ceil="(rhs) {
		Float32x4.#instanceof(this, this);

		ops["f32x4.unary.ceil="](this.#ptr);

		return this;
	}

	"floor"(rhs) {
		Float32x4.#instanceof(this, this);

		const ptr = ops["f32x4.unary.floor"](this.#ptr);

		return new Float32x4(memory, ptr);
	}

	"floor="(rhs) {
		Float32x4.#instanceof(this, this);

		ops["f32x4.unary.floor="](this.#ptr);

		return this;
	}

	"trunc"(rhs) {
		Float32x4.#instanceof(this, this);

		const ptr = ops["f32x4.unary.trunc"](this.#ptr);

		return new Float32x4(memory, ptr);
	}

	"trunc="(rhs) {
		Float32x4.#instanceof(this, this);

		ops["f32x4.unary.trunc="](this.#ptr);

		return this;
	}

	"nearest"(rhs) {
		Float32x4.#instanceof(this, this);

		const ptr = ops["f32x4.unary.nearest"](this.#ptr);

		return new Float32x4(memory, ptr);
	}

	"nearest="(rhs) {
		Float32x4.#instanceof(this, this);

		ops["f32x4.unary.nearest="](this.#ptr);

		return this;
	}

	constructor(
		buffer,
		byteOffset
	) {
		const ptr = buffer === memory
			? +byteOffset
			: allocate();

		garbageCollector.register(
			super(memory, ptr, 4),
			this.#ptr = ptr
		);
	}
};

const Float64x2 = class extends Float64Array {
	#ptr;

	static splat = api["f64x2.splat"];
	static of = api["f64x2.of"];

	static #instanceof(lhs, rhs) {
		"sensitive";

		try {
			lhs.#ptr;
		} catch {
			throw new TypeError("this is not a Float64x2.");
		}

		try {
			rhs.#ptr;
		} catch {
			return false;
		}
	}

	"+"(rhs) {
		const ptr = Float64x2.#instanceof(this, rhs)
			? ops["f64x2.add"](this.#ptr, rhs.#ptr)
			: ops["f64x2.single.add"](this.#ptr, +rhs);

		return new Float64x2(memory, ptr);
	}

	"+="(rhs) {
		Float64x2.#instanceof(this, rhs)
			? ops["f64x2.add="](this.#ptr, rhs.#ptr)
			: ops["f64x2.single.add="](this.#ptr, +rhs);

		return this;
	}

	"-"(rhs) {
		const ptr = Float64x2.#instanceof(this, rhs)
			? ops["f64x2.sub"](this.#ptr, rhs.#ptr)
			: ops["f64x2.single.sub"](this.#ptr, +rhs);

		return new Float64x2(memory, ptr);
	}

	"-="(rhs) {
		Float64x2.#instanceof(this, rhs)
			? ops["f64x2.sub="](this.#ptr, rhs.#ptr)
			: ops["f64x2.single.sub="](this.#ptr, +rhs);

		return this;
	}

	"*"(rhs) {
		const ptr = Float64x2.#instanceof(this, rhs)
			? ops["f64x2.mul"](this.#ptr, rhs.#ptr)
			: ops["f64x2.single.mul"](this.#ptr, +rhs);

		return new Float64x2(memory, ptr);
	}

	"*="(rhs) {
		Float64x2.#instanceof(this, rhs)
			? ops["f64x2.mul="](this.#ptr, rhs.#ptr)
			: ops["f64x2.single.mul="](this.#ptr, +rhs);

		return this;
	}

	"/"(rhs) {
		const ptr = Float64x2.#instanceof(this, rhs)
			? ops["f64x2.div"](this.#ptr, rhs.#ptr)
			: ops["f64x2.single.div"](this.#ptr, +rhs);

		return new Float64x2(memory, ptr);
	}

	"/="(rhs) {
		Float64x2.#instanceof(this, rhs)
			? ops["f64x2.mul="](this.#ptr, rhs.#ptr)
			: ops["f64x2.single.mul="](this.#ptr, +rhs);

		return this;
	}

	"min"(rhs) {
		const ptr = Float64x2.#instanceof(this, rhs)
			? ops["f64x2.min"](this.#ptr, rhs.#ptr)
			: ops["f64x2.single.min"](this.#ptr, +rhs);

		return new Float64x2(memory, ptr);
	}

	"min="(rhs) {
		Float64x2.#instanceof(this, rhs)
			? ops["f64x2.min="](this.#ptr, rhs.#ptr)
			: ops["f64x2.single.min="](this.#ptr, +rhs);

		return this;
	}

	"max"(rhs) {
		const ptr = Float64x2.#instanceof(this, rhs)
			? ops["f64x2.min"](this.#ptr, rhs.#ptr)
			: ops["f64x2.single.min"](this.#ptr, +rhs);

		return new Float64x2(memory, ptr);
	}

	"max="(rhs) {
		Float64x2.#instanceof(this, rhs)
			? ops["f64x2.min="](this.#ptr, rhs.#ptr)
			: ops["f64x2.single.min="](this.#ptr, +rhs);

		return this;
	}

	"neg"() {
		Float64x2.#instanceof(this, this);

		const ptr = ops["f64x2.unary.neg"](this.#ptr);

		return new Float64x2(memory, ptr);
	}

	"neg="() {
		Float64x2.#instanceof(this, this);

		ops["f64x2.unary.neg="](this.#ptr);

		return this;
	}

	"abs"() {
		Float64x2.#instanceof(this, this);

		const ptr = ops["f64x2.unary.abs"](this.#ptr);

		return new Float64x2(memory, ptr);
	}

	"abs="() {
		Float64x2.#instanceof(this, this);

		ops["f64x2.unary.abs="](this.#ptr);

		return this;
	}

/*
"f64x2.eq" $op
"f64x2.single.eq" $op_f64
"f64x2.eq=" $op=
"f64x2.single.eq=" $op_f64=
"f64x2.ne" $op
"f64x2.single.ne" $op_f64
"f64x2.ne=" $op=
"f64x2.single.ne=" $op_f64=
"f64x2.lt" $op
"f64x2.single.lt" $op_f64
"f64x2.lt=" $op=
"f64x2.single.lt=" $op_f64=
"f64x2.le" $op
"f64x2.single.le" $op_f64
"f64x2.le=" $op=
"f64x2.single.le=" $op_f64=
"f64x2.gt" $op
"f64x2.single.gt" $op_f64
"f64x2.gt=" $op=
"f64x2.single.gt=" $op_f64=
"f64x2.ge" $op
"f64x2.single.ge" $op_f64
"f64x2.ge=" $op=
"f64x2.single.ge=" $op_f64=
*/

	"pmin"(rhs) {
		const ptr = Float64x2.#instanceof(this, rhs)
			? ops["f64x2.pmin"](this.#ptr, rhs.#ptr)
			: ops["f64x2.single.pmin"](this.#ptr, +rhs);

		return new Float64x2(memory, ptr);
	}

	"pmin="(rhs) {
		Float64x2.#instanceof(this, rhs)
			? ops["f64x2.pmin="](this.#ptr, rhs.#ptr)
			: ops["f64x2.single.pmin="](this.#ptr, +rhs);

		return this;
	}

	"pmax"(rhs) {
		const ptr = Float64x2.#instanceof(this, rhs)
			? ops["f64x2.pmax"](this.#ptr, rhs.#ptr)
			: ops["f64x2.single.pmax"](this.#ptr, +rhs);

		return new Float64x2(memory, ptr);
	}

	"pmax="(rhs) {
		Float64x2.#instanceof(this, rhs)
			? ops["f64x2.pmax="](this.#ptr, rhs.#ptr)
			: ops["f64x2.single.pmax="](this.#ptr, +rhs);

		return this;
	}

	"sqrt"() {
		Float64x2.#instanceof(this, this);

		const ptr = ops["f64x2.unary.sqrt"](this.#ptr);

		return new Float64x2(memory, ptr);
	}

	"sqrt="() {
		Float64x2.#instanceof(this, this);

		ops["f64x2.unary.sqrt="](this.#ptr);

		return this;
	}

	"ceil"() {
		Float64x2.#instanceof(this, this);

		const ptr = ops["f64x2.unary.ceil"](this.#ptr);

		return new Float64x2(memory, ptr);
	}

	"ceil="() {
		Float64x2.#instanceof(this, this);

		ops["f64x2.unary.ceil="](this.#ptr);

		return this;
	}

	"floor"() {
		Float64x2.#instanceof(this, this);

		const ptr = ops["f64x2.unary.floor"](this.#ptr);

		return new Float64x2(memory, ptr);
	}

	"floor="() {
		Float64x2.#instanceof(this, this);

		ops["f64x2.unary.floor="](this.#ptr);

		return this;
	}

	"trunc"() {
		Float64x2.#instanceof(this, this);

		const ptr = ops["f64x2.unary.trunc"](this.#ptr);

		return new Float64x2(memory, ptr);
	}

	"trunc="() {
		Float64x2.#instanceof(this, this);

		ops["f64x2.unary.trunc="](this.#ptr);

		return this;
	}

	"nearest"() {
		Float64x2.#instanceof(this, this);

		const ptr = ops["f64x2.unary.nearest"](this.#ptr);

		return new Float64x2(memory, ptr);
	}

	"nearest="() {
		Float64x2.#instanceof(this, this);

		ops["f64x2.unary.nearest="](this.#ptr);

		return this;
	}

	constructor(
		buffer,
		byteOffset
	) {
		const ptr = buffer === memory
			? +byteOffset
			: allocate();

		garbageCollector.register(
			super(memory, ptr, 2),
			this.#ptr = ptr
		);
	}
};

// initialization block
{
	const vector_classes = new Set([
		Uint8x16,
		Int8x16,
		Uint16x8,
		Int16x8,
		Uint32x4,
		Int32x4,
		Uint64x2,
		Int64x2,
		Float32x4,
		Float64x2
	]);

	{
		// sets v128#buffer and v128#byteLength to be accessed through Wasm instead.
		const properties = (() => {
			const accessor = {
				get: unreachable,
				configurable: true // to mimic putting it in the class itself
			};

			return {
				buffer: accessor,
				byteOffset: accessor
			};
		})();

		{
			const {
				freeze,
				defineProperties
			} = Object;

			for ( const vector_class of vector_classes ) {
				const { prototype } = freeze(vector_class);

				defineProperties(
					prototype,
					properties
				);

				freeze(prototype);
			}
		}
	}

	// loads JS references into WebAssembly
	api.register_js_classes(
		...vector_classes
	);
}

export {
	Uint8x16,
	Int8x16,
	Uint16x8,
	Int16x8,
	Uint32x4,
	Int32x4,
	Uint64x2,
	Int64x2,
	Float32x4,
	Float64x2
};
