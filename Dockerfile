FROM rust:slim-bookworm AS builder

WORKDIR /tmp/
RUN apt-get update -y && apt-get -y --no-install-recommends install libssl-dev pkg-config

WORKDIR /tmp/nmsr-rs/
COPY . .

RUN cargo build --release --bin nmsr-aas --features ears --package nmsr-aas



FROM rust:slim-bookworm

RUN apt-get update -y && apt-get --no-install-recommends install mesa-vulkan-drivers -y

WORKDIR /nmsr/

COPY --from=builder /tmp/nmsr-rs/target/release/nmsr-aas /nmsr/nmsr-aas
COPY ./example.config.toml /nmsr/config.toml

ENV NMSR_USE_SMAA=1
ENV NMSR_SAMPLE_COUNT=1
ENV WGPU_BACKEND=vulkan
ENV RUST_BACKTRACE=1

RUN chmod +x /nmsr/nmsr-aas

EXPOSE 8080

# Set the entrypoint script
CMD /nmsr/nmsr-aas -c config.toml
