define-command -docstring %{
  show-color: display selected hex or CSS named color in statusline
} show-color %{ evaluate-commands %sh{
  c=$(printf '%s' "$kak_selection" | tr '[:upper:]' '[:lower:]')

  case "$c" in
    aliceblue)            c="f0f8ff" ;;
    antiquewhite)         c="faebd7" ;;
    aqua)                 c="00ffff" ;;
    aquamarine)           c="7fffd4" ;;
    azure)                c="f0ffff" ;;
    beige)                c="f5f5dc" ;;
    bisque)               c="ffe4c4" ;;
    black)                c="000000" ;;
    blanchedalmond)       c="ffebcd" ;;
    blue)                 c="0000ff" ;;
    blueviolet)           c="8a2be2" ;;
    brown)                c="a52a2a" ;;
    burlywood)            c="deb887" ;;
    cadetblue)            c="5f9ea0" ;;
    chartreuse)           c="7fff00" ;;
    chocolate)            c="d2691e" ;;
    coral)                c="ff7f50" ;;
    cornflowerblue)       c="6495ed" ;;
    cornsilk)             c="fff8dc" ;;
    crimson)              c="dc143c" ;;
    cyan)                 c="00ffff" ;;
    darkblue)             c="00008b" ;;
    darkcyan)             c="008b8b" ;;
    darkgoldenrod)        c="b8860b" ;;
    darkgray)             c="a9a9a9" ;;
    darkgrey)             c="a9a9a9" ;;
    darkgreen)            c="006400" ;;
    darkkhaki)            c="bdb76b" ;;
    darkmagenta)          c="8b008b" ;;
    darkolivegreen)       c="556b2f" ;;
    darkorange)           c="ff8c00" ;;
    darkorchid)           c="9932cc" ;;
    darkred)              c="8b0000" ;;
    darksalmon)           c="e9967a" ;;
    darkseagreen)         c="8fbc8f" ;;
    darkslateblue)        c="483d8b" ;;
    darkslategray)        c="2f4f4f" ;;
    darkslategrey)        c="2f4f4f" ;;
    darkturquoise)        c="00ced1" ;;
    darkviolet)           c="9400d3" ;;
    deeppink)             c="ff1493" ;;
    deepskyblue)          c="00bfff" ;;
    dimgray)              c="696969" ;;
    dimgrey)              c="696969" ;;
    dodgerblue)           c="1e90ff" ;;
    firebrick)            c="b22222" ;;
    floralwhite)          c="fffaf0" ;;
    forestgreen)          c="228b22" ;;
    fuchsia)              c="ff00ff" ;;
    gainsboro)            c="dcdcdc" ;;
    ghostwhite)           c="f8f8ff" ;;
    gold)                 c="ffd700" ;;
    goldenrod)            c="daa520" ;;
    gray)                 c="808080" ;;
    grey)                 c="808080" ;;
    green)                c="008000" ;;
    greenyellow)          c="adff2f" ;;
    honeydew)             c="f0fff0" ;;
    hotpink)              c="ff69b4" ;;
    indianred)            c="cd5c5c" ;;
    indigo)               c="4b0082" ;;
    ivory)                c="fffff0" ;;
    khaki)                c="f0e68c" ;;
    lavender)             c="e6e6fa" ;;
    lavenderblush)        c="fff0f5" ;;
    lawngreen)            c="7cfc00" ;;
    lemonchiffon)         c="fffacd" ;;
    lightblue)            c="add8e6" ;;
    lightcoral)           c="f08080" ;;
    lightcyan)            c="e0ffff" ;;
    lightgoldenrodyellow) c="fafad2" ;;
    lightgray)            c="d3d3d3" ;;
    lightgrey)            c="d3d3d3" ;;
    lightgreen)           c="90ee90" ;;
    lightpink)            c="ffb6c1" ;;
    lightsalmon)          c="ffa07a" ;;
    lightseagreen)        c="20b2aa" ;;
    lightskyblue)         c="87cefa" ;;
    lightslategray)       c="778899" ;;
    lightslategrey)       c="778899" ;;
    lightsteelblue)       c="b0c4de" ;;
    lightyellow)          c="ffffe0" ;;
    lime)                 c="00ff00" ;;
    limegreen)            c="32cd32" ;;
    linen)                c="faf0e6" ;;
    magenta)              c="ff00ff" ;;
    maroon)               c="800000" ;;
    mediumaquamarine)     c="66cdaa" ;;
    mediumblue)           c="0000cd" ;;
    mediumorchid)         c="ba55d3" ;;
    mediumpurple)         c="9370db" ;;
    mediumseagreen)       c="3cb371" ;;
    mediumslateblue)      c="7b68ee" ;;
    mediumspringgreen)    c="00fa9a" ;;
    mediumturquoise)      c="48d1cc" ;;
    mediumvioletred)      c="c71585" ;;
    midnightblue)         c="191970" ;;
    mintcream)            c="f5fffa" ;;
    mistyrose)            c="ffe4e1" ;;
    moccasin)             c="ffe4b5" ;;
    navajowhite)          c="ffdead" ;;
    navy)                 c="000080" ;;
    oldlace)              c="fdf5e6" ;;
    olive)                c="808000" ;;
    olivedrab)            c="6b8e23" ;;
    orange)               c="ffa500" ;;
    orangered)            c="ff4500" ;;
    orchid)               c="da70d6" ;;
    palegoldenrod)        c="eee8aa" ;;
    palegreen)            c="98fb98" ;;
    paleturquoise)        c="afeeee" ;;
    palevioletred)        c="db7093" ;;
    papayawhip)           c="ffefd5" ;;
    peachpuff)            c="ffdab9" ;;
    peru)                 c="cd853f" ;;
    pink)                 c="ffc0cb" ;;
    plum)                 c="dda0dd" ;;
    powderblue)           c="b0e0e6" ;;
    purple)               c="800080" ;;
    rebeccapurple)        c="663399" ;;
    red)                  c="ff0000" ;;
    rosybrown)            c="bc8f8f" ;;
    royalblue)            c="4169e1" ;;
    saddlebrown)          c="8b4513" ;;
    salmon)               c="fa8072" ;;
    sandybrown)           c="f4a460" ;;
    seagreen)             c="2e8b57" ;;
    seashell)             c="fff5ee" ;;
    sienna)               c="a0522d" ;;
    silver)               c="c0c0c0" ;;
    skyblue)              c="87ceeb" ;;
    slateblue)            c="6a5acd" ;;
    slategray)            c="708090" ;;
    slategrey)            c="708090" ;;
    snow)                 c="fffafa" ;;
    springgreen)          c="00ff7f" ;;
    steelblue)            c="4682b4" ;;
    tan)                  c="d2b48c" ;;
    teal)                 c="008080" ;;
    thistle)              c="d8bfd8" ;;
    tomato)               c="ff6347" ;;
    turquoise)            c="40e0d0" ;;
    violet)               c="ee82ee" ;;
    white)                c="ffffff" ;;
    whitesmoke)           c="f5f5f5" ;;
    yellow)               c="ffff00" ;;
    yellowgreen)          c="9acd32" ;;
    *) # Assume selection is a hex color
       # remove non hex values
       c=$(printf '%s' "$c" | sed 's/[^0-9a-f]//g')

       # remove alpha channel
       test "${#c}" -eq 4 && c="${c%?}"
       test "${#c}" -eq 8 && c="${c%??}"

       # convert 3 digit hex to 6 digits
       test "${#c}" -eq 3 && \
         c=$(printf '%s' "$c" | sed 's/\(.\)\(.\)\(.\)/\1\1\2\2\3\3/')
    ;;
  esac

  if test "${#c}" -eq 6; then
    printf 'echo -markup "{rgb:%s+r}%s"' \
      "$c" "$(printf "%${kak_window_width}s")"
  else
    printf 'fail selection is not a valid color'
  fi
}}
