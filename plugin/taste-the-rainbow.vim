" System colors
" 0 1 2  3  4  5  6  7
" 8 9 10 11 12 13 14 15
"
" 6x6x6 color cube
" 16 17 18 19 20 21 |  88 89  90  91  92  93  | 160 161 162 163 164 165
" 22 23 24 25 26 27 |  94 95  96  97  98  99  | 166 167 168 169 170 171
" 28 29 30 31 32 33 | 100 101 102 103 104 105 | 172 173 174 175 176 177
" 34 35 36 37 38 39 | 106 107 108 109 110 111 | 178 179 180 181 182 183
" 40 41 42 43 44 45 | 112 113 114 115 116 117 | 184 185 186 187 188 189
" 46 47 48 49 50 51 | 118 119 120 121 122 123 | 190 191 192 193 194 195
" 82 83 84 85 86 87 | 154 155 156 157 158 159 | 226 227 228 229 230 231
" 76 77 78 79 80 81 | 148 149 150 151 152 153 | 220 221 222 223 224 225
" 70 71 72 73 74 75 | 142 143 144 145 146 147 | 214 215 216 217 218 219
" 64 65 66 67 68 69 | 136 137 138 139 140 141 | 208 209 210 211 212 213
" 58 59 60 61 62 63 | 130 131 132 133 134 135 | 202 203 204 205 206 207
" 52 53 54 55 56 57 | 124 125 126 127 128 129 | 196 197 198 199 200 201
"
"
" Grayscale
" 232 233 234 235 236 237 238 239 240 241 242 243
" 244 245 246 247 248 249 250 251 252 253 254 255 256

let s:save_cpo = &cpo
set cpo&vim

let g:rainbow_brackets = [['(', ')'], ['\[', '\]'], ['{', '}']]
let g:rainbow_colors = [208, 124, 86, 92, 22, 190, 32, 197, 34]

if g:colors_name == 'fight-in-the-shade'
    let g:default_color = [59]
elseif g:colors_name == 'spartan'
    let g:default_color = [245]
elseif g:colors_name == 'immortals'
    let g:default_color = [238]
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
        execute printf('highlight default level%s ctermfg=%s', string(each), a:the_colors[each - 1])
    endfor
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

command! TasteTheRainbow call TheRainbow(g:rainbow_colors)
command! ChillTheRainbow call TheRainbow(g:default_color)
