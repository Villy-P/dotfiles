const SERVERS = ['homelab'] as const;
export type Server = (typeof SERVERS)[number];
