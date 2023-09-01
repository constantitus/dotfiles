pactl load-module module-null-sink sink_name="pw-virtual-effects" object.linger=1 channels=2 media.class=Audio/Duplex device.description="pw-virtual-effects" && \
pw-jack carla -n ~/.config/bspwm/config.carxp

