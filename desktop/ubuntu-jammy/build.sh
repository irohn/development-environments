docker build \
    -t rdesktop \
    -f Dockerfile \
    --build-arg TEST="this is a test" \
    .