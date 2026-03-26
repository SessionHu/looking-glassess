FROM  debian:stable-slim AS builder
WORKDIR /src
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    ldc \
    llvm-dev \
    make \
    zstd && \
    rm -rf /var/lib/apt/lists/*
ENV RELEASE=1
COPY . .
RUN make -j$(nproc) package

FROM scratch AS exporter
COPY --from=builder /src/lgs.tar.zst /
