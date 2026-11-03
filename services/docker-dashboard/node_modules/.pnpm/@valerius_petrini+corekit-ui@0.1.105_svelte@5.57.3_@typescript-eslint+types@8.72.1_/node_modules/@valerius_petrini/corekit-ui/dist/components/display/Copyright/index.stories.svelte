<script module lang="ts">
	import { defineMeta } from "@storybook/addon-svelte-csf";
    import Copyright from "./index.svelte";
	import { baseArgTypes } from "../../../styles/storybook";

	const argTypes = {
		...baseArgTypes,
		holder: {
			control: "text",
			description: "The name of the copyright holder to display.",
			table: {
				type: { summary: "string" },
				category: "Content",
			},
		},
	} as const;

	const { Story } = defineMeta({
		title: "Components/Display/Copyright",
		component: Copyright,
		argTypes,
		parameters: {
			controls: {
				include: Object.keys(argTypes),
			},
			docs: {
				description: {
					component: "The Copyright component is used to display copyright information, typically in the footer of a website or application. It accepts a 'holder' prop to specify the name of the copyright holder."
				}
			}
		},
	});
</script>

<Story name="Default" args={{ holder: "Example Inc." }}></Story>