# ---
# This Dockerfile creates a Balena OS guest image for the Raspberry Pi Zero 2W with Dotnet STS.
# ---

FROM --platform=$BUILDPLATFORM balenalib/raspberrypi0-2w-64-alpine:latest AS final

# Update image
RUN apk update && apk upgrade --no-cache

# Install prerequisites
RUN apk add --no-cache \
    curl \
    icu-libs \
    libgcc \
    libstdc++ \
    zlib \
    musl \
    krb5-libs \
    openssl \
    ca-certificates \
    tzdata

# Clean
RUN rm -rf /var/cache/apk/*

# Download and install .NET
RUN curl -SL https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh && \
    chmod +x dotnet-install.sh && \
    ./dotnet-install.sh --channel STS --version latest --runtime aspnetcore && \
    rm dotnet-install.sh
