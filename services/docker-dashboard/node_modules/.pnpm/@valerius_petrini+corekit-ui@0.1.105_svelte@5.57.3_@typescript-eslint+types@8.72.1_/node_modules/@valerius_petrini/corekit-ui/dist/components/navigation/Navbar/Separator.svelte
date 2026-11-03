<script lang="ts">
    import { NavbarSeparatorClasses, type NavbarSeparatorProps } from "./types.js";
    import { multiAction } from "../../../utils/multiAction.js";

    let {
        variant = "dynamic",
        class: className = "",
        element = $bindable(),
        use = [],
        ...restProps
    }: NavbarSeparatorProps = $props();
</script>

<div bind:this={element} class={NavbarSeparatorClasses[variant]} {...restProps} use:multiAction={use}></div>