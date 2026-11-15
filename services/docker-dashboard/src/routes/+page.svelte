<script lang="ts">
	import { SERVICE_LIST } from '#lib/services.ts';
	import { Card, Image, Text } from '@valerius_petrini/corekit-ui';

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
			<Card
				class="flex w-48 flex-row items-center gap-4 p-2"
				href="https://homelab.tailc8658b.ts.net:{service.port}"
				external
			>
				<Image class="h-10 w-10" src={service.icon} alt="{service.name} Logo" />
				<Text>{service.name}</Text>
			</Card>
		{/each}
	</div>
</div>
