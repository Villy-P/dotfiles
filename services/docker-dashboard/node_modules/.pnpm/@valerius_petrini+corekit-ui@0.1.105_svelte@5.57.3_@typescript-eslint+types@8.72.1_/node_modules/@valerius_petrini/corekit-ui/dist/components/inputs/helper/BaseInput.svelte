<script module>
    let count = 0;
</script>

<script lang="ts">
    import { twMerge } from "tailwind-merge";
    import type { BaseInputProps } from "../../../types/BaseComponent";
    import Text from "../../typography/Text/index.svelte";
    import { getSizeStyleClass } from "../../../styles/size";

    interface ExtraBaseInputProps {
        isFocused?: boolean;
        innerDivElement?: () => any;
        outerDivElementAfter?: () => any;
    }

    let { 
        children = undefined, 
        class: className = "", 
        label = "",
        labelClass = "",
        divClass = "",
        outerDivClass = "",
        value = $bindable(),
        required = false,
        disabled = false,
        variant = "default",
        size = "md",
        radius = "md",
        isFocused = false,
        icon = undefined,
        wrapper = $bindable(),
        id = `base-input-${count++}`,

        innerDivElement = undefined,
        outerDivElementAfter = undefined,

        ...restProps
    }: BaseInputProps & ExtraBaseInputProps = $props();

    const hasContent = $derived(value !== undefined && value !== null && value.toString().length > 0);

    const customLabelStyle = $derived(
        typeof size === "number" ? `font-size: ${size / 4}px` : ""
    );

    let labelClassIcon = $derived(icon != null && variant === "floating" ? "pl-[32px] pr-2" : "");

    const defaultLabelClass = "block text-sub-text font-medium mb-1 duration-100 pointer-events-none truncate w-fit";
    const floatingLabelClass = "absolute w-full z-30 top-1/2 transform -translate-y-1/2 px-1.5";

    const combinedLabelClass = $derived(twMerge(
        defaultLabelClass, 
        (variant === "floating") ? floatingLabelClass : "px-0", 
        labelClassIcon,
        getSizeStyleClass(size, "formLabel"), 
        ((isFocused || hasContent) && variant === "floating") && getSizeStyleClass(size, "formLabelSelected"),
        labelClass
    ));

    const combinedOuterDivClass = $derived(twMerge(
        "relative flex flex-col bg-transparent border-0 p-0",
        getSizeStyleClass(radius, "radius"),
        size === "full" ? "w-full" : "",
        outerDivClass,
        disabled ? "opacity-50 pointer-events-none" : ""
    ));

    const combinedDivClass = $derived(twMerge(
        "vpcui-base-input-div-class relative *:transition-all transition-colors flex-center bg-form-background border border-form-border focus-within:border-blue-400/40 overflow-hidden",
        getSizeStyleClass(radius, "radius"),
        divClass
    ));
</script>

{#snippet labelElement()}
    {#if label}
        <Text tag="label" for={id} class={combinedLabelClass} style={customLabelStyle}>
            {label}
            {#if required}
                <span class="text-[#E05555]">*</span>
            {/if}
        </Text>
    {/if}
{/snippet}

{#snippet innerDivElementWrapper()}
    <div class={combinedDivClass} bind:this={wrapper}>
        {#if variant === "floating"}
            {@render labelElement()}
        {/if}
        {#if icon}
            {@const Icon = icon}
            <Icon class="h-5 aspect-square mx-1 py-0! text-sub-text shrink-0"></Icon>
        {/if}
        {@render innerDivElement?.()}
    </div>
{/snippet}

<div class={combinedOuterDivClass}>
    {#if variant !== "floating"}
        {@render labelElement()}
    {/if}
    {@render innerDivElementWrapper()}

    {@render outerDivElementAfter?.()}
</div>

<style>
    :global(.vpcui-base-input-div-class:hover .vpcui-number-input-icon-class) {
        opacity: 1 !important;
        scale: 1 !important;
    }
</style>
