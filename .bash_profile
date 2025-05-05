# Add the following to the end of the system file of the same name

# For x11
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	exec startx
fi

# For wayland
# if running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
	exec sway
fi
