<script lang="ts">
    import { twMerge } from "tailwind-merge";
    import type { _Props } from "./types";
    import { multiAction } from "../../../utils/multiAction";
    
    let {
        class: className = "",
        children = undefined,
        element = $bindable(),
        use = [],
        style = "",
        ...restProps
    }: _Props = $props();

    const combinedClass = $derived(twMerge(
        // Default classes go here
        className
    ));

    const mergedStyle = $derived([
        // Default styles go here
        style,
    ].filter(Boolean).join("; "));
</script>

<div class={combinedClass} style={mergedStyle} bind:this={element} use:multiAction={use} {...restProps}>
    {@render children?.()}
</div>