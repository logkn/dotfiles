--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`

local keymap = vim.keymap
keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Reload config
keymap.set('n', '<leader>r', ':source $MYVIMRC<CR>', { desc = 'Reload config' })

-- Diagnostic keymaps
keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make navigation easier.
--  Use CTRL+<hjkl> to switch between windows
keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- Zoom in on the current window
keymap.set('n', '<leader>wf', '<C-w>o', { desc = '[W]indow [F]ullscreen' })

-- -- <leader>e for nvim-tree
-- keymap.set('n', '<leader>e', '<cmd>NvimTreeFindFileToggle<cr>')

-- buffer navigation
keymap.set('n', '<leader>n', '<cmd>bn<cr>')
keymap.set('n', '<leader>p', '<cmd>bp<cr>')
keymap.set('n', '<leader>x', '<cmd>bd<cr>')

-- buffer operations
keymap.set('n', '<leader>bo', ':%bd|e#|bd#<CR>', { desc = 'Delete other buffers' })

-- Diagnostics
-- go to next diagnostic
keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')

-- Lazy
-- open lazy
keymap.set('n', '<leader>l', '<cmd>Lazy<cr>')

-- save file
keymap.set({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

-- better indenting
keymap.set('v', '<', '<gv')
keymap.set('v', '>', '>gv')
