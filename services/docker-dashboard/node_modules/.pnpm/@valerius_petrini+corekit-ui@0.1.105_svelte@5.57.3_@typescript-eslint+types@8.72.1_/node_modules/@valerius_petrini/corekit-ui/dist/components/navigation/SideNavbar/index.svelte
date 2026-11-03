<script lang="ts">
    import type { SideNavbarProps } from "./types";
    import { twMerge } from "tailwind-merge";
    import Button from "../../inputs/Button/index.svelte";
    import Text from "../../typography/Text/index.svelte";
    import { multiAction } from "../../../utils/multiAction";

    let { 
        children = undefined, 
        class: className = "", 
        element = $bindable(),
        items = [],
        currentPath = "",
        offset = "3.5rem",
        use = [],
        ...restProps
    }: SideNavbarProps = $props();

    let expanded = $state(false);

    const defaultClass = "transition-[width] duration-300 overflow-hidden fixed left-0 h-full z-[100] py-2 flex flex-col items-center gap-1 bg-sub-background border-r border-box border-r-sub-background-hover";
    const expandedClass = $derived(expanded ? "w-48" : "w-12");

    const combinedClass = $derived(twMerge(
        defaultClass,
        expandedClass,
        className,
    ));
</script>

<nav style="margin-top: {offset}" class={combinedClass} {...restProps} onmouseenter={() => expanded = true} onmouseleave={() => expanded = false} bind:this={element} use:multiAction={use}>
    {#each items as item}
        {@const isActive = currentPath === item.href}
        <Button size="xs" color="none" class="{isActive ? 'bg-form-background text-main-text' : 'text-sub-text'} hover:text-main-text py-1 text-nowrap flex justify-start gap-2 overflow-hidden mx-1 w-[calc(100%-16px)] hover:bg-form-background px-1.5" href={item.href}>
            <item.icon class="w-5 h-5 shrink-0"/>
            <Text tag="span" class="transition-opacity duration-200 text-sm text-inherit {expanded ? 'w-auto opacity-100 pr-3' : 'w-0 opacity-0'}">
                {item.label}
            </Text>
        </Button>
    {/each}
</nav>
