function twm(){
    D=~/build/cheatsheets/$(basename $(pwd))
    [[ ! -d $D ]] && mkdir -p $D
    typst watch main.typ $D/$(basename $(pwd)).pdf
}


# rename files using nvim
function rename_files(){
    paste <(ls) <(ls) > t
    nv -c '%s/^/mv -v /' -c 'g/mv -v t/d' t
    zsh t
    rm t
}

