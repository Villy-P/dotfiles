<script lang="ts">
    import { twMerge } from "tailwind-merge";
    import { defaultTableCellClass, defaultTableHeaderClass } from "../table";
    import type { TableHeadCellProps } from "./types";
    import { multiAction } from "../../../utils/multiAction";

    let { 
        children = undefined, 
        class: className = "",
        element = $bindable(),
        use = [],
        ...restProps
    }: TableHeadCellProps = $props();

    const combinedTableHeaderClass = $derived(twMerge(
        defaultTableHeaderClass,
        defaultTableCellClass,
        className
    ));
</script>

<th class={combinedTableHeaderClass} bind:this={element} {...restProps} use:multiAction={use}>
    {@render children?.()}
</th>