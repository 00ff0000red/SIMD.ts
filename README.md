# SIMD.ts #

Loosely inspired by [SIMD.js](https://github.com/tc39/ecmascript_simd), SIMD.ts is an OOP-styled, type-safe interface for TypeScript (and JavaScript) to leverage WebAssembly SIMD instructions and vectorized arithmetic.

This library depends on bleeding edge and experimental JavaScript and WebAssembly features that cannot be polyfilled, ex: JavaScript WeakRefs, Wasm v128 SIMD operations.

Everything is written in a browser-compatible fashion, meaning that it can run in any environment that supports all static WebAssembly functions, fetch, WeakRefs, private class fields, and Wasm SIMD. It should run in the newest version of Deno, the latest Node.js, or any modern browser.

The module exports 10 classes:
* `Uint8x16`
* `Uint16x8`
* `Uint32x4`
* `Uint64x2`
* `Int8x16`
* `Int16x8`
* `Int32x4`
* `Int64x2`
* `Float32x4`
* `Float64x2`

(*clamped versions may be added later*)

Each of the classes is based on it's associated TypedArray.

Once constructed, each will only have the number after the "x" indexable elements.

Example:
```ts
const vector = new Float64x2;

vector[0]; // 0.0
vector[1]; // 0.0
vector[2]; // undefined
```

The constructors take no arguments, leaving four different ways to create a vector:
* `new TxN`
* `TxN.of(...)`
* `TxN.from(...)`
* `TxN.splat(T)`

`.of`, and `.from` are inherited from the builtin `%TypedArray%`, `TxN.splat` creates a vector full of a single value.

Example usage:
```ts
const fullVector = Uint32x4.splat(100);

fullVector[0]; // 100
fullVector[1]; // 100
fullVector[2]; // 100
fullVector[3]; // 100
```

Unless otherwise stated, every part of the module uses JS runtime builtins or WebAssembly function calls to work.

There are currently no scalar operations, but some polyfills may require them and will be documented as such.

Even if using scalar operations, they should execute faster than plain JavaScript, as they will only be on the WebAssembly side.

All vectors have methods shaped after the normal JavaScript operations.

They are stringified versions of the normal operations.

```ts
import * as SIMD from "SIMD";

const x = SIMD.Int32x4.of(1, 1, 1, 1);

const y = SIMD.Int32x4.of(2, 2, 2, 2);

console.log(
	"First vector: %O\nSecond vector: %o",
	x,
	y
);

console.log(
	"Vectors added together: %O\n",
	x["+"](y) // Int32x4 [ 3, 3, 3, 3 ]
);

x["+="](100);

console.log(
	"After incrementing: %O",
	x // Int32x4 [ 101, 101, 101, 101 ]
);
```
Most operations are overloaded to accept either, a second vector as their argument, or their argument is cast to a number.

Some unary methods are provided, such as `.abs`, `.~`, `.neg`.

```ts
const decimalVector = SIMD.Float32x4.of(1.1, 2.2, 3.3, 4.4);

console.log(decimalVector.floor()); // Float32x4 [ 1, 2, 3, 4 ]
```

To start, only built-in Wasm SIMD operations will be supported, but more operations will be added once the code is stable.
For example, a vectorized square operation could easily be added that would have the semantics of the following:
```ts
const vector = TxN.of(2, 3, 4, 5);
const squared = vector["*"](vector); // [ 4, 9, 16, 25 ]
```
but without the temporary variable, and the overhead of moving through JS-Wasm twice.
```ts
const squared = TxN.of(...).square(); // [ 4, 9, 16, 25 ]
```

## Errors: ##

Attempting to perform a vector operation on a non-vector will throw an exception.
```ts
Uint8x16.prototype["+"].call(new Uint8Array(...), ...); // WebAssembly.RuntimeError { message: "This is not a Uint8x16", ... }
```

Vectors may not be mixed:
```ts
const x = Int32x4.splat(5);
const y = Float32x4.splat(5);
x["+"](y); // probably Int32x4 [ 5, 5, 5, 5 ]
```
This is because, if the second argument is not of the same type, it is then coerced into a number.

In that particular case, the entire object was coerced into a number, (`NaN`), then cast to an int32 (`0`).

Calling `.of` or `.from` with too many values, or too long of an iterator, respectively, should throw an exception:
```ts
Int32x4.of(1, 2, 3, 4, 5); // error `5` would otherwise be lost
```
(*this may change later*)

Uint64x2 and Int64x2 have very few Wasm operations, so they will likely have to be filled in with scalar operations.

**Warning**:
This TS/JS wrapper will need to be rewritten if/when the [TC39 remove builtin subclassing proposal](https://github.com/tc39/proposal-rm-builtin-subclassing) becomes a part of the ES262 specification.

<!--
See the [docs](./docs/index.md) for more specific details on the specific operations currently implemented for each vector type.

TODO: API here, typedefs, methodology, usage, etc.
-->
