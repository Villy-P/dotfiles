<script lang="ts">
    import type { SkeletonProps } from "./types";
    import Image from "@lucide/svelte/icons/image";
    import Play from "@lucide/svelte/icons/play";
    import { twMerge } from "tailwind-merge";
    import { multiAction } from "../../../utils/multiAction";
    import { getSizeStyleClass } from "../../../styles/size";

    let { 
        variant = "text", 
        class: className = "",
        element = $bindable(),
        use = [],
        count = 19, 
        size = "md" 
    }: SkeletonProps = $props();

    const defaultWidths = [21, 19, 24, 15, 10, 30, 22, 17, 26, 20, 28, 10, 22, 45, 16, 23, 37, 25, 25];
    const widths = $derived(Array.from({ length: count }, (_, i) => defaultWidths[i % defaultWidths.length]));

    const combinedContainerClass = $derived(twMerge(
        "animate-pulse duration-100 w-lg flex flex-col gap-2",
        getSizeStyleClass(size, "card"),
        className
    ));
</script>

{#snippet image()}
    <div class="h-48 bg-sub-background rounded w-full flex-center">
        <Image size={48} class="text-form-border"/>
    </div>
{/snippet}

{#snippet text()}
    <div class="pt-4 flex flex-wrap gap-2">            
        {#each widths as width}
            <div class="h-4 rounded even:bg-sub-background odd:bg-sub-background-hover" 
                    style="width: {width}%;"></div>
        {/each}
    </div>
{/snippet}

<div class={combinedContainerClass} bind:this={element} aria-hidden="true" use:multiAction={use}>
    {#if variant === "default"}
        <div class="h-4 bg-sub-background rounded w-3/4"></div>
        <div class="h-4 bg-sub-background rounded w-full"></div>
        <div class="h-4 bg-sub-background rounded w-5/6"></div>
        <div class="h-4 bg-sub-background rounded w-2/3"></div>
        <div class="h-4 bg-sub-background rounded w-5/6"></div>
        <div class="h-4 bg-sub-background rounded w-11/12"></div>
    {:else if variant === "text"}
        {@render text()}
    {:else if variant === "image"}
        {@render image()}
    {:else if variant === "video"}
        <div class="h-48 bg-sub-background rounded w-full flex-center">
            <Play size={48} class="text-form-border"/>
        </div>
    {:else if variant === "card"}
        <div class="w-full h-full border-sub-background border-2 rounded p-4 gap-2">
            {@render image()}
            {@render text()}
        </div>
    {/if}
</div>