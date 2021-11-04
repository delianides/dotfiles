local util = require "util"

util.nnoremap("<Leader>sp", "<cmd>lua require('package-info').show()<cr>")
util.nnoremap("<Leader>np", "<cmd>lua require('package-info').change_version()<cr>")
util.nnoremap("<Leader>dp", "<cmd>lua require('package-info').delete()<cr>")
