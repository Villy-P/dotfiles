<script lang="ts">
	import { Card, Text } from '@valerius_petrini/corekit-ui';

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

<div class="p-3 flex flex-col gap-4">
	<Text tag="h1">{getHeaderGreeting()}, Valerius</Text>
	<Card>
        
    </Card>
</div>
