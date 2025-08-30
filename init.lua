-- ============================================================================
-- NEOVIM CONFIGURATION - Full-Stack Web Development Edition
-- ============================================================================
-- This configuration provides a complete IDE-like experience with:
-- - LSP support with auto-completion for all web technologies
-- - Advanced file explorer and fuzzy finding
-- - Git integration with advanced features
-- - Syntax highlighting for all web languages
-- - Auto-formatting and linting
-- - Debugging support for Node.js, Python, etc.
-- - Database integration and REST client
-- - Live server capabilities
-- - Advanced snippet support
-- - And much more for full-stack development!
-- ============================================================================

-- ============================================================================
-- LEADER KEY SETUP (Must be set before lazy.nvim)
-- ============================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- ============================================================================
-- BASIC VIM OPTIONS
-- ============================================================================
local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Mouse support
opt.mouse = "a"

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.breakindent = true

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.wrap = false
opt.cursorline = true
opt.colorcolumn = "80"
opt.conceallevel = 0
opt.pumheight = 10
opt.showmode = false
opt.showtabline = 2

-- Behavior
opt.hidden = true
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undodir = vim.fn.expand("~/.vim/undodir")
opt.undofile = true
opt.clipboard = "unnamedplus"
opt.splitbelow = true
opt.splitright = true
opt.autowrite = true
opt.autoread = true
opt.confirm = true
opt.updatetime = 200
opt.timeoutlen = 300
opt.completeopt = { "menuone", "noselect" }
opt.wildmode = "longest:full,full"

-- Scrolling
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Folding
opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

-- File encoding
opt.fileencoding = "utf-8"

-- ============================================================================
-- LAZY.NVIM BOOTSTRAP
-- ============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- PLUGIN CONFIGURATION
-- ============================================================================
require("lazy").setup({
  -- ========================================
  -- COLORSCHEME
  -- ========================================
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false,
        show_end_of_buffer = false,
        term_colors = true,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          mason = true,
          which_key = true,
          alpha = true,
          notify = true,
          telescope = true,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
          },
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- ========================================
  -- FILE EXPLORER
  -- ========================================
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 35,
          side = "left",
          preserve_window_proportions = true,
          number = false,
          relativenumber = false,
        },
        renderer = {
          add_trailing = false,
          group_empty = true,
          highlight_git = true,
          full_name = false,
          highlight_opened_files = "none",
          root_folder_label = ":~:s?$?/..?",
          indent_width = 2,
          indent_markers = {
            enable = false,
            inline_arrows = true,
            icons = {
              corner = "└",
              edge = "│",
              item = "│",
              bottom = "─",
              none = " ",
            },
          },
          icons = {
            webdev_colors = true,
            git_placement = "before",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
            glyphs = {
              default = "",
              symlink = "",
              bookmark = "",
              folder = {
                arrow_closed = "",
                arrow_open = "",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
                symlink_open = "",
              },
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },
        filters = {
          dotfiles = false,
          git_clean = false,
          no_buffer = false,
          custom = { "node_modules", ".cache" },
          exclude = {},
        },
        git = {
          enable = true,
          ignore = false,
          show_on_dirs = true,
          show_on_open_dirs = true,
          timeout = 400,
        },
        actions = {
          use_system_clipboard = true,
          change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
          },
          open_file = {
            quit_on_open = false,
            resize_window = true,
            window_picker = {
              enable = true,
              picker = "default",
              chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
              exclude = {
                filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                buftype = { "nofile", "terminal", "help" },
              },
            },
          },
        },
      })
    end,
  },

  -- ========================================
  -- FUZZY FINDER
  -- ========================================
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-live-grep-args.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local trouble = require("trouble.sources.telescope")

      telescope.setup({
        defaults = {
          path_display = { "truncate" },
          selection_caret = "  ",
          entry_prefix = "  ",
          initial_mode = "insert",
          selection_strategy = "reset",
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          file_ignore_patterns = { "node_modules", ".git", ".venv", "__pycache__" },
          generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
          winblend = 0,
          border = {},
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons = true,
          set_env = { ["COLORTERM"] = "truecolor" },
          file_previewer = require("telescope.previewers").vim_buffer_cat.new,
          grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
          qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
          buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
          mappings = {
            n = { ["<c-t>"] = trouble.open },
            i = { ["<c-t>"] = trouble.open },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
        },
        extensions = {
          file_browser = {
            theme = "ivy",
            hijack_netrw = true,
            mappings = {
              ["i"] = {
                -- your custom insert mode mappings
              },
              ["n"] = {
                -- your custom normal mode mappings
              },
            },
          },
        },
      })

      telescope.load_extension("fzf")
      telescope.load_extension("live_grep_args")
      telescope.load_extension("file_browser")
    end,
  },

  -- ========================================
  -- STATUSLINE
  -- ========================================
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end

      local diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn" },
        symbols = { error = " ", warn = " " },
        colored = false,
        always_visible = true,
      }

      local diff = {
        "diff",
        colored = false,
        symbols = { added = " ", modified = " ", removed = " " },
        cond = hide_in_width,
      }

      local filetype = {
        "filetype",
        icons_enabled = true,
        icon = nil,
      }

      local location = {
        "location",
        padding = 0,
      }

      local spaces = function()
        return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
      end

      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "catppuccin",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = { "alpha", "dashboard" },
          always_divide_middle = true,
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", diff, diagnostics },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { spaces, "encoding", filetype },
          lualine_y = { location },
          lualine_z = { "progress" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = { "nvim-tree", "toggleterm" },
      })
    end,
  },

  -- ========================================
  -- WHICH-KEY (Shows available keybindings)
  -- ========================================
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      local wk = require("which-key")
      wk.setup({
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
          presets = {
            operators = false,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
          },
        },
        window = {
          border = "rounded",
          position = "bottom",
          margin = { 1, 0, 1, 0 },
          padding = { 2, 2, 2, 2 },
          winblend = 0,
        },
        layout = {
          height = { min = 4, max = 25 },
          width = { min = 20, max = 50 },
          spacing = 3,
          align = "left",
        },
      })
    end,
  },

  -- ========================================
  -- TREESITTER (Better syntax highlighting)
  -- ========================================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c", "lua", "vim", "vimdoc", "query", "python", "javascript", "typescript",
          "html", "css", "scss", "json", "yaml", "markdown", "markdown_inline", "bash",
          "tsx", "jsx", "php", "go", "rust", "java", "sql", "dockerfile", "graphql",
          "prisma", "vue", "svelte", "astro", "toml", "regex", "http", "jsdoc"
        },
        sync_install = false,
        auto_install = true,
        ignore_install = {},
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
          disable = { "yaml", "python" },
        },
        autotag = {
          enable = true,
          enable_rename = true,
          enable_close = true,
          enable_close_on_slash = true,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
      })
    end,
  },

  -- ========================================
  -- LSP CONFIGURATION
  -- ========================================
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
        log_level = vim.log.levels.INFO,
        max_concurrent_installers = 4,
      })
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "ts_ls", 
          "html",
          "cssls",
          "tailwindcss",
          "emmet_ls",
          "jsonls",
          "yamlls",
          "prismals",
          "graphql",
          "dockerls",
          "docker_compose_language_service",
          "eslint",
          "volar", -- Vue
          "svelte",
          "astro",
          "phpactor",
          "gopls",
          "rust_analyzer",
        },
        automatic_installation = true,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = { 
      "mason-lspconfig.nvim", 
      "cmp-nvim-lsp",
      "folke/neodev.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      
      -- Setup neodev for lua development
      require("neodev").setup({})
      
      local capabilities = cmp_nvim_lsp.default_capabilities()
      
      -- Enhanced capabilities
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = { "documentation", "detail", "additionalTextEdits" },
      }
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      
      -- Common on_attach function
      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        
        -- Mappings
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>f', function()
          vim.lsp.buf.format({ async = true })
        end, opts)
        
        -- Auto-format on save for certain filetypes
        if client.supports_method("textDocument/formatting") then
          local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end
      
      -- Configure each LSP server
      local servers = {
        "html",
        "cssls",
        "tailwindcss",
        "emmet_ls",
        "jsonls",
        "yamlls",
        "prismals",
        "graphql",
        "dockerls",
        "docker_compose_language_service",
        "eslint",
        "volar",
        "svelte",
        "astro",
        "phpactor",
        "gopls",
        "rust_analyzer",
      }
      
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end
      
      -- Lua LSP specific configuration
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                vim.api.nvim_get_runtime_file("", true),
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
              },
              maxPreload = 100000,
              preloadFileSize = 10000,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })
      
      -- Python LSP configuration
      lspconfig.pyright.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              diagnosticMode = "workspace",
              useLibraryCodeForTypes = true,
            },
          },
        },
      })
      
      -- TypeScript/JavaScript LSP configuration
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- Disable tsserver formatting in favor of prettier
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
          on_attach(client, bufnr)
        end,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      })
      
      -- ESLint configuration
      lspconfig.eslint.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
          on_attach(client, bufnr)
        end,
      })
    end,
  },

  -- ========================================
  -- AUTOCOMPLETION
  -- ========================================
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-git",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
      },
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      
      -- Load snippets from friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
      
      -- Custom snippets
      luasnip.config.setup({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
      })
      
      local check_backspace = function()
        local col = vim.fn.col "." - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
      end
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-y>"] = cmp.config.disable,
          ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expandable() then
              luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif check_backspace() then
              fallback()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            before = function(entry, vim_item)
              vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                path = "[Path]",
                cmdline = "[CMD]",
                git = "[Git]",
              })[entry.source.name]
              return vim_item
            end,
          }),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "git" },
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        experimental = {
          ghost_text = false,
          native_menu = false,
        },
      })
      
      -- Use buffer source for `/` and `?`
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" }
        }
      })
      
      -- Use cmdline & path source for ':'
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" }
        }, {
          { name = "cmdline" }
        })
      })
      
      -- Git source setup
      require("cmp_git").setup()
    end,
  },

  -- ========================================
  -- DEBUGGING
  -- ========================================
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      
      require("mason-nvim-dap").setup({
        ensure_installed = { "node2", "python", "js", "chrome" },
        automatic_installation = true,
      })
      
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        filter_references_pattern = '<module',
        virt_text_pos = 'eol',
        all_frames = false,
        virt_lines = false,
        virt_text_win_col = nil
      })
      
      dapui.setup({
        icons = { expanded = "", collapsed = "", current_frame = "" },
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        element_mappings = {},
        expand_lines = vim.fn.has("nvim-0.7") == 1,
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              "breakpoints",
              "stacks",
              "watches",
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              "repl",
              "console",
            },
            size = 0.25,
            position = "bottom",
          },
        },
        controls = {
          enabled = true,
          element = "repl",
          icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "",
            terminate = "",
          },
        },
        floating = {
          max_height = nil,
          max_width = nil,
          border = "single",
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
      })
      
      -- Auto open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
      
      -- Node.js debugging
      dap.adapters.node2 = {
        type = 'executable',
        command = 'node',
        args = {vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js"},
      }
      
      dap.configurations.javascript = {
        {
          name = 'Launch',
          type = 'node2',
          request = 'launch',
          program = '${file}',
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = 'inspector',
          console = 'integratedTerminal',
        },
        {
          name = 'Attach to process',
          type = 'node2',
          request = 'attach',
          processId = require'dap.utils'.pick_process,
        },
      }
      
      dap.configurations.typescript = dap.configurations.javascript
      
      -- Python debugging
      dap.adapters.python = {
        type = 'executable',
        command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
        args = { '-m', 'debugpy.adapter' },
      }
      
      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            return '/usr/bin/python'
          end,
        },
      }
    end,
  },

  -- ========================================
  -- TROUBLE (Better diagnostics)
  -- ========================================
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({
        position = "bottom",
        height = 10,
        width = 50,
        icons = true,
        mode = "workspace_diagnostics",
        severity = nil,
        fold_open = "",
        fold_closed = "",
        group = true,
        padding = true,
        cycle_results = true,
        action_keys = {
          close = "q",
          cancel = "<esc>",
          refresh = "r",
          jump = { "<cr>", "<tab>", "<2-leftmouse>" },
          open_split = { "<c-x>" },
          open_vsplit = { "<c-v>" },
          open_tab = { "<c-t>" },
          jump_close = { "o" },
          toggle_mode = "m",
          switch_severity = "s",
          toggle_preview = "P",
          hover = "K",
          preview = "p",
          open_code_href = "c",
          close_folds = { "zM", "zm" },
          open_folds = { "zR", "zr" },
          toggle_fold = { "zA", "za" },
          previous = "k",
          next = "j"
        },
        multiline = true,
        indent_lines = true,
        win_config = { border = "single" },
        auto_open = false,
        auto_close = false,
        auto_preview = true,
        auto_fold = false,
        auto_jump = { "lsp_definitions" },
        use_diagnostic_signs = false
      })
    end,
  },

  -- ========================================
  -- GLORIOUS START SCREEN
  -- ========================================
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                     ",
        "    🚀 Full-Stack Web Development Ready! 🚀          ",
        "                                                     ",
      }

      dashboard.section.buttons.val = {
        dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
        dashboard.button("SPC ee", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
        dashboard.button("SPC ff", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
        dashboard.button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
        dashboard.button("SPC fr", "  > Recent Files", "<cmd>Telescope oldfiles<CR>"),
        dashboard.button("SPC pp", "  > Find Project", "<cmd>Telescope projects<CR>"),
        dashboard.button("c", "  > Configuration", "<cmd>edit $MYVIMRC<CR>"),
        dashboard.button("u", "  > Update Plugins", "<cmd>Lazy update<CR>"),
        dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
      }

      alpha.setup(dashboard.opts)
      vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    end,
  },

  -- ========================================
  -- GIT INTEGRATION
  -- ========================================
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "▎" },
          untracked = { text = "▎" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true
        },
        attach_to_untracked = true,
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol',
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          -- Actions
          map('n', '<leader>hs', gs.stage_hunk)
          map('n', '<leader>hr', gs.reset_hunk)
          map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
          map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
          map('n', '<leader>hS', gs.stage_buffer)
          map('n', '<leader>hu', gs.undo_stage_hunk)
          map('n', '<leader>hR', gs.reset_buffer)
          map('n', '<leader>hp', gs.preview_hunk)
          map('n', '<leader>hb', function() gs.blame_line{full=true} end)
          map('n', '<leader>tb', gs.toggle_current_line_blame)
          map('n', '<leader>hd', gs.diffthis)
          map('n', '<leader>hD', function() gs.diffthis('~') end)
          map('n', '<leader>td', gs.toggle_deleted)

          -- Text object
          map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      })
    end,
  },

  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse", "GRemove", "GRename", "Glgrep", "Gedit" },
  },

  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("diffview").setup({
        diff_binaries = false,
        enhanced_diff_hl = false,
        git_cmd = { "git" },
        use_icons = true,
        show_help_hints = true,
        watch_index = true,
        icons = {
          folder_closed = "",
          folder_open = "",
        },
        signs = {
          fold_closed = "",
          fold_open = "",
          done = "✓",
        },
      })
    end,
  },

  -- ========================================
  -- FORMATTING AND LINTING
  -- ========================================
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          vue = { "prettier" },
          svelte = { "prettier" },
          css = { "prettier" },
          scss = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          graphql = { "prettier" },
          lua = { "stylua" },
          python = { "isort", "black" },
          php = { "php_cs_fixer" },
          go = { "gofmt" },
          rust = { "rustfmt" },
          sql = { "sql_formatter" },
        },
        format_on_save = function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return {
            timeout_ms = 2000,
            lsp_fallback = true,
          }
        end,
        format_after_save = {
          lsp_fallback = true,
        },
      })
      
      -- Command to toggle autoformatting
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })
      
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      
      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        vue = { "eslint_d" },
        svelte = { "eslint_d" },
        python = { "pylint" },
        php = { "phpcs" },
        dockerfile = { "hadolint" },
      }
      
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },

  -- ========================================
  -- WEB DEVELOPMENT SPECIFIC PLUGINS
  -- ========================================
  
  -- Live server
  {
    "turbio/bracey.vim",
    cmd = { "Bracey", "BraceyStop", "BraceyReload" },
    build = "npm install --prefix server",
  },

  -- REST client
  {
    "rest-nvim/rest.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("rest-nvim").setup({
        result_split_horizontal = false,
        result_split_in_place = false,
        stay_in_current_window_after_split = true,
        skip_ssl_verification = false,
        encode_url = true,
        highlight = {
          enabled = true,
          timeout = 150,
        },
        result = {
          show_url = true,
          show_curl_command = false,
          show_http_info = true,
          show_headers = true,
          show_statistics = false,
          formatters = {
            json = "jq",
            html = function(body)
              return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
            end
          },
        },
        jump_to_request = false,
        env_file = '.env',
        custom_dynamic_variables = {},
        yank_dry_run = true,
        search_back = true,
      })
    end,
  },

  -- Database integration
  {
    "tpope/vim-dadbod",
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    config = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_force_echo_messages = 1
      vim.g.db_ui_win_position = "left"
      vim.g.db_ui_winwidth = 30
      
      vim.g.db_ui_table_helpers = {
        mysql = {
          Count = "select count(1) from {optional_schema}{table}",
          Explain = "EXPLAIN {last_query}"
        },
        sqlite = {
          Describe = "PRAGMA table_info({table})"
        }
      }
      
      vim.g.db_ui_icons = {
        expanded = {
          db = "▾ ",
          buffers = "▾ ",
          saved_queries = "▾ ",
          schemas = "▾ ",
          schema = "▾ פּ",
          tables = "▾ 藺",
          table = "▾ ",
        },
        collapsed = {
          db = "▸ ",
          buffers = "▸ ",
          saved_queries = "▸ ",
          schemas = "▸ ",
          schema = "▸ פּ",
          tables = "▸ 藺",
          table = "▸ ",
        },
        saved_query = "",
        new_query = "璘",
        tables = "離",
        buffers = "﬘",
        add_connection = "",
        connection_ok = "✓",
        connection_error = "✕",
      }
    end,
  },

  -- Package.json management
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("package-info").setup({
        colors = {
          up_to_date = "#3C4048",
          outdated = "#d19a66",
        },
        icons = {
          enable = true,
          style = {
            up_to_date = "|  ",
            outdated = "|  ",
          },
        },
        autostart = true,
        hide_up_to_date = false,
        hide_unstable_versions = false,
        package_manager = "npm"
      })
    end,
  },

  -- Emmet for HTML/CSS
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte" },
    config = function()
      vim.g.user_emmet_leader_key = "<C-Z>"
      vim.g.user_emmet_settings = {
        variables = { lang = "en" },
        html = {
          default_attributes = {
            option = { value = nil },
            textarea = { id = nil, name = nil, cols = 10, rows = 10 },
          },
          snippets = {
            ["html:5"] = "<!DOCTYPE html>\n"
              .. '<html lang="${lang}">\n'
              .. "<head>\n"
              .. '\t<meta charset="${charset}">\n'
              .. '\t<meta name="viewport" content="width=device-width, initial-scale=1.0">\n'
              .. "\t<title></title>\n"
              .. "</head>\n"
              .. "<body>\n\t${child}|\n</body>\n"
              .. "</html>",
          },
        },
      }
    end,
  },

  -- Color highlighting
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        filetypes = { "css", "scss", "html", "javascript", "typescript", "vue", "svelte" },
        user_default_options = {
          RGB = true,
          RRGGBB = true,
          names = true,
          RRGGBBAA = true,
          rgb_fn = true,
          hsl_fn = true,
          css = true,
          css_fn = true,
          mode = "background",
        },
      })
    end,
  },

  -- Project management
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        detection_methods = { "lsp", "pattern" },
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pom.xml", "requirements.txt" },
        ignore_lsp = {},
        exclude_dirs = {},
        show_hidden = false,
        silent_chdir = true,
        scope_chdir = 'global',
        datapath = vim.fn.stdpath("data"),
      })
      require('telescope').load_extension('projects')
    end,
  },

  -- ========================================
  -- ADDITIONAL USEFUL PLUGINS
  -- ========================================
  
  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local autopairs = require("nvim-autopairs")
      autopairs.setup({
        check_ts = true,
        ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
          java = false,
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = [=[[%'%"%)%>%]%)%}%,]]=],
          offset = 0,
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "PmenuSel",
          highlight_grey = "LineNr",
        },
      })
      
      -- Integration with nvim-cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  
  -- Comments
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },
  
  -- Buffer management
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          separator_style = "slant",
          always_show_bufferline = true,
          show_buffer_close_icons = false,
          show_close_icon = false,
          color_icons = true,
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
          custom_filter = function(buf_number, buf_numbers)
            if vim.bo[buf_number].filetype ~= "oil" then
              return true
            end
          end,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "left",
              separator = true,
            },
          },
        },
      })
    end,
  },
  
  -- Terminal integration
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        auto_scroll = true,
        float_opts = {
          border = "curved",
          width = function()
            return math.floor(vim.o.columns * 0.8)
          end,
          height = function()
            return math.floor(vim.o.lines * 0.8)
          end,
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })
      
      -- Custom terminal commands
      function _G.set_terminal_keymaps()
        local opts = {buffer = 0}
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
        vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
      end

      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
      
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end

      local node = Terminal:new({ cmd = "node", hidden = true })

      function _NODE_TOGGLE()
        node:toggle()
      end

      local python = Terminal:new({ cmd = "python", hidden = true })

      function _PYTHON_TOGGLE()
        python:toggle()
      end
    end,
  },
  
  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }
      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      require("ibl").setup({
        indent = {
          highlight = highlight,
          char = "│",
        },
        whitespace = {
          highlight = highlight,
          remove_blankline_trail = false,
        },
        scope = {
          enabled = true,
          show_start = true,
          show_end = true,
          injected_languages = false,
          highlight = highlight,
          priority = 500,
        },
      })

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
  
  -- Notifications
  {
    "rcarriga/nvim-notify",
    config = function()
      local notify = require("notify")
      notify.setup({
        background_colour = "#000000",
        fps = 30,
        icons = {
          DEBUG = "",
          ERROR = "",
          INFO = "",
          TRACE = "✎",
          WARN = ""
        },
        level = 2,
        minimum_width = 50,
        render = "compact",
        stages = "fade_in_slide_out",
        time_formats = {
          notification = "%T",
          notification_history = "%FT%T"
        },
        timeout = 3000,
        top_down = true
      })
      vim.notify = notify
    end,
  },

  -- Folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      local ufo = require('ufo')
      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      vim.keymap.set('n', 'zR', ufo.openAllFolds)
      vim.keymap.set('n', 'zM', ufo.closeAllFolds)
      vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds)
      vim.keymap.set('n', 'zm', ufo.closeFoldsWith)

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }

      local language_servers = require("lspconfig").util.available_servers()
      for _, ls in ipairs(language_servers) do
        require('lspconfig')[ls].setup({
          capabilities = capabilities
        })
      end

      ufo.setup({
        provider_selector = function(bufnr, filetype, buftype)
          return {'treesitter', 'indent'}
        end
      })
    end,
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          normal = "ys",
          normal_cur = "yss",
          normal_line = "yS",
          normal_cur_line = "ySS",
          visual = "S",
          visual_line = "gS",
          delete = "ds",
          change = "cs",
          change_line = "cS",
        },
      })
    end
  },

  -- Session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
      options = { "buffers", "curdir", "tabpages", "winsize" },
      pre_save = nil,
      save_empty = false,
    },
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
    config = function()
      vim.g.mkdp_browser = ""
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = ""
      vim.g.mkdp_echo_preview_url = 0
      vim.g.mkdp_browserfunc = ""
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = "middle",
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0,
        toc = {}
      }
      vim.g.mkdp_markdown_css = ""
      vim.g.mkdp_highlight_css = ""
      vim.g.mkdp_port = ""
      vim.g.mkdp_page_title = "‹ ${name} ›"
    end,
  },

  -- Tailwind CSS tools
  {
    "luckasRanarison/tailwind-tools.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      document_color = {
        enabled = true,
        kind = "inline",
        inline_symbol = "󰝤 ",
        debounce = 200,
      },
      conceal = {
        enabled = false,
        min_length = nil,
        symbol = "󱏿",
        highlight = {
          fg = "#38BDF8",
        },
      },
    }
  },

  -- Better quickfix
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require('bqf').setup({
        auto_enable = true,
        auto_resize_height = true,
        preview = {
          win_height = 12,
          win_vheight = 12,
          delay_syntax = 80,
          border_chars = {'┃', '┃', '━', '━', '┏', '┓', '┗', '┛', '█'},
          should_preview_cb = function(bufnr, qwinid)
            local ret = true
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            local fsize = vim.fn.getfsize(bufname)
            if fsize > 100 * 1024 then
              ret = false
            end
            return ret
          end
        },
        func_map = {
          drop = 'o',
          openc = 'O',
          split = '<C-s>',
          vsplit = '<C-v>',
          tab = 't',
          tabb = 'T',
          tabc = '<C-t>',
          tabdrop = '',
          ptogglemode = 'z,',
          pscrollup = '<C-b>',
          pscrolldown = '<C-f>',
          pscrollorig = 'zo',
          prevfile = '<C-p>',
          nextfile = '<C-n>',
          prevhist = '<',
          nexthist = '>',
          lastleave = [['"]],
          stoggleup = '<S-Tab>',
          stoggledown = '<Tab>',
          stogglevm = '<Tab>',
          stogglebuf = [['<Tab>]],
          sclear = 'z<Tab>',
          filter = 'zn',
          filterr = 'zN',
          fzffilter = 'zf',
        },
        filter = {
          fzf = {
            action_for = {['ctrl-s'] = 'split', ['ctrl-t'] = 'tab drop'},
            extra_opts = {'--bind', 'ctrl-o:toggle-all', '--delimiter', ' '}
          }
        }
      })
    end
  },
})

-- ============================================================================
-- KEYMAPS
-- ============================================================================

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ========================================
-- GENERAL KEYMAPS
-- ========================================

-- Better up/down
keymap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Clear search highlights
keymap("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Delete single character without copying into register
keymap("n", "x", '"_x', opts)

-- Increment/decrement numbers
keymap("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Better indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Window management
keymap("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Tab management
keymap("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- ========================================
-- PLUGIN KEYMAPS
-- ========================================

-- NvimTree
keymap("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
keymap("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
keymap("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
keymap("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })

-- Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
keymap("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
keymap("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help tags" })
keymap("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "Find marks" })
keymap("n", "<leader>fo", "<cmd>Telescope vim_options<cr>", { desc = "Find vim options" })
keymap("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find keymaps" })
keymap("n", "<leader>ft", "<cmd>Telescope colorscheme<cr>", { desc = "Find colorscheme" })
keymap("n", "<leader>pp", "<cmd>Telescope projects<cr>", { desc = "Find projects" })

-- LSP
keymap("n", "gR", "<cmd>Telescope lsp_references<CR>", { desc = "Show LSP references" })
keymap("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Show LSP definitions" })
keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "Show LSP implementations" })
keymap("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "Show LSP type definitions" })
keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "See available code actions" })
keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename" })
keymap("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Show buffer diagnostics" })
keymap("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
keymap("n", "K", vim.lsp.buf.hover, { desc = "Show documentation for what is under cursor" })
keymap("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" })

-- Debugging
keymap("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "Add breakpoint at line" })
keymap("n", "<leader>dr", "<cmd>DapContinue<CR>", { desc = "Start or continue the debugger" })
keymap("n", "<F5>", "<cmd>DapContinue<CR>", { desc = "Debugger continue" })
keymap("n", "<F10>", "<cmd>DapStepOver<CR>", { desc = "Debugger step over" })
keymap("n", "<F11>", "<cmd>DapStepInto<CR>", { desc = "Debugger step into" })
keymap("n", "<F12>", "<cmd>DapStepOut<CR>", { desc = "Debugger step out" })

-- Trouble
keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "Open/close trouble list" })
keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Open trouble workspace diagnostics" })
keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Open trouble document diagnostics" })
keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { desc = "Open trouble quickfix list" })
keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { desc = "Open trouble location list" })
keymap("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { desc = "Open trouble lsp references" })

-- Buffer management
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<leader>bd", "<cmd>bdelete!<CR>", { desc = "Delete buffer" })
keymap("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap("n", "<leader>bp", "<cmd>bprev<CR>", { desc = "Previous buffer" })

-- Formatting
keymap({ "n", "v" }, "<leader>mp", function()
  require("conform").format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 2000,
  })
end, { desc = "Format file or range (in visual mode)" })

-- Git
keymap("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Git status" })
keymap("n", "<leader>gl", "<cmd>Git log<CR>", { desc = "Git log" })
keymap("n", "<leader>gp", "<cmd>Git push<CR>", { desc = "Git push" })
keymap("n", "<leader>gP", "<cmd>Git pull<CR>", { desc = "Git pull" })
keymap("n", "<leader>gb", "<cmd>Git branch<CR>", { desc = "Git branch" })
keymap("n", "<leader>gB", "<cmd>Git blame<CR>", { desc = "Git blame" })
keymap("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Git diff view" })
keymap("n", "<leader>gD", "<cmd>DiffviewClose<CR>", { desc = "Close Git diff view" })

-- Gitsigns
keymap("n", "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", { desc = "Next Hunk" })
keymap("n", "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", { desc = "Prev Hunk" })
keymap("n", "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", { desc = "Blame" })
keymap("n", "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", { desc = "Preview Hunk" })
keymap("n", "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", { desc = "Reset Hunk" })
keymap("n", "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", { desc = "Reset Buffer" })
keymap("n", "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", { desc = "Stage Hunk" })
keymap("n", "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", { desc = "Undo Stage Hunk" })

-- Terminal
keymap("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Float terminal" })
keymap("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "Horizontal terminal" })
keymap("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "Vertical terminal" })
keymap("n", "<leader>tn", "<cmd>lua _NODE_TOGGLE()<cr>", { desc = "Node terminal" })
keymap("n", "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<cr>", { desc = "Python terminal" })
keymap("n", "<leader>tg", "<cmd>lua _LAZYGIT_TOGGLE()<cr>", { desc = "Lazygit terminal" })

-- Live server
keymap("n", "<leader>ls", "<cmd>Bracey<cr>", { desc = "Start live server" })
keymap("n", "<leader>lS", "<cmd>BraceyStop<cr>", { desc = "Stop live server" })
keymap("n", "<leader>lr", "<cmd>BraceyReload<cr>", { desc = "Reload live server" })

-- REST client
keymap("n", "<leader>rr", "<Plug>RestNvim", { desc = "Run REST request" })
keymap("n", "<leader>rp", "<Plug>RestNvimPreview", { desc = "Preview REST request" })
keymap("n", "<leader>rl", "<Plug>RestNvimLast", { desc = "Run last REST request" })

-- Database
keymap("n", "<leader>du", "<cmd>DBUIToggle<cr>", { desc = "Database UI toggle" })
keymap("n", "<leader>df", "<cmd>DBUIFindBuffer<cr>", { desc = "Database find buffer" })
keymap("n", "<leader>dr", "<cmd>DBUIRenameBuffer<cr>", { desc = "Database rename buffer" })
keymap("n", "<leader>dl", "<cmd>DBUILastQueryInfo<cr>", { desc = "Database last query info" })

-- Package info
keymap("n", "<leader>ns", "<cmd>lua require('package-info').show()<cr>", { desc = "Show dependency versions" })
keymap("n", "<leader>nc", "<cmd>lua require('package-info').hide()<cr>", { desc = "Hide dependency versions" })
keymap("n", "<leader>nt", "<cmd>lua require('package-info').toggle()<cr>", { desc = "Toggle dependency versions" })
keymap("n", "<leader>nu", "<cmd>lua require('package-info').update()<cr>", { desc = "Update dependency on the line" })
keymap("n", "<leader>nd", "<cmd>lua require('package-info').delete()<cr>", { desc = "Delete dependency on the line" })
keymap("n", "<leader>ni", "<cmd>lua require('package-info').install()<cr>", { desc = "Install a new dependency" })
keymap("n", "<leader>np", "<cmd>lua require('package-info').change_version()<cr>", { desc = "Install a different dependency version" })

-- Sessions
keymap("n", "<leader>qs", function() require("persistence").load() end, { desc = "Restore Session" })
keymap("n", "<leader>ql", function() require("persistence").load({ last = true }) end, { desc = "Restore Last Session" })
keymap("n", "<leader>qd", function() require("persistence").stop() end, { desc = "Don't Save Current Session" })

-- Markdown preview
keymap("n", "<leader>md", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Markdown preview toggle" })

-- ============================================================================
-- AUTO COMMANDS
-- ============================================================================

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Auto resize panes when window is resized
vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

-- Close certain filetypes with q
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "qf",
    "help",
    "man",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Auto create dir when saving a file where some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Disable autoformat for certain filetypes
local disable_autoformat_filetypes = { "sql", "java" }
vim.api.nvim_create_autocmd("FileType", {
  pattern = disable_autoformat_filetypes,
  callback = function()
    vim.b.disable_autoformat = true
  end,
})

-- Set up custom filetypes
vim.filetype.add({
  extension = {
    env = "dotenv",
    conf = "conf",
    mdx = "markdown",
  },
  filename = {
    [".env"] = "dotenv",
    [".env.local"] = "dotenv",
    [".env.example"] = "dotenv",
  },
  pattern = {
    ["%.env%.[%w_.-]+"] = "dotenv",
  },
})

-- ============================================================================
-- DIAGNOSTIC CONFIGURATION
-- ============================================================================
local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "󰌶" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = {
    enabled = true,
    source = "if_many",
    prefix = "●",
  },
  signs = {
    active = signs,
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- ============================================================================
-- LSP HANDLERS
-- ============================================================================
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

-- ============================================================================
-- STARTUP MESSAGE
-- ============================================================================
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 and vim.fn.line2byte("$") == -1 then
      return
    end
    vim.defer_fn(function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      vim.notify("🚀 Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms", "info", { title = "Welcome to Full-Stack Neovim!" })
    end, 100)
  end,
})

-- ============================================================================
-- PERFORMANCE OPTIMIZATIONS
-- ============================================================================
-- Improve startup time
vim.loader.enable()

-- Improve scrolling performance
vim.opt.lazyredraw = true
vim.opt.regexpengine = 1
vim.opt.synmaxcol = 240

-- Improve search performance
vim.opt.maxmempattern = 20000

-- ============================================================================
-- CUSTOM COMMANDS
-- ============================================================================

-- Quick way to reload config
vim.api.nvim_create_user_command("ReloadConfig", function()
  for name,_ in pairs(package.loaded) do
    if name:match('^cnf') then
      package.loaded[name] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
  vim.notify("Configuration reloaded!", "info", { title = "Neovim" })
end, {})

-- Better grep command
vim.api.nvim_create_user_command("Grep", function(opts)
  local query = table.concat(opts.fargs, " ")
  require("telescope.builtin").grep_string({ search = query })
end, { nargs = "+", desc = "Grep for a string" })

-- Toggle background
vim.api.nvim_create_user_command("ToggleBg", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end, { desc = "Toggle background between dark and light" })

-- Format on save toggle
vim.api.nvim_create_user_command("ToggleFormatOnSave", function()
  if vim.g.disable_autoformat then
    vim.g.disable_autoformat = false
    vim.notify("Format on save enabled", "info")
  else
    vim.g.disable_autoformat = true
    vim.notify("Format on save disabled", "warn")
  end
end, { desc = "Toggle format on save" })

-- Clean empty buffers
vim.api.nvim_create_user_command("BufClean", function()
  local bufs = vim.api.nvim_list_bufs()
  for _, buf in ipairs(bufs) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_name(buf) == "" then
      if vim.api.nvim_get_option_value("modified", { buf = buf }) == false then
        vim.api.nvim_buf_delete(buf, {})
      end
    end
  end
  vim.notify("Empty buffers cleaned", "info")
end, { desc = "Clean empty buffers" })

-- ============================================================================
-- WHICH-KEY MAPPINGS
-- ============================================================================
local wk = require("which-key")

wk.register({
  ["<leader>"] = {
    f = {
      name = " Find",
      f = { "<cmd>Telescope find_files<cr>", "Find Files" },
      r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
      s = { "<cmd>Telescope live_grep<cr>", "Find String" },
      c = { "<cmd>Telescope grep_string<cr>", "Find String Under Cursor" },
      b = { "<cmd>Telescope buffers<cr>", "Find Buffers" },
      h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
      m = { "<cmd>Telescope marks<cr>", "Find Marks" },
      k = { "<cmd>Telescope keymaps<cr>", "Find Keymaps" },
      t = { "<cmd>Telescope colorscheme<cr>", "Find Colorscheme" },
    },
    e = {
      name = " Explorer",
      e = { "<cmd>NvimTreeToggle<cr>", "Toggle Explorer" },
      f = { "<cmd>NvimTreeFindFileToggle<cr>", "Find File in Explorer" },
      c = { "<cmd>NvimTreeCollapse<cr>", "Collapse Explorer" },
      r = { "<cmd>NvimTreeRefresh<cr>", "Refresh Explorer" },
    },
    b = {
      name = " Buffer",
      d = { "<cmd>bdelete!<cr>", "Delete Buffer" },
      n = { "<cmd>bnext<cr>", "Next Buffer" },
      p = { "<cmd>bprev<cr>", "Previous Buffer" },
      f = { "<cmd>Telescope buffers<cr>", "Find Buffer" },
    },
    d = {
      name = " Debug",
      b = { "<cmd>DapToggleBreakpoint<cr>", "Toggle Breakpoint" },
      r = { "<cmd>DapContinue<cr>", "Continue/Start" },
      s = { "<cmd>DapStepOver<cr>", "Step Over" },
      i = { "<cmd>DapStepInto<cr>", "Step Into" },
      o = { "<cmd>DapStepOut<cr>", "Step Out" },
      u = { "<cmd>DapUiToggle<cr>", "Toggle UI" },
    },
    g = {
      name = " Git",
      s = { "<cmd>Git<cr>", "Git Status" },
      l = { "<cmd>Git log<cr>", "Git Log" },
      p = { "<cmd>Git push<cr>", "Git Push" },
      P = { "<cmd>Git pull<cr>", "Git Pull" },
      b = { "<cmd>Git branch<cr>", "Git Branch" },
      B = { "<cmd>Git blame<cr>", "Git Blame" },
      d = { "<cmd>DiffviewOpen<cr>", "Diff View" },
      D = { "<cmd>DiffviewClose<cr>", "Close Diff View" },
      j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
      k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
      r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
      R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    },
    l = {
      name = " LSP/Live Server",
      r = { vim.lsp.buf.rename, "Rename" },
      a = { vim.lsp.buf.code_action, "Code Action" },
      d = { vim.diagnostic.open_float, "Line Diagnostics" },
      i = { "<cmd>LspInfo<cr>", "LSP Info" },
      s = { "<cmd>Bracey<cr>", "Start Live Server" },
      S = { "<cmd>BraceyStop<cr>", "Stop Live Server" },
    },
    m = {
      name = " Misc",
      p = { 
        function()
          require("conform").format({
            lsp_fallback = true,
            async = false,
            timeout_ms = 2000,
          })
        end, 
        "Format" 
      },
      d = { "<cmd>MarkdownPreviewToggle<cr>", "Markdown Preview" },
    },
    n = {
      name = " NPM/Node",
      s = { "<cmd>lua require('package-info').show()<cr>", "Show Versions" },
      c = { "<cmd>lua require('package-info').hide()<cr>", "Hide Versions" },
      t = { "<cmd>lua require('package-info').toggle()<cr>", "Toggle Versions" },
      u = { "<cmd>lua require('package-info').update()<cr>", "Update Package" },
      d = { "<cmd>lua require('package-info').delete()<cr>", "Delete Package" },
      i = { "<cmd>lua require('package-info').install()<cr>", "Install Package" },
    },
    p = {
      name = " Project",
      p = { "<cmd>Telescope projects<cr>", "Find Project" },
    },
    q = {
      name = " Session",
      s = { function() require("persistence").load() end, "Restore Session" },
      l = { function() require("persistence").load({ last = true }) end, "Restore Last Session" },
      d = { function() require("persistence").stop() end, "Don't Save Current Session" },
    },
    r = {
      name = " REST/Replace",
      r = { "<Plug>RestNvim", "Run REST Request" },
      p = { "<Plug>RestNvimPreview", "Preview REST Request" },
      l = { "<Plug>RestNvimLast", "Run Last REST Request" },
      n = { vim.lsp.buf.rename, "Rename Symbol" },
      s = { ":LspRestart<cr>", "Restart LSP" },
    },
    s = {
      name = " Split/Search",
      v = { "<C-w>v", "Split Vertically" },
      h = { "<C-w>s", "Split Horizontally" },
      e = { "<C-w>=", "Make Splits Equal" },
      x = { "<cmd>close<cr>", "Close Split" },
    },
    t = {
      name = " Terminal/Tab",
      f = { "<cmd>ToggleTerm direction=float<cr>", "Float Terminal" },
      h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal Terminal" },
      v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical Terminal" },
      n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node Terminal" },
      p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python Terminal" },
      g = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", "Lazygit Terminal" },
      o = { "<cmd>tabnew<cr>", "Open New Tab" },
      x = { "<cmd>tabclose<cr>", "Close Tab" },
      ["["] = { "<cmd>tabprev<cr>", "Previous Tab" },
      ["]"] = { "<cmd>tabnext<cr>", "Next Tab" },
    },
    w = {
      name = " Window",
      h = { "<C-w>h", "Go to Left Window" },
      j = { "<C-w>j", "Go to Down Window" },
      k = { "<C-w>k", "Go to Up Window" },
      l = { "<C-w>l", "Go to Right Window" },
    },
    x = {
      name = " Trouble",
      x = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
      w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
      d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
      q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
      l = { "<cmd>TroubleToggle loclist<cr>", "Location List" },
    },
  },
})

-- ============================================================================
-- FINAL CONFIGURATION NOTES
-- ============================================================================
-- This configuration includes:
-- 
-- ✅ Modern colorscheme (Catppuccin)
-- ✅ Advanced file explorer (NvimTree)
-- ✅ Powerful fuzzy finder (Telescope)
-- ✅ LSP support for all major web technologies
-- ✅ Auto-completion with snippets
-- ✅ Debugging support (DAP)
-- ✅ Git integration (Fugitive, Gitsigns, Diffview)
-- ✅ Formatting and linting
-- ✅ Live server for web development
-- ✅ REST client for API testing
-- ✅ Database integration
-- ✅ Package.json management
-- ✅ Terminal integration
-- ✅ Project management
-- ✅ Session management
-- ✅ Markdown preview
-- ✅ Advanced syntax highlighting
-- ✅ Proper keybindings with which-key
-- ✅ Error handling and diagnostics
-- ✅ Performance optimizations
-- 
-- Installation instructions:
-- 1. Backup your existing Neovim configuration
-- 2. Place this file as ~/.config/nvim/init.lua
-- 3. Start Neovim and run :Lazy install
-- 4. Install required external tools:
--    - ripgrep (for telescope)
--    - fd (for telescope)
--    - node.js and npm (for web development)
--    - python and pip (for python development)
--    - git (for version control)
--
-- Enjoy your full-stack web development experience! 🚀