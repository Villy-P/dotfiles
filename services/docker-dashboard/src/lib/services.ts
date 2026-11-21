import ActualLogo from '#lib/assets/service-icons/actual-budget.svg';
import AudiomuseAILogo from '#lib/assets/service-icons/audiomuse-ai.png';
import BookorbitLogo from '#lib/assets/service-icons/bookorbit.webp';
import CaddyLogo from '#lib/assets/service-icons/caddy.svg';
import CollaboraLogo from '#lib/assets/service-icons/collabora-office.webp';
import ConvertXLogo from '#lib/assets/service-icons/convertx.webp';
import DozzleLogo from '#lib/assets/service-icons/dozzle.svg';
import DrawioLogo from '#lib/assets/service-icons/draw-io.svg';
import EpicGamesLogo from '#lib/assets/service-icons/epic-games-light.svg';
import FeishinLogo from '#lib/assets/service-icons/feishin.png';
import GrafanaLogo from '#lib/assets/service-icons/grafana.svg';
import ImmichLogo from '#lib/assets/service-icons/immich.svg';
import ITToolsLogo from '#lib/assets/service-icons/it-tools-light.svg';
import JellyfinLogo from '#lib/assets/service-icons/jellyfin.svg';
import KopiaLogo from '#lib/assets/service-icons/kopia.svg';
import NavidromeLogo from '#lib/assets/service-icons/navidrome.svg';
import NextcloudLogo from '#lib/assets/service-icons/nextcloud-white.svg';
import OllamaLogo from '#lib/assets/service-icons/ollama.svg';
import OpenWebUILogo from '#lib/assets/service-icons/open-webui.svg';
import PiHoleLogo from '#lib/assets/service-icons/pi-hole.svg';
import PrometheusLogo from '#lib/assets/service-icons/prometheus.svg';
import SearXNGLogo from '#lib/assets/service-icons/searxng.svg';
import StirlingPDFLogo from '#lib/assets/service-icons/stirling-pdf.svg';
import UptimeKumaLogo from '#lib/assets/service-icons/uptime-kuma.svg';
import VaultwardenLogo from '#lib/assets/service-icons/vaultwarden-light.svg';
import YamtrackLogo from '#lib/assets/service-icons/yamtrack-light.svg';
import HomeAssistantLogo from '#lib/assets/service-icons/home-assistant.svg';
import RomMLogo from '#lib/assets/service-icons/romm.svg'
import { CircleCheck, type LucideProps } from '@lucide/svelte';
import type { Server } from './servers';
import type { Component } from 'svelte';

export interface Service {
	name: string;
    description: string;
	icon: string;
	port?: number;
    server?: Server;
}

export const SERVICE_LIST: Service[] = [
	{
		name: 'Actual',
        description: 'Personal Finance',
		icon: ActualLogo,
		port: 8443,
        server: 'homelab'
	},
	{
		name: 'Audiomuse AI',
        description: 'AI Music Analyzer',
		icon: AudiomuseAILogo,
		port: 8458,
        server: 'homelab'

	},
	{
		name: 'Bookorbit',
        description: 'Book Server',
		icon: BookorbitLogo,
		port: 8461,
        server: 'homelab'

	},
	{
		name: 'Caddy',
        description: 'Reverse Proxy',
		icon: CaddyLogo,
	},
	{
		name: 'Collabora',
        description: 'Office Suite',
		icon: CollaboraLogo,
		port: 8450,
        server: 'homelab'
	},
	{
		name: 'ConvertX',
        description: 'File Conversion',
		icon: ConvertXLogo,
		port: 8448,
        server: 'homelab'
	},
	{
		name: 'Dozzle',
        description: 'Log Viewer',
		icon: DozzleLogo,
		port: 8457,
        server: 'homelab'
	},
	{
		name: 'Draw.io',
        description: 'Diagram Editor',
		icon: DrawioLogo,
		port: 8467,
        server: 'homelab'
	},
	{
		name: 'Epic Games Claimer',
        description: 'Free Games',
		icon: EpicGamesLogo,
		port: 8453,
        server: 'homelab'
	},
	{
		name: 'Feishin',
        description: 'Modern Navidrome Client',
		icon: FeishinLogo,
		port: 8459,
        server: 'homelab'
	},
	{
		name: 'Grafana',
        description: 'Server Monitoring',
		icon: GrafanaLogo,
		port: 8466,
        server: 'homelab'
	},
	{
		name: 'Immich',
        description: 'Image Storage',
		icon: ImmichLogo,
		port: 8444,
        server: 'homelab'
	},
	{
		name: 'IT Tools',
        description: 'Service Tools Collection',
		icon: ITToolsLogo,
		port: 8442,
        server: 'homelab'
	},
	{
		name: 'Jellyfin',
        description: 'Movie/TV Server',
		icon: JellyfinLogo,
		port: 8460,
        server: 'homelab'
	},
	{
		name: 'Kopia',
        description: 'Backup Service',
		icon: KopiaLogo,
		port: 8441,
        server: 'homelab'
	},
	{
		name: 'Kopia (Local)',
        description: "Local Backup Service",
		icon: KopiaLogo,
		port: 8452,
        server: 'homelab'
	},
	{
		name: 'Navidrome',
        description: "Music Streaming",
		icon: NavidromeLogo,
		port: 8454,
        server: 'homelab'
	},
	{
		name: 'Nextcloud',
        description: 'Drive, Calendar, Contacts',
		icon: NextcloudLogo,
		port: 8447,
        server: 'homelab'
	},
	{
		name: 'Ollama',
        description: "Local AI Models",
		icon: OllamaLogo,
		port: 8463,
        server: 'homelab'
	},
	{
		name: 'Open WebUI',
        description: "Ollama frontend",
		icon: OpenWebUILogo,
		port: 8465,
        server: 'homelab'
	},
	{
		name: 'Pi Hole',
        description: "DNS level adblocking",
		icon: PiHoleLogo,
		port: 8445,
        server: 'homelab'
	},
	{
		name: 'Prometheus',
        description: 'System Resource Monitor',
		icon: PrometheusLogo,
		port: 8464,
        server: 'homelab'
	},
	{
		name: 'SearXNG',
        description: 'Private Web Search',
		icon: SearXNGLogo,
		port: 8462,
        server: 'homelab'
	},
	{
		name: 'Stirling PDF',
        description: 'PDF Tool Collection',
		icon: StirlingPDFLogo,
		port: 8451,
        server: 'homelab'
	},
	{
		name: 'Uptime Kuma',
        description: 'Service Uptime Monitoring',
		icon: UptimeKumaLogo,
		port: 8456,
        server: 'homelab'
	},
	{
		name: 'Vaultwarden',
        description: 'Password Database',
		icon: VaultwardenLogo,
		port: 8449,
        server: 'homelab'
	},
	{
		name: 'Yamtrack',
        description: 'Media Tracker',
		icon: YamtrackLogo,
		port: 8455,
        server: 'homelab'
	}, {
        name: 'Home Assistant',
        description: 'Smart Home Management',
        icon: HomeAssistantLogo,
        port: 8468,
        server: 'homelab'
    }, {
        name: 'RomM',
        description: 'ROM Player',
        icon: RomMLogo,
        port: 8469,
        server: 'homelab'
    }
].sort((a, b) => a.name.localeCompare(b.name));

export interface ServiceStatus {
    className: string;
    icon: Component<LucideProps, {}, "">;
}

export function getServiceStatus(service: Service): ServiceStatus {
    return {
        className: 'text-green-500',
        icon: CircleCheck
    }
}
