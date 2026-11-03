<script lang="ts">
    import { twMerge } from "tailwind-merge";
    import type { BreadcrumbProps } from "./types";
    import { multiAction } from "../../../utils/multiAction";

    let {
        children = undefined, 
        class: className = "",
        element = $bindable(),
        use = [],
        ...restProps
    }: BreadcrumbProps = $props();

    const combinedClass = $derived(twMerge(
        "vpcui-breadcrumb",
        className
    ));
</script>

<nav aria-label="Breadcrumb" class={combinedClass} {...restProps} bind:this={element} use:multiAction={use}>
    <ol class="flex flex-wrap items-center">
        {@render children?.()}
    </ol>
</nav>