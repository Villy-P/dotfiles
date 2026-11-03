<script lang="ts">
    import type { TooltipPosition } from "../../../styles/posititon.js";
    import type { TooltipProps } from "./types.js";
    import { onMount, tick, type Snippet } from "svelte";
    import { fly } from "svelte/transition";
    import { multiAction } from "../../../utils/multiAction";

    import {
        computePosition,
        flip,
        shift,
        offset,
        arrow as arrowMiddleware,
        type Placement,

        autoUpdate

    } from "@floating-ui/dom";
    import { portal } from "../../../actions/portal.js";

    let {
        text,
        position = "top",
        element = $bindable(),
        use = [],
        delay = 150,
        interactive = false,
        children,
        content,
        attachedTo,
        ...restProps
    }: TooltipProps = $props();

    let visible = $state(false);
    let x = $state(0);
    let y = $state(0);
    // svelte-ignore state_referenced_locally
    let resolvedPosition: Placement = $state(position);
    let arrowX: number | undefined = $state(undefined);
    let arrowY: number | undefined = $state(undefined);

    let trigger: HTMLDivElement | null = $state(null);
    let tooltipEl: HTMLDivElement | null = $state(null);
    let arrowEl: HTMLDivElement | null = $state(null);
    let timeout: ReturnType<typeof setTimeout>;

    async function updatePosition() {
        if (!trigger || !tooltipEl) return;

        const { x: fx, y: fy, placement, middlewareData } = await computePosition(trigger, tooltipEl, {
            placement: position,
            strategy: "absolute",
            middleware: [
                offset(8),
                flip(),
                shift({ padding: 8 }),
                arrowMiddleware({ element: arrowEl! })
            ]
        });

        x = fx;
        y = fy;
        resolvedPosition = placement;

        if (middlewareData.arrow) {
            arrowX = middlewareData.arrow.x;
            arrowY = middlewareData.arrow.y;
        }
    }

    let hideTimeout: ReturnType<typeof setTimeout>;

    function show() {
        clearTimeout(hideTimeout);
        timeout = setTimeout(async () => {
            visible = true;
            await tick();
            await updatePosition();
        }, delay);
    }

    function hide() {
        clearTimeout(timeout);
        if (interactive)
            hideTimeout = setTimeout(() => { visible = false; }, 150);
        else
            visible = false;
    }

    const flyParams = $derived.by(() => {
        const duration = 100;
        const distance = 8;
        if (resolvedPosition === "top") return { y: distance, duration };
        if (resolvedPosition === "bottom") return { y: -distance, duration };
        return { x: resolvedPosition === "right" ? -distance : distance, duration };
    });

    const arrowSide = $derived(({
        top: "bottom",
        bottom: "top",
        left: "right",
        right: "left"
    } as Record<string, string>)[resolvedPosition.split("-")[0]] ?? "bottom");

    const arrowPoints = $derived(({
        top: "0,0 8,0 4,4",
        bottom: "0,4 4,0 8,4",
        right: "4,0 4,8 0,4",
        left: "0,0 0,8 4,4"
    } as Record<string, string>)[resolvedPosition.split("-")[0]]);

    const isVertical = $derived(
        resolvedPosition.startsWith("top") || resolvedPosition.startsWith("bottom")
    );

    $effect(() => {
        if (visible && trigger && tooltipEl) {
            const cleanup = autoUpdate(
                trigger,
                tooltipEl,
                updatePosition
            );
            return () => cleanup();
        }
    });

    function onTooltipEnter() {
        clearTimeout(hideTimeout);
    }

    function onTooltipLeave() {
        visible = false;
    }

    onMount(() => {
        if (attachedTo) {
            trigger = attachedTo as HTMLDivElement;

            show();
            attachedTo.addEventListener("mouseleave", hide);

            return () => {
                attachedTo.removeEventListener("mouseleave", hide);
            };
        }
    });
</script>

{#if !attachedTo}
    <div
        role="presentation"
        bind:this={trigger}
        class="inline-flex w-fit h-fit"
        onmouseenter={show}
        onmouseleave={hide}
    >
        {@render children?.()}
    </div>
{/if}

{#if visible}
    <div
        bind:this={tooltipEl}
        use:portal
        role="tooltip"
        style="position: absolute; top: {y}px; left: {x}px;"
        class="z-999999 {interactive ? 'pointer-events-auto' : 'pointer-events-none'}"
        onmouseenter={onTooltipEnter}
        onmouseleave={onTooltipLeave}
        bind:this={element}
        use:multiAction={use}
        {...restProps}
    >
        <div
            bind:this={arrowEl}
            style="
                position: absolute;
                {arrowSide}: -4px;
                {arrowX != null ? `left: ${arrowX}px` : ''};
                {arrowY != null ? `top: ${arrowY}px` : ''};
            "
        >
            <svg
                width={isVertical ? 8 : 4}
                height={isVertical ? 4 : 8}
                viewBox={isVertical ? "0 0 8 4" : "0 0 4 8"}
            >
                <polygon points={arrowPoints} fill="currentColor" class="text-form-background" />
            </svg>
        </div>

        <div
            transition:fly={flyParams}
            class="px-2 py-1 text-xs text-main-text bg-form-background rounded whitespace-nowrap border border-white/10"
        >
            {#if content}
                {@render content()}
            {:else}
                {text}
            {/if}
        </div>
    </div>
{/if}