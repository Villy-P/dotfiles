<script lang="ts">
    import type { SkeletonGroupProps } from "./types";
    import { Skeleton } from "..";
    import { twMerge } from "tailwind-merge";
    import { multiAction } from "../../../utils/multiAction";

    let { 
        variant = "text", 
        count = 3, 
        element = $bindable(),
        use = [],
        class: className,
        ...restProps
    }: SkeletonGroupProps = $props();

    const combinedClass = $derived(twMerge(
        "flex flex-col gap-4 w-full",
        className
    ));
</script>

<div class={combinedClass} bind:this={element} aria-hidden="true" use:multiAction={use} {...restProps}>
    {#each Array(count) as _, i (i)}
        <Skeleton variant={variant}/>
    {/each}
</div>