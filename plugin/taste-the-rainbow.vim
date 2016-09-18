let s:save_cpo = &cpo
set cpo&vim

let g:rainbow_brackets = [['(', ')'], ['\[', '\]'], ['{', '}']]
let g:rainbow_colors = ['#FF8700', '#AF0000', '#5FFFD7', '#8700D7', '#005F00', '#D7FF00', '#0087D7', '#CE4287', '#00AF00']

if g:colors_name == 'fight-in-the-shade'
    let g:default_color = ['#5F5F5F']
elseif g:colors_name == 'spartan'
    let g:default_color = ['#8A8A8A']
elseif g:colors_name == 'immortals'
    let g:default_color = ['#444444']
elseif g:colors_name = 'thermopylae'
    let g:default_color = ['#928374']
endif

function! TheRainbow(the_colors)
    for character_pair in g:rainbow_brackets
        for each in range(1, len(a:the_colors))
            execute printf('syntax region paren%s matchgroup=level%s start=/%s/ end=/%s/ contains=ALLBUT,%s',
                      \ string(each),
                      \ string(each),
                      \ character_pair[0],
                      \ character_pair[1],
                      \ join(map(filter(range(1, len(a:the_colors)), each == 1 ? 'v:val != len(a:the_colors)' : 'v:val != each - 1'), '"paren" . v:val'), ','))
        endfor
    endfor
    for each in range(1, len(a:the_colors))
        execute printf('highlight default level%s guifg=%s', string(each), a:the_colors[each - 1])
    endfor
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

command! TasteTheRainbow call TheRainbow(g:rainbow_colors)
command! ChillTheRainbow call TheRainbow(g:default_color)
