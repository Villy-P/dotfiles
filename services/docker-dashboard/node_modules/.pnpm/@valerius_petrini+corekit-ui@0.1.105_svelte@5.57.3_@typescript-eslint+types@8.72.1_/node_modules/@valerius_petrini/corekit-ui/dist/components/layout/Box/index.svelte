<script lang="ts">
    import { twMerge } from "tailwind-merge";
    import type { BoxProps } from "./types";
    import { multiAction } from "../../../utils/multiAction";
    
    let {
        center = false,
        fullscreen = false,
        class: className = "",
        children = undefined,
        element = $bindable(),
        use = [],
        tag = "div",
        ...restProps
    }: BoxProps = $props();

    let combinedClass = $derived(twMerge(
        center ? "flex-center" : "",
        fullscreen ? "w-full h-full" : "",
        className
    ));
</script>

<svelte:element this={tag} class={combinedClass} {...restProps} bind:this={element} use:multiAction={use}>
    {@render children?.()}
</svelte:element>