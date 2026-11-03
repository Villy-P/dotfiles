<script module lang="ts">
	import { defineMeta } from "@storybook/addon-svelte-csf";
    import Loader from "./index.svelte";
  import { baseArgTypes } from "../../../styles/storybook";
  import { colorStyles } from "../../../styles/color";
  import { sizeStyles } from "../../../styles/size";

	const argTypes = {
		...baseArgTypes,
		size: {
			control: "select",
			options: sizeStyles,
			description: "The size of the loader.",
			table: {
				type: { summary: "Size" },
				category: "Appearance",
			},
		},
		color: {
			control: "select",
			options: colorStyles,
			description: "The color of the loader.",
			table: {
				type: { summary: "Color" },
				category: "Appearance",
			},
		},
	} as const;

	const { Story } = defineMeta({
		title: "Components/Feedback/Loader",
		component: Loader,
		argTypes,

		parameters: {
			controls: {
				include: Object.keys(argTypes),
			},
			docs: {
				description: {
					component: "The Loader component is used to indicate that content is loading. It accepts `size` and `color` props to customize its appearance."
				}
			}
		},
	});
</script>

<Story name="Default" args={{  }}></Story>