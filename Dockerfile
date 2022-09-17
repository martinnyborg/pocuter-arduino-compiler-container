FROM alpine:latest

# Install curl
RUN apk add curl bash gcompat g++ unzip python3 py-pip && \
    pip install pyserial

# Install the latest arduino-cli
RUN curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh

# Add arduino-cli config with esp32 board
COPY arduino-cli.yaml /root/.arduino15/

# Update core with new board, esp32:esp32
RUN arduino-cli core update-index

# Install esp32:esp32 platform
RUN arduino-cli core install esp32:esp32

# Install pocuter one lib
RUN wget https://files.cdn.pocuter.com/pocuter-one/pocuter-one-library.zip -P /tmp && \
    arduino-cli lib install --zip-path /tmp/pocuter-one-library.zip && \
    rm /tmp/pocuter-one-library.zip

WORKDIR /root
CMD ["/bin/sh"]
