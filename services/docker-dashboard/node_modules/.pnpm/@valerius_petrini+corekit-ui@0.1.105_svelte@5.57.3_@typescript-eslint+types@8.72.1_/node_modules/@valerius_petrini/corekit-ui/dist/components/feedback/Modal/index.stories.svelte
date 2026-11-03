<script module lang="ts">
	import { defineMeta } from "@storybook/addon-svelte-csf";
	import Button from "../../inputs/Button/index.svelte";
    import Text from "../../typography/Text/index.svelte";
    import Modal from "./index.svelte";
	import { cardArgTypes } from "../../display/Card/storybook";

	const argTypes = {
		...cardArgTypes,
		open: {
			control: "boolean",
			description: "Whether the modal is open or not.",
			table: {
				type: { summary: "boolean" },
				category: "State",
			},
		},
		position: {
			control: "select",
			options: ["top", "center", "bottom", "top-left", "top-right", "bottom-left", "bottom-right", "left", "right"],
			description: "The position of the modal on the screen.",
			table: {
				type: { summary: "Position" },
				category: "Appearance",
			},
		},
	} as const;

	const { Story } = defineMeta({
		title: "Components/Feedback/Modal",
		component: Modal,
		argTypes,

		parameters: {
			controls: {
				include: Object.keys(argTypes),
			},
			docs: {
				description: {
					component: "The Modal component is used to display content in a layer above the main application. It can be used for dialogs, forms, or any content that requires user attention. The modal can be positioned in various locations on the screen and can be styled using the same props as the Card component."
				}
			}
		},
	});
</script>

<Story name="Default" args={{ variant: "bordered", size: "md" }}>
    <Text tag="h2" class="text-2xl font-bold mb-4">Customizable Modal</Text>
    <Text class="mb-4">This is a customizable modal component. You can add any content here and style it as needed.</Text>
    <Button href="https://example.com" external>Learn More</Button>
</Story>