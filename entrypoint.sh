#!/bin/bash

# If the command is a shell or generic command, execute it directly
if [[ "$1" == "/bin/sh" || "$1" == "/bin/bash" || "$1" == "sh" || "$1" == "bash" ]]; then
    exec "$@"
fi

# Otherwise, use the original archivebox entrypoint
exec /app/bin/docker_entrypoint.sh "$@"
