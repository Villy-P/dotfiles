<script module lang="ts">
	import { defineMeta } from "@storybook/addon-svelte-csf";
    import Progress from "./index.svelte";
    import { baseArgTypes } from "../../../styles/storybook";
  import { sizeStyles } from "../../../styles/size";

	const argTypes = {
		...baseArgTypes,
        divClass: {
            control: "text",
            description: "Additional classes to apply to the outer div of the Progress component.",
            table: {
                type: { summary: "string" },
                category: "Appearance",
            },
        },
        progress: {
            control: "number",
            description: "The current progress value, typically between 0 and 100.",
            table: {
                type: { summary: "number" },
                category: "Content",
            },
        },
        animate: {
            control: "object",
            description: "If defined, the Progress component will animate changes in the `progress` value using the provided animation properties.",
            table: {
                type: { summary: "AnimateProps" },
                category: "Behavior",
            },
        },
        color: {
            control: "text",
            description: "A string representing a color to use for the progress bar or a gradient object with `from`, `to`, `deg`, and optional `via` properties.",
            table: {
                type: { summary: "Color OR Gradient" },
                category: "Appearance",
            },
        },
        size: {
            control: "select",
            options: sizeStyles,
            description: "The size of the progress bar, which affects its height and font size.",
            table: {
                type: { summary: "Size" },
                category: "Appearance",
            },
        },
        radius: {
            control: "select",
            options: sizeStyles,
            description: "The border radius of the progress bar, which affects how rounded the corners are.",
            table: {
                type: { summary: "Size" },
                category: "Appearance",
            },
        },
	} as const;

	const { Story } = defineMeta({
		title: "Components/Feedback/Progress",
		component: Progress,
		argTypes,

		parameters: {
			controls: {
				include: Object.keys(argTypes),
			},
			docs: {
				description: {
					component: "The Progress component is used to display the progress of a task or operation. It can be styled using the same props as the Card component."
				}
			}
		},
	});
</script>

<Story name="Default"></Story>