local util = require "util"

require("harpoon").setup {}

-- TODO add which key

util.nnoremap("<leader>a", '<cmd>lua require("harpoon.mark").add_file()<CR>')
util.nnoremap("<C-e>", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>')

util.nnoremap("<C-b>", '<cmd>lua require("harpoon.ui").nav_file(1)<CR>')
util.nnoremap("<C-n>", '<cmd>lua require("harpoon.ui").nav_file(2)<CR>')
util.nnoremap("<C-m>", '<cmd>lua require("harpoon.ui").nav_file(3)<CR>')
