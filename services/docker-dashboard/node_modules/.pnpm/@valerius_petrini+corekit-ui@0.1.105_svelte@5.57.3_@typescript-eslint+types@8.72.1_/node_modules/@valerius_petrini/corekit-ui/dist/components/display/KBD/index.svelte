<script lang="ts">
    import { twMerge } from "tailwind-merge";
    import { multiAction } from "../../../utils/multiAction";
    import type { KBDProps } from "./types";

    let { 
        children = undefined, 
        class: className = "",
        element = $bindable(),
        use = [],
        subtext = undefined,
        ...restProps
    }: KBDProps = $props();

    const defaultClass = "inline-flex flex-col items-center justify-center rounded bg-sub-background px-1.5 py-0.5 text-xs font-mono text-main-text border-sub-background-hover border-1";
    const subtextClass = "text-sub-text text-[10px] mt-0.5";

    const combinedClass = $derived(twMerge(defaultClass, className));
</script>

<kbd class={combinedClass} {...restProps} bind:this={element} use:multiAction={use}>
    {@render children?.()}
    {#if subtext}        
        <span class={subtextClass}>
            {@render subtext?.()}
        </span>
    {/if}
</kbd>