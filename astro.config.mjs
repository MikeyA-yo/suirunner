// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

// https://astro.build/config
export default defineConfig({
	integrations: [
		starlight({
			title: 'Sui-runner',
			customCss: ['./src/styles/custom.css'],
			social: [{ icon: 'github', label: 'GitHub', href: 'https://github.com/your-repo/sui-runner' }],
			sidebar: [
				{
					label: 'Getting Started',
					items: [
						{ label: 'Installation', link: '/installation' },
						{ label: 'Watch Mode', link: '/watch-mode' },
						{ label: 'Dependency Checks', link: '/dependency-checks' },
						{ label: 'Live Dashboard', link: '/dashboard' },
						{ label: 'Wallet Management', link: '/wallet' },
					],
				},
			],
		}),
	],
});
