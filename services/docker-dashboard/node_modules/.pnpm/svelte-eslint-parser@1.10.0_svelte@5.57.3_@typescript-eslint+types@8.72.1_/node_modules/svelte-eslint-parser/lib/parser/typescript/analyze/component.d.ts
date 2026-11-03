import type { VirtualTypeScriptContext } from "../context.js";
import type { TSESParseForESLintResult } from "../types.js";
import type { SvelteParseContext } from "../../svelte-parse-context.js";
/**
 * Append a synthetic component `export default` so importers can resolve the
 * component's prop, event, and slot types.
 *
 * The export must carry both a value and a type meaning: `ComponentProps<typeof
 * Foo>` uses the value, while `ComponentEvents<Foo>` and Svelte-4-style
 * `ComponentProps<Foo>` use `Foo` as a type. A bare `export default <expr>` only
 * provides the value, so emit a value/type pair re-exported as default.
 */
export declare function appendComponentDefaultExport(result: TSESParseForESLintResult, source: string, ctx: VirtualTypeScriptContext, svelteParseContext: SvelteParseContext, instanceScriptRange: [number, number] | null): void;
