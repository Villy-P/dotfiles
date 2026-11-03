import type { NormalizedParserOptions } from "./parser-options.js";
/**
 * Translate a Svelte component to the virtual TypeScript shim. Returns
 * `null` if the configured script parser is not TypeScript or parsing fails.
 */
export declare function svelteToVirtualTypeScript(filePath: string, content: string, parserOptions: NormalizedParserOptions): string | null;
