-- Basic indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.smarttab = true

vim.opt.scrolloff = 8

-- Search incrementally, highlight
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Show line numbers relatively
vim.opt.number = true
vim.opt.relativenumber = true

-- Replace all by-default
vim.opt.gdefault = true

-- Show unprintable
vim.opt.list = true
vim.opt.listchars = {
	tab = "⁞ ",
	trail = "·",
	lead = "░",
	leadmultispace = "⁞   ",
	nbsp = "~",
	-- eol = "¬",
}

-- Also work under ru
vim.opt.langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'

vim.opt.colorcolumn = "80"

vim.opt.showtabline = 2
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.mouse = ni
vim.keymap.set('n', 'tg', 'gT')

-- Jump to the last position in file
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = {"*"},
	callback = function()
		if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
			vim.api.nvim_exec("normal! g'\"",false)
		end
	end
})

local function git_branch()
	local branch =
		vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
	if string.len(branch) > 0 then
		return branch
	else
		return ":"
	end
end

vim.opt.statusline = string.format("%s %s %s %s %s %s",
	"%#PmenuSel#",
	git_branch(),
	"%0*%=[%Y]",
	"%{''.(&fenc?&fenc:&enc).''}[%{&ff}]",
	"[%l:%c]",
	"(%p%%/%L)"
)

-- Install lazy.nvim as plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Install plugins using lazy
require('lazy').setup({
	{ 'tpope/vim-commentary', },
	{ 'tpope/vim-fugitive', },
	{ 'sheerun/vim-polyglot',
		init = function()
			-- vim-polyglot confusingly registers *.comp both for perl and for glsl
			vim.api.nvim_set_var('polyglot_disabled', {'perl'})
		end,
	},
	-- { 'morhetz/gruvbox',
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.opt.background = 'dark'
	-- 		vim.g.gruvbox_italic = 1
	-- 		vim.cmd([[colorscheme gruvbox]])
	-- 	end,
	-- },
	{ "ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.opt.background = 'dark'
			vim.g.gruvbox_italic = 1
			-- vim.cmd([[colorscheme gruvbox]])
		end,
	},
	{ 'nvim-telescope/telescope-fzf-native.nvim',
		build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
	},
	{ 'nvim-telescope/telescope.nvim', tag = '0.1.1',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			local telescope = require('telescope')
			telescope.setup{
				defaults = {
					mappings = {
						i = { ["<CR>"] = require("telescope.actions").select_tab },
						n = { ["<CR>"] = require("telescope.actions").select_tab },
					}
				},
				extensions = {
					fzf = {
						fuzzy = true,                    -- false will only do exact matching
						override_generic_sorter = true,  -- override the generic sorter
						override_file_sorter = true,     -- override the file sorter
						case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
														 -- the default case_mode is "smart_case"
					}
				}
			}

			--telescope.load_extension('fzy_native')
			telescope.load_extension('fzf')

			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<C-p>', builtin.find_files, {})
			vim.keymap.set('n', '<leader>ft', builtin.treesitter, {})
			vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

			-- ripgrep required!!!
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
		end
	},
	{ "nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup {
				ensure_installed = { "c", "cpp", "go", "lua", "rust", "glsl" },
				highlight = { enable = true, }
			}
		end
	},
	{ 'neovim/nvim-lspconfig',
		config = function()
			-- Setup language servers.
			local lspconfig = require('lspconfig')
			lspconfig.clangd.setup {}
			lspconfig.rust_analyzer.setup {
				-- Server-specific settings. See `:help lspconfig-setup`
				settings = {
					['rust-analyzer'] = {},
				},
			}

			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
			vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
			vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
			vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
					vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
					vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
					vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set('n', '<space>wl', function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
					vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
					vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
					vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
					vim.keymap.set('n', '<space>f', function()
						vim.lsp.buf.format { async = true }
					end, opts)
				end,
			})
		end
	},
	{ 'hrsh7th/nvim-cmp',
		dependencies = {
			'neovim/nvim-lspconfig',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/cmp-vsnip',
			'hrsh7th/vim-vsnip',
		},
		config = function()
			local cmp = require'cmp'
			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'vsnip' }, -- For vsnip users.
					-- { name = 'luasnip' }, -- For luasnip users.
					-- { name = 'ultisnips' }, -- For ultisnips users.
					-- { name = 'snippy' }, -- For snippy users.
				}, {
					{ name = 'buffer' },
				})
			})

			-- Set configuration for specific filetype.
			cmp.setup.filetype('gitcommit', {
				sources = cmp.config.sources({
					-- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
					{ name = 'git' },
				}, {
					{ name = 'buffer' },
				})
			})

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ '/', '?' }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' }
				}, {
					{ name = 'cmdline' }
				})
			})

			-- Set up lspconfig.
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			-- TODO Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
			require('lspconfig')['clangd'].setup {
				capabilities = capabilities
			}
		end,
	},
	{ 'stevearc/aerial.nvim',
		dependencies = { 'neovim/nvim-lspconfig', },
		config = function()
			require('aerial').setup({
				-- optionally use on_attach to set keymaps when aerial has attached to a buffer
				on_attach = function(bufnr)
					-- Jump forwards/backwards with '{' and '}'
					vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
					vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
				end
			})
			-- You probably also want to set a keymap to toggle aerial
			vim.keymap.set('n', '<F8>', '<cmd>AerialToggle!<CR>')
		end,
	}
})

local custom_palette = {
	dark0_hard     = '#1d2021',
	-- dark0       = '#282828',
	dark0          = "#000000",
	dark0_soft     = '#32302f',
	dark1          = '#3c3836',
	dark2          = '#504945',
	dark3          = '#665c54',
	dark4          = '#7c6f64',
	light0_hard    = '#f9f5d7',
	light0         = '#fbf1c7',
	light0_soft    = '#f2e5bc',
	light1         = '#ebdbb2',
	light2         = '#d5c4a1',
	light3         = '#bdae93',
	light4         = '#a89984',
	bright_red     = '#fb4934',
	bright_green   = '#b8bb26',
	bright_yellow  = '#fabd2f',
	bright_blue    = '#83a598',
	bright_purple  = '#d3869b',
	bright_aqua    = '#8ec07c',
	bright_orange  = '#fe8019',
	neutral_red    = '#cc241d',
	neutral_green  = '#98971a',
	neutral_yellow = '#d79921',
	neutral_blue   = '#458588',
	neutral_purple = '#b16286',
	neutral_aqua   = '#689d6a',
	neutral_orange = '#d65d0e',
	faded_red      = '#9d0006',
	faded_green    = '#79740e',
	faded_yellow   = '#b57614',
	faded_blue     = '#076678',
	faded_purple   = '#8f3f71',
	faded_aqua     = '#427b58',
	faded_orange   = '#af3a03',
	gray           = "#928373",
}

-- setup must be called before loading the colorscheme
-- Default options:
require("gruvbox").setup({
	undercurl = true,
	underline = true,
	bold = true,
	italic = {
		strings = true,
		comments = true,
		operators = false,
		folds = true,
	},
	strikethrough = true,
	invert_selection = false,
	invert_signs = false,
	invert_tabline = false,
	invert_intend_guides = false,
	inverse = true, -- invert background for search, diffs, statuslines and errors
	contrast = "", -- can be "hard", "soft" or empty string
	palette_overrides = custom_palette,
	overrides = {},
	dim_inactive = false,
	transparent_mode = false,
})
vim.cmd("colorscheme gruvbox")

vim.filetype.add({
	extension = {
		vp = 'glsl',
		fp = 'glsl',
		gp = 'glsl',
		vs = 'glsl',
		fs = 'glsl',
		gs = 'glsl',
		tcs = 'glsl',
		tes = 'glsl',
		cs = 'glsl',
		vert = 'glsl',
		frag = 'glsl',
		geom = 'glsl',
		tess = 'glsl',
		shd = 'glsl',
		gls = 'glsl',
		glsl = 'glsl',
		rgen = 'glsl',
		comp = 'glsl',
		rchit = 'glsl',
		rahit = 'glsl',
		rmiss = 'glsl',
	}
})
