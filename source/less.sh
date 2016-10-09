# stolen from http://merlinmoncure.blogspot.com.au/2007/10/better-psql-with-less.html
export PAGER=less

# -i ignore case in search
# -M long prompt ?
# -S chop long lines
# -x4 tab stop at multiples of 4
# -F quit if one screen
# -X no (de)initialisation (avoids clearing screen etc)
# -R handle colours nicely
export LESS="-iMSx4 -FXR"

# handle utf-8
export LESSCHARSET=utf-8
