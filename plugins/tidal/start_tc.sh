#!/usr/bin/env bash

if [[ -n "$SOUND_DISABLE_TIDAL" ]]; then
  echo "TIDAL is disabled, exiting..."
  exit 0
fi

SOUND_DEVICE_NAME=${SOUND_DEVICE_NAME:-"balenaSound TIDAL $(hostname | cut -c -4)"}
SOUND_TIDAL_LOGLEVEL=${SOUND_TIDAL_LOGLEVEL:-3}
SOUND_TIDAL_WEBSOCKLOG=${SOUND_TIDAL_WEBSOCKLOG:-0}

echo "Starting TIDAL plugin..."
echo "Device name: $SOUND_DEVICE_NAME"

/usr/bin/speaker_controller_application >/dev/null 2>&1 &
disown

set -- /usr/bin/tcon \
       -f $SOUND_DEVICE_NAME \
       --codec-mpegh false \
       --codec-mqa false \
       --model-name "OEM" \
       --disable-app-security false \
       --disable-web-security true \
       --enable-mqa-passthrough true \
       --log-level "$SOUND_TIDAL_LOGLEVEL" \
       --tc-certificate-path "/etc/ssl/private/tcon.crt" \
       --clientid "VCjoaRrbaMU005Tk"
       "$@"

exec "$@"