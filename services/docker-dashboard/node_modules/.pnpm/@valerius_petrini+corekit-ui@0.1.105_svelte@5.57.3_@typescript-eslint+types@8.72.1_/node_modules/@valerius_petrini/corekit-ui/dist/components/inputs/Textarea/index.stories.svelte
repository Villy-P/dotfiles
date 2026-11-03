<script module lang="ts">
	import { defineMeta } from "@storybook/addon-svelte-csf";
	import Textarea from "./index.svelte";

	const argTypes = {
		placeholder: {
			control: "text",
			description: "A string that provides a hint to the user of what can be entered in the textarea.",
			table: {
				type: { summary: "string" },
				category: "Content",
			},
		},
        rows: {
            control: "number",
            description: "The number of visible text lines for the control.",
            table: {
            type: { summary: "number" },
            category: "Content",
            },
        },
        label: {
            control: "text",
            description: "A string that represents the label for the textarea.",
            table: {
            type: { summary: "string" },
            category: "Content",
            },
        },
        variant: {
            control: { type: "select", options: ["default", "floating"] },
            description: "The visual style of the textarea.",
            table: {
            type: { summary: "string" },
            category: "Appearance",
            },
        },
	} as const;

	const { Story } = defineMeta({
		title: "Components/Inputs/Textarea",
		component: Textarea,
		argTypes,
		parameters: {
			controls: {
				include: Object.keys(argTypes),
			},
			docs: {
				description: {
					component: "A textarea component that allows users to input multiple lines of text.",
				},
			},
		},
	});
</script>

<Story name="Default" args={{ label: "Input Label", placeholder: "Enter text here...", rows: 6, variant: "floating" }}></Story>
