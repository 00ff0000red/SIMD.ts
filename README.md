# SIMD.ts #

Loosly inspired by SIMD.js, SIMD.ts is an OOP-styled, type-safe interface for TypeScript (or JavaScript) to leverage WebAssembly SIMD instructions and vectorized arithmetic.

This library depends on bleeding edge and experimental JavaScript and WebAssembly features that cannot be polyfilled, ex: JavaScript WeakRefs, Wasm v128 SIMD operations.

Everything is written in a browser compatible fashion, meaning that it can run in any environment that supports all static WebAssembly functions, fetch, WeakRefs, private class fields, and Wasm SIMD. It should run in the newest version of Deno, the latest Node.js, or any modern browser.

Most of the .wat was compiled from C++, then hand-edited afterward for micro-optimizations.

**Warning**:
This TS/JS wrapper will need to be rewritten if the [TC39 remove builtin subclassing proposal](https://github.com/tc39/proposal-rm-builtin-subclassing) becomes a part of the ES262 specification.

TODO: API here, type defs, etc.
