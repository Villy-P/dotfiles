import GithubIcon from '#lib/assets/web-icons/github.webp';
import LeetcodeIcon from '#lib/assets/web-icons/leetcode.svg';
import CanvasIcon from '#lib/assets/web-icons/canvas-lms.svg';
import DiscordIcon from '#lib/assets/web-icons/discord.svg';
import ResendIcon from '#lib/assets/web-icons/resend.ico';
import TailscaleIcon from '#lib/assets/web-icons/tailscale.ico';
import GmailIcon from '#lib/assets/web-icons/gmail.png';
import VercelIcon from '#lib/assets/web-icons/vercel-light.svg';
import SupabaseIcon from '#lib/assets/web-icons/supabase.png';
import GriffinGazetteLogo from '#lib/assets/web-icons/griffin.ico';
import TAGLogo from '#lib/assets/web-icons/taglogo.png';
import AmazonIcon from '#lib/assets/web-icons/amazon-light.svg';
import ClaudeIcon from '#lib/assets/web-icons/anthropic.svg';
import ChatGPTIcon from '#lib/assets/web-icons/chatgpt.svg';
import PersonalWebsiteIcon from '#lib/assets/web-icons/personal.png';
import LinkedinIcon from '#lib/assets/web-icons/linkedin.png';

export interface Website {
	name: string;
	icon: string;
	link: string;
}

export const WEBSITE_LIST: Website[] = [
	{
		name: 'Amazon',
		icon: AmazonIcon,
		link: 'https://amazon.com'
	},
	{
		name: 'GitHub',
		icon: GithubIcon,
		link: 'https://github.com'
	},
	{
		name: 'Claude',
		icon: ClaudeIcon,
		link: 'https://claude.ai'
	},
	{
		name: 'ChatGPT',
		icon: ChatGPTIcon,
		link: 'https://chat.com'
	},
	{
		name: 'TAG Alumni Network',
		icon: TAGLogo,
		link: 'https://tagalum.com'
	},
	{
		name: 'The Griffin Gazette',
		icon: GriffinGazetteLogo,
		link: 'https://www.griffingazette.net'
	},
	{
		name: 'Personal Website',
		icon: PersonalWebsiteIcon,
		link: 'https://valerius-petrini.vercel.app/'
	},
	{
		name: 'LinkedIn',
		icon: LinkedinIcon,
		link: 'https://linkedin.com'
	},
	{
		name: 'Supabase',
		icon: SupabaseIcon,
		link: 'https://supabase.com'
	},
	{
		name: 'Vercel',
		icon: VercelIcon,
		link: 'https://vercel.com'
	},
	{
		name: 'GMail',
		icon: GmailIcon,
		link: 'https://mail.google.com'
	},
	{
		name: 'Tailscale',
		icon: TailscaleIcon,
		link: 'https://tailscale.com'
	},
	{
		name: 'Resend',
		icon: ResendIcon,
		link: 'https://resend.com'
	},
	{
		name: 'Discord',
		icon: DiscordIcon,
		link: 'https://discord.com'
	},
	{
		name: 'Canvas LMS',
		icon: CanvasIcon,
		link: 'https://utexas.instructure.com'
	},
	{
		name: 'LeetCode',
		icon: LeetcodeIcon,
		link: 'https://leetcode.com'
	}
].sort((a, b) => a.name.localeCompare(b.name));
