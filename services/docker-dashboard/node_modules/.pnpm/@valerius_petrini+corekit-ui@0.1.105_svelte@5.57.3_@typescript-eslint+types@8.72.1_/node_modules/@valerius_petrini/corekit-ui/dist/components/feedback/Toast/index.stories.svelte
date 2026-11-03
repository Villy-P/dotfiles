<script module lang="ts">
	import { defineMeta } from "@storybook/addon-svelte-csf";
    import Progress from "./index.svelte";
    import { baseArgTypes } from "../../../styles/storybook";
    import { sizeStyles } from "../../../styles/size";
  import { Text } from "../../typography";

	const argTypes = {
		...baseArgTypes,
        message: {
            control: "text",
            description: "The message to display in the toast notification.",
            table: {
                type: { summary: "string" },
                category: "Content",
            },
        },
        duration: {
            control: "number",
            description: "The duration (in milliseconds) for which the toast should be visible before automatically closing.",
            table: {
                type: { summary: "number" },
                category: "Behavior",
            },
        },
        position: {
            control: "select",
            options: ["top-left", "top-right", "bottom-left", "bottom-right", "top", "bottom", "left", "right", "center"],
            description: "The position on the screen where the toast should appear.",
            table: {
                type: { summary: "Position" },
                category: "Appearance",
            },
        },
        type: {
            control: "select",
            options: ["success", "error", "info", "warning"],
            description: "The type of the toast, which determines its color and icon.",
            table: {
                type: { summary: "ToastType" },
                category: "Appearance",
            },
        },
        size: {
            control: "select",
            options: sizeStyles,
            description: "The size of the toast, which affects its height and font size.",
            table: {
                type: { summary: "Size" },
                category: "Appearance",
            },
        },
        radius: {
            control: "select",
            options: sizeStyles,
            description: "The border radius of the toast, which affects how rounded the corners are.",
            table: {
                type: { summary: "Size" },
                category: "Appearance",
            },
        },
	} as const;

	const { Story } = defineMeta({
		title: "Components/Feedback/Toast",
		component: Progress,
		argTypes,

		parameters: {
			controls: {
				include: Object.keys(argTypes),
			},
			docs: {
				description: {
					component: "The Toast component is used to display brief notifications to the user. It should be created by using the `toast` function from the Toast module, which allows you to specify the message, type, duration, and other properties of the toast. The Toast component itself is responsible for rendering the toast notifications and handling their appearance and behavior."
				}
			}
		},
	});
</script>

<Story name="Default" args={{ message: "This is a toast notification!", type: "info", position: "top-right", duration: 3000, size: "md", radius: "md" }}></Story>