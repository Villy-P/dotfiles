<script lang="ts">
    import { twMerge } from "tailwind-merge";
    import type { FooterProps } from "./types";
    import { multiAction } from "../../../utils/multiAction";

    let { 
        class: className = "", 
        children,
        element = $bindable(),
        use = [],
        ...restProps
    }: FooterProps = $props();

    const combined = $derived(twMerge(
        "w-full h-16 flex items-center justify-center gap-4 px-10 flex-wrap text-sub-text bg-sub-background", 
        className
    ));
</script>

<footer class={combined} {...restProps} bind:this={element} use:multiAction={use}>
    {@render children?.()}
</footer>