import type { NormalizedParserOptions } from "./parser/parser-options.js";
interface TsLike {
    sys?: {
        readFile?: (path: string, encoding?: string) => string | undefined;
        fileExists?: (path: string) => boolean;
    };
    server?: {
        ProjectService?: {
            prototype: ProjectServiceLike;
        };
    };
}
interface ProjectServiceLike {
    openClientFile: (...args: unknown[]) => unknown;
    getScriptInfo: (fileName: string) => ScriptInfoLike | undefined;
}
interface ScriptInfoLike {
    isScriptOpen?: () => boolean;
    reloadFromFile?: () => boolean;
}
/** Called from `parseForESLint` so translation has the user's parser config. */
export declare function rememberParserOptions(options: NormalizedParserOptions): void;
/** Seed the cache so a later `ts.sys.readFile` skips re-translating. */
export declare function primeTranslationCache(filePath: string, virtualCode: string): void;
/**
 * The companion TypeScript has read for `sveltePath`, with its current virtual
 * code, or `null` when nothing needs a refresh.
 *
 * typescript-eslint only tells TypeScript about changes to the file being
 * linted. Linting `X.svelte` updates `X.svelte` in the program, but importers
 * resolve `./X.svelte` to the separate `X.svelte.ts` companion, which keeps
 * its old content. Parsing the companion path with this code makes
 * typescript-eslint update it the same way as a linted file.
 */
export declare function getCompanionToRefresh(sveltePath: string): {
    filePath: string;
    code: string;
} | null;
/**
 * Re-read the companion in every project service that holds it.
 *
 * typescript-eslint's project service does not watch the disk, and only the
 * linted file is opened with new content. The companion is never opened, so
 * it is reloaded through the hooked `ts.sys.readFile` instead. Opening it as
 * a client file would move it out of the configured project.
 */
export declare function reloadCompanionInProjectServices(companionPath: string): void;
/** Idempotent. No-op unless `SVELTE_ESLINT_PARSER_EXPERIMENTAL_TS_SYS_HOOK=1`. */
export declare function installTsSysHook(): void;
/** Test seam. The `ts.sys` patches themselves are intentionally permanent. */
export declare function _resetTranslationCacheForTesting(): void;
/** Test seam: patch a caller-supplied `sys` instead of the require.cache ones. */
export declare function _patchTsSysForTesting(sys: TsLike["sys"]): void;
export {};
