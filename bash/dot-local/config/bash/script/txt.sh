#!/bin/bash
# vim:foldmethod=marker:foldlevel=0

# shellcheck disable=2155,1091

. "report.sh"

# {{{ pattern groups

if ! declare -p TXT_GROUPS &>/dev/null; then
    declare -Arx TXT_GROUPS=(
        ['digit']="0123456789"
        ['lower']='abcdefghijklmnopqrstuvwxyz'
        ['upper']='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
        ['greek']='ΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩαβγδεζηθικλμνξοπρςστυφχψωϵ'
        ['separ']=',;-./'
        ['brakt']='(){}[]<>'
        ['mathm']='*/∥-∠+×=><∞⊥'

        ['smlupper']='ᴀʙᴄᴅᴇꜰɢʜɪᴊᴋʟᴍɴᴏᴘꞯʀꜱᴛᴜᴠᴡxʏᴢ'
        ['segdigit']='🯰🯱🯲🯳🯴🯵🯶🯷🯸🯹'

        ['supupper']='󰀀󰀁󰀂󰀃󰀄󰀅󰀆󰀇󰀈󰀉󰀊󰀋󰀌󰀍󰀎󰀏󰀐󰀑󰀒󰀓󰀔󰀕󰀖󰀗󰀘󰀙'
        ['suplower']='󰀚󰀛󰀜󰀝󰀞󰀟󰀠󰀡󰀢󰀣󰀤󰀥󰀦󰀧󰀨󰀩󰀪󰀫󰀬󰀭󰀮󰀯󰀰󰀱󰀲󰀳'
        ['supdigit']='󰁧󰁨󰁩󰁪󰁫󰁬󰁭󰁮󰁯󰁰'
        ['supgreek']='󰀴󰀵󰀶󰀷󰀸󰀹󰀺󰀻󰀼󰀽󰀾󰀿󰁀󰁁󰁂󰁃󰁄󰁅󰁆󰁇󰁈󰁉󰁊󰁋󰁌󰁍󰁎󰁏󰁐󰁑󰁒󰁓󰁔󰁕󰁖󰁗󰁘󰁙󰁚󰁛󰁜󰁝󰁞󰁟󰁠󰁡󰁢󰁣󰁤󰁥'
        ['supsepar']='󰁱󰁲󰁼⸱󰁵'
        ['supbrakt']='󰁶󰁷󰁸󰁹󰁺󰁻󰂂󰂁'
        ['supmathm']='󰁳󰁵󰁴󰁼󰁽󰁾󰁿󰂀󰂁󰂂󰂃󰂅'

        ['subupper']='󰂓󰂔󰂕󰂖󰂗󰂘󰂙󰂚󰂛󰂜󰂝󰂞󰂟󰂠󰂡󰂢󰂣󰂤󰂥󰂦󰂧󰂨󰂩󰂪󰂫󰂬'
        ['sublower']='󰂭󰂮󰂯󰂰󰂱󰂲󰂳󰂴󰂵󰂶󰂸󰂹󰂺󰂻󰂼󰂽󰂾󰂿󰃀󰃁󰃂󰃃󰃄󰃅󰃆󰃇'
        ['subdigit']='󰄄󰄅󰄆󰄇󰄈󰄉󰄊󰄋󰄌󰄍'
        ['subgreek']='󰃌󰃍󰃎󰃏󰃐󰃑󰃒󰃓󰃔󰃕󰃖󰃗󰃘󰃙󰃚󰃛󰃜󰃝󰃞󰃟󰃠󰃡󰃢󰃣󰃤󰃥󰃦󰃧󰃨󰃩󰃪󰃫󰃬󰃭󰃮󰃯󰃰󰃱󰃲󰃳󰃴󰃵󰃶󰃷󰃸󰃹󰃺󰃻󰃼󰃽'
        ['subsepar']='󰄎󰄏󰄙.󰄒'
        ['subbrakt']='󰄓󰄔󰄕󰄖󰄗󰄘󰄟󰄞'
        ['submathm']='󰄐󰄒󰄑󰄙󰄚󰄛󰄜󰄝󰄞󰄟󰄠󰄢'
    )
fi

# }}}

@txt_grps() {
    local -a groups
    IFS='|' read -a groups -r <<<"$1"
    local s

    for group in "${groups[@]}"; do
        if [ ! "${TXT_GROUPS[$group]}" ]; then
            @report 'user' "invalid text group: $group"
            return 1
        fi >&2
        s="$s${TXT_GROUPS[$group]}"
    done

    command printf "%s" "$s"
}

@txt_tr() {
    local pattern1="$(@txt_grps "$1")"
    local pattern2="$(@txt_grps "$2")"

    shift 2
    for arg; do
        command sed -E "y^$pattern1^$pattern2^" <<<"$arg"
    done

    while IFS=$'\n' read -t 0.01 -r line; do
        command sed -E "y^$pattern1^$pattern2^" <<<"$line"
    done
}

@txt_upper() {
    for arg; do
        command printf "%s\n" "${arg@U}"
    done

    while IFS=$'\n' read -t 0.01 -r line; do
        command printf "%s\n" "${line@U}"
    done
}

@txt_inet() {
    local re='s^.*\b(([0-9]{1,3}[./]){4}[0-9]+)\b.*^\1^p'
    for arg; do
        command sed -n -E "$re" <<<"$arg"
    done

    while IFS=$'\n' read -t 0.01 -r line; do
        command sed -n -E "$re" <<<"$line"
    done
}

@txt_rep() {
    command printf "% *s" "$1" | command sed "y^ ^$2^"
}

export -f @txt_tr @txt_grps @txt_upper @txt_inet @txt_rep
