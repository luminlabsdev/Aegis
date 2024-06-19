import { defineConfig, type DefaultTheme } from 'vitepress'

// https://vitepress.dev/reference/site-config
function nav(): DefaultTheme.NavItem[] {
	return [
		{
			text: 'Articles',
			items: [
				{ text: 'Installation', link: '/guides/introduction/installation' },
				{ text: 'Basics', link: '/guides/basics/creating-instances' },
				{ text: 'Intermediate', link: '/guides/intermediate/creating-keys' },
			]
		},

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
				{ text: 'Creating instances', link: 'creating-instances' },
				{ text: 'Updating properties', link: 'updating-properties' },
				{ text: 'Using keys', link: 'using-keys' },
				{ text: 'Customizing keys', link: 'customizing-keys' },
				{ text: 'Managing states', link: 'managing-states' },
				{ text: 'Managing springs', link: 'managing-springs' }
			]
		},
	]
}

function sidebarReference(): DefaultTheme.SidebarItem[] {
	return [
		{
			text: 'API Reference',
			items: [
				{ text: 'Aegis', link: '/api/' },
				{
					text: 'Constructors',
					collapsed: false,
					items: [
						{ text: 'State', link: '/api/state' },
						{ text: 'Spring', link: '/api/spring' },
					]
				},
				{
					text: 'Keys',
					collapsed: false,
					link: '/api/keys/',
					items: [
						{ text: 'Children', link: 'keys/children' },
						{ text: 'Ref', link: '/keys/ref' },
						{ text: 'Events', link: '/keys/events' },
						{ text: 'Changes', link: '/keys/changes' },
						{ text: 'Attributes', link: '/keys/attributes' },
						{ text: 'Tags', link: '/keys/tags' }
					]
				}
			]
		}
	]
}

function sidebarExtra(): DefaultTheme.SidebarItem[] {
	return [
		{
			text: 'Extra',
			collapsed: false,
			items: [
				{ text: 'Performance', link: 'performance' },
				{ text: 'vs Fusion', link: 'vs-fusion' },
				{ text: 'React/Roact', link: 'vs-react/roact' },
				{ text: 'FAQ', link: 'faq' },
				{ text: 'Common mistakes', link: 'common-mistakes' }
			]
		}
	]
}

export default defineConfig({
	head: [['link', { rel: 'icon', href: '/favicon.ico' }]],
	base: '/Aegis/',
	title: 'Aegis',
	titleTemplate: ':title | Lumin',
	description: 'A simple strictly typed UI framework made specifically for Roblox.',
	lastUpdated: true,
	lang: 'en-us',

	themeConfig: {
		nav: nav(),
		sidebar: {
			'/guide/': { base: '/guide/', items: sidebarGuide() },
			'/api/': { base: '/api/', items: sidebarReference() },
			'/extra/': { base: '/extra/', items: sidebarExtra() },
		},
		outline: [2, 3],

		search: { provider: 'local' },
		logo: { src: '/logo.png', width: 24, height: 24 },
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
