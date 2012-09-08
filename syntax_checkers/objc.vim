" For this to work, you will need Apple's XCode command-line tools installed.
" See Xcode->Preferences->Downloads.
"
" You make want to set something like:
" let g:syntastic_objc_options = "-scheme <Scheme Name> -configuration Debug"
"
" For best results your current directory should be the project root.
if exists("loaded_objc_syntax_checker")
    finish
endif
let loaded_objc_syntax_checker = 1

"bail if the user doesnt have xcodebuild on the path.
if !executable("xcodebuild")
    finish
endif

if !exists("g:syntastic_objc_options")
    let g:syntastic_objc_options = ""
endif

function! SyntaxCheckers_objc_GetLocList()
    let makeprg = 'xcodebuild '. g:syntastic_objc_options

    let errorformat = '%f:%l:%c:\ note:%m'
    let errorformat .= ',%f:%l:%c:\ %t%\\S%#:%m'
    let errorformat .= ',%-G%.%#'
    return SyntasticMake({ 'makeprg': makeprg,
                         \ 'errorformat': errorformat,
                         \ 'defaults': {'bufnr': bufnr(""), 'text': "Syntax error"} })
endfunction
