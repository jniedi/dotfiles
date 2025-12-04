function twm(){
    D=~/build/cheatsheets/$(basename $(pwd))
    [[ ! -d $D ]] && mkdir -p $D
    typst watch main.typ $D/$(basename $(pwd)).pdf
}
