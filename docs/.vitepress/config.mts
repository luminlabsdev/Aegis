import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
	head: [['link', { rel: 'icon', href: '/favicon.ico' }]],
	base: "/Aegis/",
	title: "Aegis",
	titleTemplate: "Lumin",
	description: "A simple strictly typed UI framework made specifically for Roblox.",
	lastUpdated: true,
	lang: 'en-us',
	themeConfig: {
		// https://vitepress.dev/reference/default-theme-config
		nav: [
			{
				text: 'Articles',
				items: [
					{ text: 'Installation', link: '/guides/installation' },
					{ text: 'Basics', link: '/guides/creating-instances' },
				]
			},

			{ text: 'API', link: '/api/index' },
			{ text: 'Changelog', link: '/changelog' }
		],

		sidebar: {
			'/guides': [
				{
					base: "/guides",
					items: [
						{
							text: "Introduction",
							collapsed: false,
							items: [
								{ text: "What is Aegis?", link: "/what-is-aegis" },
								{ text: "Keys and Services", link: "/keys-services" },
								{ text: "Installation", link: "/installation" },
							]
						},
						{
							text: "Basic usage",
							collapsed: false,
							items: [
								{ text: "Creating instances", link: "/creating-instances" },
								{ text: "Using keys", link: "/using-keys" },
								{ text: "Using services", link: "/using-services" },
							]
						},
						{
							text: "Intermediate usage",
							collapsed: true,
							items: [
								{ text: "Creating keys", link: "/creating-keys" }
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
			{ icon: 'github', link: 'https://github.com/lumin-rbx/Aegis' },
			{ icon: 'discord', link: 'https://discord.com/invite/cwwcZtqJAt' },
		]
	}
})