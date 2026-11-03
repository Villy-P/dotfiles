<script lang="ts">
    import type { TableHeaderProps } from "./types";
    import { multiAction } from "../../../utils/multiAction";

    let { 
        children = undefined, 
        class: className = "",
        element = $bindable(),
        use = [],
        ...restProps
    }: TableHeaderProps = $props();
</script>

<thead class={className} bind:this={element} {...restProps} use:multiAction={use}>
    {@render children?.()}
</thead>