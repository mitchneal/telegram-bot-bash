#!/bin/bash
#===============================================================================
#
#          FILE: send_message.sh
# 
#         USAGE: send_edit_message.sh [-h|--help] [format] "CHAT[ID]" "MESSAGE[ID]" "message ...." [debug]
# 
#   DESCRIPTION: replace a message in the given user/group
# 
#       OPTIONS: format - normal, markdown, html (optional)
#                CHAT[ID] - ID number of CHAT
#                MESSAGE[ID] - message to replace
#                message - message to send in specified format
#                    if no format is given send_normal_message() format is used
#
#                -h - display short help
#                --help -  this help
#
#                Set BASHBOT_HOME to your installation directory
#
#	LICENSE: WTFPLv2 http://www.wtfpl.net/txt/copying/
#        AUTHOR: KayM (gnadelwartz), kay@rrr.de
#       CREATED: 23.12.2020 16:52
#
#### $$VERSION$$ v1.2-dev2-57-g928ab05
#===============================================================================

# set bashbot environment
# shellcheck disable=SC1090
source "${0%/*}/bashbot_env.inc.sh"

####
# parse args
SEND="edit_normal_message"
case "$1" in
	"nor*"|"tex*")
		SEND="edit_normal_message"
		shift
		;;
	"mark"*)
		SEND="edit_markdownv2_message"
		shift
		;;
	"html")
		SEND="edit_html_message"
		shift
		;;
	'')
		echo "missing arguments"
		;&
	"-h"*)
		echo 'usage: send_edit_message [-h|--help] [format] "CHAT[ID]" "MESSAGE[ID]" "message ..."  [debug]'
		exit 1
		;;
	'--h'*)
		sed -n '3,/###/p' <"$0"
		exit 1
		;;
esac

# source bashbot and send message
# shellcheck disable=SC1090
source "${BASHBOT_HOME}/bashbot.sh" source "$4"

####
# ready, do stuff here -----

# send message in selected format
"${SEND}" "$1" "$2" "$3"

# output send message result
jssh_printDB "BOTSENT" | sort -r
