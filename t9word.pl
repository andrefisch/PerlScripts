AUTOLOAD {
    pop =~ s/(.)(\1*) ?/ $1 ? chr 3 * $1 + ($1 > 7) + length "$2" : ' ' /ger
}
