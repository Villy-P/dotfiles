<script lang="ts">
	import { getServiceStatus, SERVICE_LIST } from '#lib/services.ts';
	import { WEBSITE_LIST } from '#lib/websites.ts';
	import { ScrollText } from '@lucide/svelte';
	import { Card, Image, Link, Progress, Text, tooltip } from '@valerius_petrini/corekit-ui';

	function getHeaderGreeting() {
		const now = new Date();
		const currentHour = now.getHours();

		if (currentHour < 5 || currentHour > 20) {
			return 'Good Evening';
		} else if (currentHour < 11) {
			return 'Good Morning';
		} else {
			return 'Good Afternoon';
		}
	}
</script>

<div class="flex flex-col gap-4 p-3">
	<Text tag="h1">{getHeaderGreeting()}, Valerius</Text>
	<div class="flex flex-wrap gap-4">
		{#each SERVICE_LIST as service}
			{@const status = getServiceStatus(service)}
			<Card
				class="grid w-96 grid-cols-[40px_1fr_100px] gap-x-4 gap-y-1 py-2 pr-2 pl-4"
				href="https://{service.server}.tailc8658b.ts.net:{service.port}"
				external
			>
				<Image
					class="row-span-3 h-10 w-10 self-center"
					src={service.icon}
					alt="{service.name} Logo"
				/>

				<Text>{service.name}</Text>
				<div class="flex self-center gap-1">
					<Link><ScrollText size={16} /></Link>
					<Link class={status.className}>
						<status.icon size={16} />
					</Link>
				</div>

				<Text tag="label">{service.description}</Text>
				<div class="flex items-center gap-2">
					<Text class="font-mono" tag="label">CPU 100%</Text>
					<div class="w-6">
						<Progress size="xs" color="pink" />
					</div>
				</div>

				<Text tag="label">{service.server}:{service.port}</Text>
				<div class="flex items-center gap-2">
					<Text class="font-mono" tag="label">RAM 100%</Text>
					<div class="w-6">
						<Progress size="xs" color="indigo" />
					</div>
				</div>
			</Card>
		{/each}
	</div>
	<div class="flex gap-4">
		{#each WEBSITE_LIST as website}
			<Card
				class="flex-center h-fit w-fit p-2"
				href={website.link}
				external
				use={[[tooltip, website.name]]}
			>
				<Image class="h-8 w-8" src={website.icon} alt="{website.name} Logo" />
			</Card>
		{/each}
	</div>
</div>
