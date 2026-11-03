<script lang="ts">
	import { Card, Text } from '@valerius_petrini/corekit-ui';
	import { onMount } from 'svelte';
	import type { Weather } from '../types/weather';

	let weather: Weather | null = $state(null);

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

	onMount(async () => {
		const res = await fetch(`/api/weather`);
		weather = await res.json();
	});
</script>

<div class="flex flex-col gap-4 p-3">
	<Text tag="h1">{getHeaderGreeting()}, Valerius</Text>
	{#if weather}
		<Card size="full" class="flex">
            <div>{weather.current.temperature_2m}</div>
        </Card>
	{/if}
</div>
