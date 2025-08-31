--[[
  Useful things:
    - [Lua crash course]      https://learnxinyminutes.com/docs/lua/
    - [Lua-nvim guide]        :help lua-guide
    - [Lua-nvim guide (HTML)] https://neovim.io/doc/user/lua-guide.html
    - [nvim tutorial]         :Tutor
    - [nvim help]             :help
    - [Telescope search help] <space>sh
    - [Kickstart healtcheck]  :checkhealth
    - [Check plugins status]  :Lazy
    - [Update plugins]        :Lazy update
--]]

-- Core options
require 'custom.options'

-- Core keymappings
require 'custom.mappings'

-- Core autocommands
require 'custom.autocmd'

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
  --
  -- Alternatively, use `config = function() ... end` for full control over the configuration.
  -- For example, see custom.plugins.gitsigns.lua.
  -- If you prefer to call `setup` explicitly, use:
  --    { 'lewis6991/gitsigns.nvim',
  --        config = function()
  --            require('gitsigns').setup({
  --                -- Your gitsigns configuration here
  --            })
  --        end,
  --    }
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  -- Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, see which-key configuration (custom.plugins.which-key.lua):
  --  event = 'VimEnter'
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  -- Detect tabstop and shiftwidth automatically
  require 'custom.plugins.guess-indent',

  -- Adds git related signs to the gutter, as well as utilities for managing changes
  require 'custom.plugins.gitsigns',

  -- Show you pending keybinds
  require 'custom.plugins.which-key',

  -- Fuzzy Finder (files, lsp, etc)
  require 'custom.plugins.telescope',

  -- LSP plugins
  require 'custom.plugins.lazydev',
  require 'custom.plugins.lspconfig',

  -- Autoformat
  require 'custom.plugins.conform',

  -- Autocompletion
  require 'custom.plugins.blink-cmp',

  -- Theme
  require 'custom.plugins.theme',

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  -- Collection of various small independent plugins/modules
  require 'custom.plugins.mini',

  -- Highlight, edit, and navigate code
  require 'custom.plugins.treesitter',

  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',

  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
