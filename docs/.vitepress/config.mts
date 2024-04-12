import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
	head: [['link', { rel: 'icon', href: '/favicon.ico' }]],
	base: "/Aegis/",
	title: "Aegis",
	titleTemplate: "Lumin Docs",
	description: "A simple strictly typed UI framework made specifically for Roblox.",
	lastUpdated: true,
	lang: 'en-us',
	themeConfig: {
		// https://vitepress.dev/reference/default-theme-config
		nav: [
			{
				text: 'Guides',
				items: [
					{ text: 'Install', link: '/installation' },
					{ text: 'Usage', link: '/guides/index' },
				]
			},

			{ text: 'API', link: '/api/index' },
			{ text: 'Changelog', link: '/changelog' }
		],

		sidebar: {
			'/api': [
				{ text: 'UIShelf', link: '/api/index' },
				{ text: 'Icon', link: '/api/icon' },
				{ text: 'Spacer', link: '/api/spacer' },
				{ text: 'MenuItem', link: '/api/menuitem' },
			],
			'/guides': [
				{ text: 'Instance building', link: '/guides/build' },
				{ text: 'Input', link: '/guides/input' },
				{ text: 'Notices', link: '/guides/notices' },
				{ text: 'Tooltips', link: '/guides/tooltips' },
				{ text: 'Menus', link: 'guides/menus' }
			]
		},

		outline: [2, 3],

		search: {
			provider: 'local'
		},

		editLink: {
			pattern: 'https://github.com/canary-softworks/UIShelf/edit/main/docs/:path'
		},

		footer: {
			message: 'Built with VitePress',
			copyright: 'Copyright © 2021 - 2024 Lumin Labs'
		},

		socialLinks: [
			{ icon: 'github', link: 'https://github.com/lumin-rbx/Aegis' },
			{ icon: 'discord', link: 'https://discord.com/invite/cwwcZtqJAt' },
		]
	}
})