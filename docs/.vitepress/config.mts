import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
	head: [['link', { rel: 'icon', href: '/favicon.ico' }]],
	base: "/Aegis/",
	title: "Aegis",
	titleTemplate: ":title | Lumin",
	description: "A simple strictly typed UI framework made specifically for Roblox.",
	lastUpdated: true,
	lang: 'en-us',
	themeConfig: {
		// https://vitepress.dev/reference/default-theme-config
		nav: [
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
		],

		sidebar: {
			'/guides': [
				{
					items: [
						{
							text: "Introduction",
							base: "/guides/introduction/",
							collapsed: false,
							items: [
								{ text: "What is Aegis?", link: "what-is-aegis" },
								{ text: "Keys and Services", link: "keys-services" },
								{ text: "Installation", link: "installation" },
							]
						},
						{
							text: "Basic usage",
							base: "/guides/basics/",
							collapsed: false,
							items: [
								{ text: "Creating instances", link: "creating-instances" },
								{ text: "Using keys", link: "using-keys" },
								{ text: "Creating keys", link: "creating-keys" },
								{ text: "Using services", link: "using-services" },
							]
						},
						{
							text: "Intermediate usage",
							base: "/guides/intermediate/",
							collapsed: true,
							items: [

							]
						}
					]
				}
			],

			'/api': [
				{
					text: "API Reference",
					items: [
						{ text: "Aegis", link: "/api/" },
						{
							text: "Services",
							collapsed: false,
							items: [
								{ text: "State", link: "/api/state" },
								{ text: "Spring", link: "/api/spring" },
							]
						},
						{
							text: "Keys",
							collapsed: false,
							items: [
								{ text: "Key", link: "/api/keys/" },
								{ text: "Children", link: "/api/keys/children" },
								{ text: "Ref", link: "/api/keys/ref" },
								{ text: "Events", link: "/api/keys/events" },
								{ text: "Changes", link: "/api/keys/changes" },
								{ text: "Attributes", link: "/api/keys/attributes" },
								{ text: "Tags", link: "/api/keys/tags" }
							]
						}
					]
				}
			]
		},

		outline: [2, 3],

		search: {
			provider: 'local'
		},

		editLink: {
			pattern: 'https://github.com/canary-softworks/UIShelf/edit/main/docs/:path',
		},

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