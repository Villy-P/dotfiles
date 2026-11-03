<script lang="ts">
    import type { TableRowProps } from "./types";
    import { multiAction } from "../../../utils/multiAction";

    let { 
        children = undefined, 
        class: className = "",
        element = $bindable(),
        use = [],
        ...restProps
    }: TableRowProps = $props();
</script>

<tr class={className} bind:this={element} {...restProps} use:multiAction={use}>
    {@render children?.()}
</tr>