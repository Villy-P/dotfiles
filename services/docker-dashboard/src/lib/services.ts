import ActualLogo from '#lib/service-icons/actual-budget.svg';
import AudiomuseAILogo from '#lib/service-icons/audiomuse-ai.png';
import BookorbitLogo from '#lib/service-icons/bookorbit.webp';
import CaddyLogo from '#lib/service-icons/caddy.svg';
import CollaboraLogo from '#lib/service-icons/collabora-office.webp';
import ConvertXLogo from '#lib/service-icons/convertx.webp';
import DozzleLogo from '#lib/service-icons/dozzle.svg';
import DrawioLogo from '#lib/service-icons/draw-io.svg';
import EpicGamesLogo from '#lib/service-icons/epic-games-light.svg';
import FeishinLogo from '#lib/service-icons/feishin.png';
import GrafanaLogo from '#lib/service-icons/grafana.svg';
import ImmichLogo from '#lib/service-icons/immich.svg';
import ITToolsLogo from '#lib/service-icons/it-tools-light.svg';
import JellyfinLogo from '#lib/service-icons/jellyfin.svg';
import KopiaLogo from '#lib/service-icons/kopia.svg';
import NavidromeLogo from '#lib/service-icons/navidrome.svg';
import NextcloudLogo from '#lib/service-icons/nextcloud-white.svg';
import OllamaLogo from '#lib/service-icons/ollama.svg';
import OpenWebUILogo from '#lib/service-icons/open-webui.svg';
import PiHoleLogo from '#lib/service-icons/pi-hole.svg';
import PrometheusLogo from '#lib/service-icons/prometheus.svg';
import SearXNGLogo from '#lib/service-icons/searxng.svg';
import StirlingPDFLogo from '#lib/service-icons/stirling-pdf.svg';
import UptimeKumaLogo from '#lib/service-icons/uptime-kuma.svg';
import VaultwardenLogo from '#lib/service-icons/vaultwarden-light.svg';
import YamtrackLogo from '#lib/service-icons/yamtrack-light.svg';

export interface Service {
	name: string;
	icon: string;
	port?: number;
}

export const SERVICE_LIST: Service[] = [
	{
		name: 'Actual',
		icon: ActualLogo,
		port: 8443
	},
	{
		name: 'Audiomuse AI',
		icon: AudiomuseAILogo,
		port: 8458
	},
	{
		name: 'Bookorbit',
		icon: BookorbitLogo,
		port: 8461
	},
	{
		name: 'Caddy',
		icon: CaddyLogo
	},
	{
		name: 'Collabora',
		icon: CollaboraLogo,
		port: 8450
	},
	{
		name: 'ConvertX',
		icon: ConvertXLogo,
		port: 8448
	},
	{
		name: 'Dozzle',
		icon: DozzleLogo,
		port: 8457
	},
	{
		name: 'Draw.io',
		icon: DrawioLogo,
		port: 8467
	},
	{
		name: 'Epic Games Claimer',
		icon: EpicGamesLogo,
		port: 8453
	},
	{
		name: 'Feishin',
		icon: FeishinLogo,
		port: 8459
	},
	{
		name: 'Grafana',
		icon: GrafanaLogo,
		port: 8466
	},
	{
		name: 'Immich',
		icon: ImmichLogo,
		port: 8444
	},
	{
		name: 'IT Tools',
		icon: ITToolsLogo,
		port: 8442
	},
	{
		name: 'Jellyfin',
		icon: JellyfinLogo,
		port: 8460
	},
	{
		name: 'Kopia',
		icon: KopiaLogo,
		port: 8441
	},
	{
		name: 'Kopia (Local)',
		icon: KopiaLogo,
		port: 8452
	},
	{
		name: 'Navidrome',
		icon: NavidromeLogo,
		port: 8454
	},
	{
		name: 'Nextcloud',
		icon: NextcloudLogo,
		port: 8447
	},
	{
		name: 'Ollama',
		icon: OllamaLogo,
		port: 8463
	},
	{
		name: 'Open WebUI',
		icon: OpenWebUILogo,
		port: 8465
	},
	{
		name: 'Pi Hole',
		icon: PiHoleLogo,
		port: 8445
	},
	{
		name: 'Prometheus',
		icon: PrometheusLogo,
		port: 8464
	},
	{
		name: 'SearXNG',
		icon: SearXNGLogo,
		port: 8462
	},
	{
		name: 'Stirling PDF',
		icon: StirlingPDFLogo,
		port: 8451
	},
	{
		name: 'Uptime Kuma',
		icon: UptimeKumaLogo,
		port: 8456
	},
	{
		name: 'Vaultwarden',
		icon: VaultwardenLogo,
		port: 8449
	},
	{
		name: 'Yamtrack',
		icon: YamtrackLogo,
		port: 8455
	}
];
