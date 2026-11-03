<script lang="ts">
    import { twMerge } from "tailwind-merge";
    import type { BreadcrumbItemProps } from "./types";
    import { Text } from "../../typography";
    import { multiAction } from "../../../utils/multiAction";

    let {
        children = undefined, 
        class: className = "",
        element = $bindable(),
        use = [],
        href = undefined,
        ...restProps
    }: BreadcrumbItemProps = $props();

    const combinedClass = $derived(twMerge(
        "vpcui-breadcrumb-item text-main-text",
        className
    ));
</script>

<li class={combinedClass} {...restProps} aria-current={href ? undefined : 'page'} bind:this={element} use:multiAction={use}>
    {#if href}
        <a class="hover:underline hover:text-sub-text transition-colors" href={href}>
            {@render children?.()}
        </a>
    {:else}
        <span class="font-medium text-main-text opacity-100 cursor-default">
            {@render children?.()}
        </span>
    {/if}
</li>

<style>
    :global(li.vpcui-breadcrumb-item + li.vpcui-breadcrumb-item::before) {
        content: "›";
        margin: 0 0.25rem;
        color: var(--color-main-text);
    }
</style>