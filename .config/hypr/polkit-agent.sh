if [ "$1" != '_CALLED_INTERNALLY' ]; then
	exec cmd-polkit-agent -s -c "$0 _CALLED_INTERNALLY"
else
	shift

	while IFS= read -r msg; do
        action=$(printf '%s' "$msg" | jq -r '.action')

        if [ "$action" = "request password" ]; then
			prompt="$(printf '%s' "$msg" | jq -rc '.prompt // "Password"')"
			message="$(printf '%s' "$msg" | jq -rc '.message // "Authentication required"')"

            response=$(printf '' | bemenu -C -i -p "$message: $prompt" -x hide -T --fixed-height --single-instance -c -W 0.75 -B 2 -R 8)

			if [ -z "$response" ]; then
				echo '{"action":"cancel"}'
			else
                jq -c -n --arg pw "$response" '{"action":"authenticate","password":$pw}'
			fi
		fi
	done
fi
