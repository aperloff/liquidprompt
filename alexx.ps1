
#######################################
# LIQUID PROMPT DEFAULT TEMPLATE FILE #
#######################################

# Available features:
# LP_BATT battery
# LP_LOAD load
# LP_JOBS screen sessions/running jobs/suspended jobs
# LP_USER user
# LP_HOST hostname
# LP_PERM a colon ":"
# LP_PWD current working directory
# LP_VENV Python virtual environment
# LP_PROXY HTTP proxy
# LP_VCS the content of the current repository
# LP_ERR last error code
# LP_MARK prompt mark
# LP_TIME current time
# LP_TTYN number of current terminal (useful in title for quick switching)
# LP_RUNTIME runtime of last command
# LP_MARK_PREFIX user-defined prompt mark prefix (helpful if you want 2-line prompts)
# LP_PS1_PREFIX user-defined general-purpose prefix (default set a generic prompt as the window title)
# LP_PS1_POSTFIX user-defined general-purpose postfix
# LP_BRACKET_OPEN open bracket
# LP_BRACKET_CLOSE close bracket

# Remember that most features come with their corresponding colors,
# see the README.

# Setup the basic PS1 style
reset_style='\[\033[00m\]'
if [ -z "$VIM" ];
then status_style=$reset_style'\[\033[0;90m\]' # gray color; use 0;37m for lighter color
else status_style=$reset_style'\[\033[0;90;107m\]'
fi
prompt_style=$reset_style
command_style=$reset_style'\[\033[1;29m\]' # bold black
export MYPS='$(echo -n "${PWD/#$HOME/~}" | awk -F "/" '"'"'{
if (length($0) > 14) { if (NF>4) print $1 "/" $2 "/.../" $(NF-1) "/" $NF;
else if (NF>3) print $1 "/" $2 "/.../" $NF;
else print $1 "/.../" $NF; }
else print $0;}'"'"')'
PS1="\n\[\033[35m\]$(/bin/date)\[\033[m\]\n[\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]$(eval "echo ${MYPS}")\[\033[m\]]"

# Add VCS infos
# If root, the info has not been collected unless LP_ENABLE_VCS_ROOT
# is set.
LP_PS1="${status_style}$fill \t\n${prompt_style}${PS1}${command_style}${LP_VCS}"

# add return code and prompt mark
LP_PS1="${LP_PS1}${LP_RUNTIME}${LP_MARK_PREFIX}${LP_MARK}${LP_PS1_POSTFIX}"

# vim: set et sts=4 sw=4 tw=120 ft=sh:
