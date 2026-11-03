<script lang="ts">
    import { defaultTableClass } from "../table";
    import type { TableProps } from "./types";
    import { twMerge } from "tailwind-merge";
    import { multiAction } from "../../../utils/multiAction";
    
    let { 
        children = undefined, 
        class: className = "",
        element = $bindable(),
        use = [],
        ...restProps
    }: TableProps = $props();

    const combinedTableClass = $derived(twMerge(
        defaultTableClass,
        className
    ));
</script>

<div class="overflow-auto w-full" bind:this={element} use:multiAction={use}>
    <table {...restProps} class={combinedTableClass}>
        {@render children?.()}
    </table>
</div>