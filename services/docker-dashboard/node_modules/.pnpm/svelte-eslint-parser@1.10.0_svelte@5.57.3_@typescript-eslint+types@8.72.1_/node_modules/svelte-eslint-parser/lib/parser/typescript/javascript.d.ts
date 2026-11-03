import type { ESLintExtendedProgram } from "../index.js";
import type { NormalizedParserOptions } from "../parser-options.js";
/**
 * TypeScript treats unknown extensions as TS, where JSDoc type annotations
 * are ignored. Use a JS source file for the virtual component instead.
 * Keep the original project intact: its source files and checker can be
 * shared by other lint calls, including calls using projectService.
 */
export declare function getJavaScriptParserOptions(result: ESLintExtendedProgram, attrs: Record<string, string | undefined>, parserOptions: NormalizedParserOptions): NormalizedParserOptions | null;
