<script lang="ts">
    import type { ModalProps } from "./types";
    import { fade, fly } from "svelte/transition";
    import Card from "../../display/Card/index.svelte";
    import { twMerge } from "tailwind-merge";
    import { multiAction } from "../../../utils/multiAction";
    import { modalPositionParts } from "../../../styles/posititon";
    import { getSizeStyleClass } from "../../../styles/size";

    let { 
        children = undefined, 
        class: className = "",
        element = $bindable(),
        use = [],
        open = $bindable(), 
        position = "center",
        size = "md",
        ...restProps
    }: ModalProps = $props();

    const outerClass = $derived(twMerge(
        "inset-0 flex flex-col w-[calc(100%-1rem)] h-[calc(100%-1rem)] p-4",
        modalPositionParts[position as keyof typeof modalPositionParts],
    ));

    const cardClass = $derived(twMerge(
        "max-h-[95vh] overflow-y-auto",
        getSizeStyleClass(size, "card"),
        className
    ));
</script>

{#if open}
    <!-- svelte-ignore a11y_click_events_have_key_events -->
    <!-- svelte-ignore a11y_no_static_element_interactions -->
    <div
        class="w-full h-screen bg-black/50 z-300 fixed top-0 left-0"
        transition:fade={{ duration: 200 }}
        onclick={() => open = false}
        bind:this={element} use:multiAction={use}>
        <div
            class={outerClass}
            transition:fly={{ y: -20, duration: 200 }}>
            <Card class={cardClass} {...restProps} onclick={(e: MouseEvent) => e.stopPropagation()}>
                {@render children?.()}
            </Card>
        </div>
    </div>
{/if}