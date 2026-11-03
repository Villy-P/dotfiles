<script module lang="ts">
	import { defineMeta } from "@storybook/addon-svelte-csf";
    import KBD from "./index.svelte";
  import { baseArgTypes } from "../../../styles/storybook";

	const argTypes = {
		...baseArgTypes,
		subtext: {
			control: "text",
			description: "Optional subtext to display below the main keyboard key.",
			table: {
				type: { summary: "string" },
				category: "Content",
			},
		},
	} as const;

	const { Story } = defineMeta({
		title: "Components/Display/KBD",
		component: KBD,
		argTypes,
		parameters: {
			controls: {
				include: Object.keys(argTypes),
			},
			docs: {
				description: {
					component: "The KBD component is used to display keyboard keys in a stylized manner. It accepts a `subtext` prop that allows you to provide additional information or context below the main key display."
				}
			}
		},
	});
</script>

<Story name="Default">Ctrl</Story>