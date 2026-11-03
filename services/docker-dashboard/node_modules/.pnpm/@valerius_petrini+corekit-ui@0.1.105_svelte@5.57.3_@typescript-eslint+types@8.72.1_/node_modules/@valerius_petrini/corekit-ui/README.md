# Corekit UI

Corekit UI is a Svelte 5 component library with ~30 components spanning inputs, navigation, feedback, data display, and more.
It's built around a CSS theming system, letting you configure colors and typography once and have it apply consistently across every component.

## Installation

Install via `npm`:

``` bash
npm i @valerius_petrini/corekit-ui
```

Add this to your `css` file:

``` css
@import '@valerius_petrini/corekit-ui/layout.css';
@source '../node_modules/@valerius_petrini/corekit-ui/';
@custom-variant dark (&:where(.dark, .dark *));
```

After that, each component can be included in your project through an import:

``` svelte
import { Navbar, Image, Button } from '@valerius_petrini/corekit-ui';

<Button color="primary" href="example.com">Click Me!</Button>
```

## Documentation

Documentation can be found on the [Corekit UI Website](https://corekit-ui.vercel.app)

## Theming

To add themes to your project, add this snippet to your `css` file:

``` css
:root {
    --vpcui-font-display: "Lora", serif;
    --vpcui-font-body: "DM Sans", sans-serif;

    --vpcui-primary: #ffffff;
    --vpcui-secondary: #ff00ff;
    --vpcui-tertiary: #ffff00;
}
```

A list of all themes can be found [here](./src/lib/styles/layout.css).

## Local Development

To develop Corekit UI on your own device, clone the repo locally and run these commands:

``` bash
npm i
npm run dev # Run Storybook
```

Storybook will open the UI in a tab.

## Component List

- Display
  - Accordion
    - AccordionItem
  - Badge
  - Card
  - Copyright
  - DataGrid
  - Image
  - KBD
  - Skeleton
  - Table
    - TableBody
    - TableCell
    - TableHeadCell
    - TableHeader
    - TableRow
  - Tree
    - TreeNode
- Feedback
  - Loader
  - Modal
  - Progress
  - Toast
- Inputs
  - Button
  - Checkbox
  - ColorInput
  - Combobox
  - FileInput
  - Input
  - Select
  - Textarea
- Layout
  - Box
- Navigation
  - Breadcrumb
    - BreadcrumbItem
  - Footer
  - Navbar
    - NavbarDropdown
    - NavbarElement
    - NavbarSeparator
  - SideNavbar
- Overlay
  - Tooltip
- Typography
  - Link
  - Text
  - Typewriter
- Utility (Requires SvelteKit)
  - Analytics
  - SEO

## License

Corekit UI is licensed under the [MIT License](./LICENSE).
