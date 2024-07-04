import { defineConfig, type DefaultTheme } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
	head: [['link', { rel: 'icon', href: '/favicon.ico' }]],
	base: '/Aegis/',
	title: 'Aegis',
	titleTemplate: ':title | Lumin',
	description: 'A simple strictly typed UI framework made specifically for Roblox.',
	lastUpdated: true,
	lang: 'en-us',

	markdown: { image: { lazyLoading: true } },
	themeConfig: {
		nav: nav(),
		sidebar: {
			'/guide/': { base: '/guide/', items: sidebarGuide() },
			'/api/': { base: '/api/', items: sidebarReference() },
			'/informative/': { base: '/informative/', items: sidebarInformative() },
		},

		outline: [2, 3],
		search: { provider: 'local' },
		logo: { src: '/logo.png', width: 20, height: 33.8 },
		editLink: { pattern: 'https://github.com/lumin-dev/Aegis/edit/main/docs/:path' },

		footer: {
			message: 'Built with VitePress',
			copyright: 'Copyright © 2021 - 2024 Lumin Labs',
		},
		socialLinks: [
			{ icon: 'github', link: 'https://github.com/lumin-dev/Aegis' },
			{ icon: 'discord', link: 'https://discord.com/invite/cwwcZtqJAt' },
		]
	}
})

function nav(): DefaultTheme.NavItem[] {
	return [
		{ text: 'Guide', link: '/guide/what-is-aegis' },
		{ text: 'Informative', link: '/informative/common-mistakes' },
		{ text: 'API', link: '/api/' },
		{ text: 'Changelog', link: '/changelog' }
	]
}

function sidebarGuide(): DefaultTheme.SidebarItem[] {
	return [
		{
			text: 'Introduction',
			collapsed: false,
			items: [
				{ text: 'What is Aegis?', link: 'what-is-aegis' },
				{ text: 'Getting started', link: 'getting-started' },
			]
		},
		{
			text: 'Tutorials',
			collapsed: false,
			items: [
				{ text: 'New instances', link: 'new-instances' },
				{ text: 'Updating instances', link: 'updating-instances' },
				{ text: 'Using keys', link: 'using-keys' },
				{ text: 'Managing keys', link: 'managing-keys' },
				{ text: 'Managing states', link: 'managing-states' },
				{ text: 'Managing springs', link: 'managing-springs' },
				{ text: 'Managing computes', link: 'managing-computes' }
			]
		},
	]
}

function sidebarReference(): DefaultTheme.SidebarItem[] {
	return [
		{
			text: 'API Reference',
			items: [
				{ text: 'Aegis', base: '/', link: 'api/' },
				{
					text: 'Constructors',
					collapsed: false,
					items: [
						{ text: 'State', link: 'state' },
						{ text: 'Spring', link: 'spring' },
						{ text: 'Compute', link: 'compute' },
					]
				},
				{
					text: 'Keys',
					collapsed: false,
					base: '/api/keys',
					link: '/',
					items: [
						{ text: 'Ref', link: '/ref' },
						{ text: 'Events', link: '/events' },
						{ text: 'Changes', link: '/changes' },
						{ text: 'Cleanup', link: '/cleanup' },
						{ text: 'Attributes', link: '/attributes' },
						{ text: 'Tags', link: '/tags' }
					]
				}
			]
		},
	]
}

function sidebarInformative(): DefaultTheme.SidebarItem[] {
	return [
		{
			text: 'Informative',
			collapsed: false,
			items: [
				{ text: 'Common mistakes', link: 'common-mistakes' },
				{ text: 'Performance', link: 'performance' },
				{ text: 'vs Fusion', link: 'vs-fusion' },
				{ text: 'vs React/Roact', link: 'vs-react-roact' },
				{ text: 'FAQ', link: 'faq' },
			]
		},
	]
}
