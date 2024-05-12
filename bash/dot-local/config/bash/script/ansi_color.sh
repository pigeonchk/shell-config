#!/bin/bash

# vim:foldmethod=marker:foldlevel=0

#[ "${ANSI_F_256COLOR}" ] && return

# {{{ COLORS

# {{{ BLACK

declare -A _BLACK=(
    [black_0]=0         [black]=16
    [vampire_black]=232 [chinese_black]=233
    [eerie_black]=234   [raisin_black]=235
    [dark_charcoal]=236 [black_olive|mines_shaft]=237
    [outer_space]=238   [dark_liver|tundora]=239
)

# }}} BLACK

# {{{ GRAY

declare -A _GRAY=(
    [argent]=7                       [gray|light_black]=8
    [scorpion]=59                    [taupe_gray]=102
    [silver_foil]=145                [light_silver]=188
    [davys_grey]=240                 [granite_gray|very_dark_gray]=241
    [dim_gray|dove_gray]=242         [boulder|sonic_silver]=243
    [gray|light_back]=244            [philippine_gray]=245
    [dusty_gray]=246                 [spanish_grey]=247
    [dark_gray|quick_silver]=248     [philippine_silver|silver_chalice]=249
    [silver]=250                     [silver_sand]=251
    [american_silver|light_gray]=252 [alto|gainsboro]=253
    [mercury|platinum]=254           [bright_gray|gallery|very_light_gray]=255
)

# }}} GRAY

# {{{ RED

declare -A _RED=(
    [maroon]=1
    [light_red_9|red]=9
    [blood_red|rosewood|very_dark_red]=52
    [deep_red]=88
    [bright_red|dark_candy_apple_red|dark_red]=124
    [dark_pink|jazzbery_jam]=125
    [dark_moderate_pink|tapestry|turkish_rose]=132
    [guardsman_red|rosso_corsa|strong_red]=160
    [razzmatazz|royal_red]=161
    [indian_red|moderate_red|roman]=167
    [blush|cranberry|mystic_pearl]=168
    [light_red|red]=196
    [vivid_raspberry|winter_sky]=197
    [bittersweet|pastel_red]=203
    [strawberry|wild_watermelon]=204
    [tulip|very_light_red|vivid_tangerine]=210
)

# }}} RED

# {{{ GREEN
declare -A _GREEN=(
    [office_green]=2
    [yellow_3]=3
    [electric_green|green|light_green_10]=10
    [camarone|very_dark_lime_green]=22
    [bangladesh_green|blue_stone|dark_slate_gray|very_dark_cyan]=23
    [ao]=28
    [deep_sea|spanish_viridian]=29
    [dark_lime_green|islamic_green|japanese_laurel]=34
    [go_green|jade]=35
    [dark_cyan|persian_green]=36
    [strong_lime_green]=40
    [malachite]=41
    [carriibean_green_42]=42
    [carriibean_green|strong_cyan]=43
    [electric_green|green|light_green]=46
    [spring_green_47]=47
    [guppie_green]=48
    [medium_spring_green|spring_green]=49
    [bright_turquoise|pure_cyan|sea_green]=50
    [bronze_yellow|verdun_green|very_dark_yellow_olive_tone]=58
    [avocado]=64
    [glade_green|mostly_desaturated_dark_lime_green|russian_green]=65
    [dark_green|kelly_green]=70
    [dark_moderate_lime_green|fern|forest_green]=71
    [polished_pine|silver_tree]=72
    [alien_armpit|harlequin_green|strong_green]=76
    [moderate_lime_green]=77
    [carriibean_green_pearl]=78 [downy|eucalyptus]=79
    [bright_green]=82
    [light_lime_green]=83
    [very_light_malachite_green]=84
    [medium_aquamarire]=85
    [dark_yellow_olive_tone|olive]=100
    [clay_creek|mostly_desaturated_dark_yellow|shadow]=101
    [apple_green|limeade]=106
    [asparagus|chelsea_cucumber|dark_moderate_green]=107
    [bay_leaf|dark_grayish_lime_green|dark_sea_green]=108
    [pistachio]=112
    [mantis]=113
    [pastel_green|slightly_desaturated_lime_green]=114
    [cartreuse|pure_green]=118
    [light_green|screamin_green]=119
    [very_light_lime_green]=120
    [mint_green_121]=121
    [dark_moderate_yellow|olive_green]=143
    [rio_grande|sheen_green|vivid_lime_green]=148
    [conifer|june_bud|moderate_green]=149
    [feijoa|slightly_desaturated_green|yellow_green]=150
    [grayish_lime_green|light_moss_green|pixie_green]=151
    [lime|spring_bud]=154
    [green_yellow|inchworm]=155
    [mint_green|very_light_green]=156
    [menthol|pale_lime_green]=157
    [grayish_yellow|green_mist|pastel_gray]=187
    [pale_green|reef|tea_green]=193
    [beige|nyanza|snowy_mint|very_pale_lime_green]=194
)

# }}} GREEN

# {{{ YELLOW

declare -A _YELLOW=(
    [light_yellow_11|yellow]=11
    [citrine|corn|strong_yellow]=184
    [chinese_green|moderate_yellow|tacha]=185
    [deco|medium_spring_bud|slightly_desaturated_yellow]=186
    [chartreuse_yellow|pure_yellow]=190
    [canary|maximum_green_yellow]=191
    [honeysuckle|mindaro]=192
    [gold]=220
    [dandelion|naples_yellow]=221
    [light_yellow|yellow]=226
    [laser_lemon|light_yellow]=227
    [dolly|pastel_yellow|very_light_yellow]=228
    [calamansi|pale_yellow|portafino]=229
    [cream|cumulus|very_pale_yellow]=230
)

# }}} YELLOW

# {{{ BLUE

declare -A _BLUE=(
    [blue_4]=4
    [blue|light_blue_12]=12
    [fuzzy_wuzzy|stratos|very_dark_blue]=17
    [dark_blue|navy_blue]=18
    [carnation_pink|duke_blue]=19
    [medium_blue]=20
    [blue|light_blue]=21
    [orient|sea_blue]=24
    [endeavour|medium_persian_blue]=25
    [science_blue|true_blue]=26
    [blue_ribbon|brandeis_blue]=27
    [deep_cerulean]=31
    [blue_cola|lochmara|strong_blue]=32
    [azure|azure_radiance|pure_blue]=33
    [cerulean]=38
    [blue_bolt|deep_sky_blue]=39
    [vivid_sky_blue]=45
    [comet|mostly_desaturated_dark_blue|ucla_blue]=60
    [dark_moderate_blue|liberty|scampi]=61
    [indigo|slate_blue]=62
    [cornflower_blue]=63
    [hippie_blue|rackley|steel_blue]=67
    [havelock_blue|moderate_blue|united_nations_blue]=68
    [blueberry|light_blue]=69
    [crystal_blue|dark_moderate_cyan|tradewind]=73
    [aqua_pearl|carolina_blue|shakespeare]=74
    [blue_jeans]=75
    [maya_blue]=81
    [cool_grey|dark_grayish_blue|shadow_blue]=103
    [chetwode_blue|ube]=104
    [violets_are_blue]=105
    [light_cobalt_blue|polo_blue|slightly_desaturated_blue]=110
    [french_sky_blue|malibu]=111
    [grayish_blue|wild_blue_yonder|wistful]=146
    [maximum_blue_purple]=147
    [fresh_air|pale_blue]=153
    [fog|pale_lavender|very_pale_blue]=189
)

# }}} BLUE

# {{{ PURPLE/VIOLET/MAGENTA

declare -A _MAGENTA=(
    [patriarch]=5
    [imperial_purple|pompadour|very_dark_magenta]=53
    [metallic_violet|pigment_indigo]=54
    [chinese_purple|dark_violet]=55
    [electric_violet_56]=56
    [electric_indigo]=57
    [french_plum]=89
    [fresh_eggplant|mardy_gras]=90
    [purple|violet]=91
    [french_violet|strong_violet]=92
    [electric_violet|pure_violet]=93
    [chinese_violet|mostly_desaturated_dark_magenta|strikemaster]=96
    [dark_moderate_violet|deluge|royal_purple]=97
    [medium_purple|moderate_violet]=98
    [blueberry_99]=99
    [dark_magenta|flirt]=126
    [heliotrope_magenta]=127
    [vivid_mulberry]=128
    [electric_purple]=129
    [dark_moderate_magenta|pearly_purple]=133
    [rich_lilac]=134
    [lavender_indigo|light_violet]=135
    [bouquet|dark_grayish_magenta|opera_mauve]=139
    [lavender|slightly_desaturated_violet]=140
    [bright_lavender]=141
    [deep_magenta|strong_magenta]=164
    [phlox]=165
    [moderate_magenta|orchid]=170
    [mauve|pale_violet]=183
)

# }}} PURPLE/VIOLET/MAGENTA

# {{{ CYAN

declare -A _CYAN=(
    [cyan_6]=6
    [aqua|cyan|light_cyan_14]=14
    [teal]=30
    [bondi_blue|tiffany_blue]=37
    [dark_turquoise|robins_egg_blue]=44
    [aqua|cyan|light_cyan]=51
    [juniper|mostly_desaturated_dark_cyan|steel_teal]=66
    [medium_turquoise|moderate_cyan|viking]=80
    [aquamarine_86]=86
    [aquamarine_87]=87
    [dark_grayish_cyan|gulf_stream|pewter_blue]=109
    [pearl_aqua|vista_blue]=115
    [bermuda|middle_blue_green|slightly_desaturated_cyan]=116
    [pale_cyan|very_light_blue]=117
    [aquamarine|lime_green]=122
    [anakiwa|electric_blue|very_light_cyan]=123
    [crystal|grayish_cyan|jungle_mist]=152
    [aero_blue|magic_mint]=158
    [celeste|french_pass]=159
    [light_cyan|oyster_bay|very_pale_cyan]=195
)

# }}} CYAN

# {{{ WHITE

declare -A _WHITE=(
    [light_white_15|white]=15
    [light_white|white]=231
)

# }}} WHITE

# {{{ PINK

declare -A _PINK=(
    [fuchsia|light_magenta_13|magenta]=13
    [mexican_pink|strong_pink]=162
    [hollywood_cerise_163]=163
    [hopbush|moderate_pink|super_pink]=169
    [heliotrope|light_magenta]=171
    [my_pink|new_york_pink|slightly_desaturated_red]=174
    [can_can|middle_purple|slightly_desaturated_pink]=175
    [deep_mauve|light_orchid|slightly_desaturated_magenta]=176
    [bright_lilac|very_light_violent]=177
    [grayish_magenta|pink_lavender|thistle]=182
    [bright_pink|rose]=198
    [fashion_fuchsia|hollywood_cerise||pure_pink]=199
    [pure_magenta]=200
    [fuchsia|light_magenta_13|mangenta]=201
    [hot_pink|light_pink]=205
    [light_deep_pink|purple_pizzazz]=206
    [pink_flamingo|shocking_pink]=207
    [pink_salmon|tickle_me_pink]=211
    [lavender_rose|princess_perfume|very_light_pink]=212
    [blush_pink|fuchsia_pink|very_light_magenta]=213
    [cotton_candy|lavender_pink|pale_pink]=218
    [pale_magenta|rich_brilliant_lavender|shampoo]=219
    [cosmos|misty_rose|very_pale_red_pink_tone]=224
    [bubble_gum|pink_lace|very_pale_magenta]=225
)

# }}} PINK

# {{{ ORANGE

declare -A _ORANGE=(
    [strong_orange|tenn]=166
    [blaze_orange|orange_red|vivid_orange]=202
    [american_orange|dark_orange|flush_orange]=208
    [coral|salmon]=209
    [chinese_yellow|orange|pure_orange|yellow_sea]=214
    [light_orange|rajah|texas_rose]=215
    [hit_pink|macaroni_and_cheese|very_light_orange]=216
    [melon|pale_red_pink_tone|sundown]=217
)

# }}} ORANGE

# {{{ BROWN

declare -A _BROWN=(
    [brown|gamboge_orange]=94
    [copper_rose|deep_taupe|mostly_desaturated_dark_red]=95
    [dark_orange_brown_tone|rose_of_sharon|windsor_tan]=130
    [dark_moderate_red|electric_brown|matrix]=131
    [dark_goldenrod|pirate_gold]=136
    [bronze|dark_moderate_orange|muesli]=137
    [dark_grayish_red|english_lavender|pharlap]=138
    [buddha_gold|light_gold]=142
    [dark_grayish_yellow|hillary|sage]=144
    [chocolate|harvest_gold|mango_tango]=172
    [copperfield|raw_sienna]=173
    [goldenrod|mustard_yellow]=178
    [earth_yellow|moderate_orange]=179
    [slightly_desaturated_orange|tan]=180
    [clam_shell|grayish_red|pale_chestnut]=181
    [grandis|jasmine|khaki]=222
    [caramel|moccasin|pale_orange]=223
)

# }}} BROWN

# }}} COLORS

# {{{ ANSI_F_256COLOR

declare -Ax ANSI_F_256COLOR=()
declare -Ax ANSI_B_256COLOR=()

declare -Ax ANSI_256COLOR=()

insert_color() {
    local group="$1"
    local -n array=$2

    for color in "${!array[@]}"; do
        local -i n="${array[$color]}"
        local bg="$(tput setab $n)"
        local fg="$(tput setaf $n)"
        ANSI_F_256COLOR["${group}_$n"]="$fg"
        ANSI_B_256COLOR["${group}_$n"]="$bg"

        ANSI_256COLOR[$n]="${group}_$n|$color"

        for name in ${color//|/ }; do
            [ "${ANSI_F_256COLOR[$name]}" ] && continue
            ANSI_F_256COLOR["$name"]="$fg"
            ANSI_B_256COLOR["$name"]="$bg"
        done
    done
}

insert_color black   _BLACK
insert_color gray    _GRAY
insert_color red     _RED
insert_color green   _GREEN
insert_color yellow  _YELLOW
insert_color blue    _BLUE
insert_color purple  _MAGENTA
insert_color violet  _MAGENTA
insert_color magenta _MAGENTA
insert_color cyan    _CYAN
insert_color white   _WHITE
insert_color pink    _PINK
insert_color orange  _ORANGE
insert_color brown   _BROWN

# }}} ANSI_F_256COLOR

for ((i = 0; i < 256; i++)); do
    color_name="${ANSI_256COLOR[$i]}"
    if [ ! "$color_name" ]; then
        command printf "missing color #%s\n" "$i" >&2
        continue
    fi

    s=""
    for name in ${color_name//|/ }; do
        fg_color="$(tput setaf 231)"
        [ "${_WHITE[$name]}" ] && fg_color="$(tput setaf 0)"
        s="$s${ANSI_B_256COLOR[$name]} $fg_color$name $(tput sgr0)"
    done

    printf "%b %.3d $(tput sgr0)%b$(tput sgr0)\n" "$(tput setab $i)" "$i" "$s"
done

unset color_name

unset insert_color _BLACK _GRAY  _RED  _GREEN  _YELLOW _BLUE \
      _MAGENTA     _CYAN  _WHITE _PINK _ORANGE _BROWN

