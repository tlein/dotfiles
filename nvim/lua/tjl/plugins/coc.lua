vim.api.nvim_exec(
    [[
        command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

        function! CheckBackspace() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
    ]],
    true
)
