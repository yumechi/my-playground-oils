# Oils Shell (OSH/YSH) on Alpine Linux
# Podman/Docker compatible

FROM alpine:3.19 AS builder

# Oils version
ARG OILS_VERSION=0.23.0

# Install build dependencies
RUN apk add --no-cache \
    libc-dev \
    gcc \
    g++ \
    make \
    readline-dev \
    curl

# Download and extract Oils source
WORKDIR /build
RUN curl -L -o oils.tar.gz \
    "https://www.oilshell.org/download/oils-for-unix-${OILS_VERSION}.tar.gz" && \
    tar -xzf oils.tar.gz && \
    rm oils.tar.gz

# Build Oils
WORKDIR /build/oils-for-unix-${OILS_VERSION}
RUN ./configure --prefix=/usr --datarootdir=/usr/share && \
    _build/oils.sh && \
    ./install

# Runtime stage
FROM alpine:3.19

# Install runtime dependencies
RUN apk add --no-cache readline libstdc++ libgcc

# Copy Oils binaries from builder
COPY --from=builder /usr/bin/oils-for-unix /usr/bin/
COPY --from=builder /usr/bin/osh /usr/bin/
COPY --from=builder /usr/bin/ysh /usr/bin/

# Create config directories
RUN mkdir -p /root/.config/oils /root/.local/share/oils

# Copy test scripts
COPY scripts/ /scripts/

# Default to osh
CMD ["osh"]
