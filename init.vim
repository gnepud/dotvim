" Neovim entry point: options first, then plugins and editor behavior.
let s:config_dir = stdpath('config')
execute 'source' fnameescape(s:config_dir . '/config/options.vim')
lua require('dotvim.lazy')
execute 'source' fnameescape(s:config_dir . '/config/commands.vim')
execute 'source' fnameescape(s:config_dir . '/config/keymaps.vim')
execute 'source' fnameescape(s:config_dir . '/config/statusline.vim')
execute 'source' fnameescape(s:config_dir . '/config/autocmds.vim')
