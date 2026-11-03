<script lang="ts">
    import { twMerge } from "tailwind-merge";
    import type { CopyrightProps } from "./types";
    import { Text } from "../../typography";

    let { 
        holder = "",
        class: className = "",
        element = $bindable(),
        use = [],
        ...restProps
    }: CopyrightProps = $props();

    const year = $derived(new Date().getFullYear());
    const combined = $derived(twMerge(
        "select-none opacity-80",
        className
    ));
</script>

<Text class={combined} {...restProps} bind:element {use}>
    &copy; {year} {holder}
</Text>