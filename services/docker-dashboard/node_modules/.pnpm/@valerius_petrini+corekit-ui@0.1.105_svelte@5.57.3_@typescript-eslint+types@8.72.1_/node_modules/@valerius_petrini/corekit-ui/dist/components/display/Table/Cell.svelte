<script lang="ts">
    import { twMerge } from "tailwind-merge";
    import { defaultTableCellClass } from "../table";
    import type { TableCellProps } from "./types";
    import { multiAction } from "../../../utils/multiAction";

    let { 
        children = undefined, 
        class: className = "",
        element = $bindable(),
        use = [],
        ...restProps
    }: TableCellProps = $props();

    const combinedTableCellClass = $derived(twMerge(
        defaultTableCellClass,
        className
    ));
</script>

<td class={combinedTableCellClass} bind:this={element} {...restProps} use:multiAction={use}>
    {@render children?.()}
</td>