#!/usr/bin/env bash

# Installs apache2, ffmpeg from source (HEAD) with av1 (libaom) and vp9 (libvpx), as well as a few
# other common libraries
# binary will be at ~/bin/ffmpeg

sudo apt update && sudo apt upgrade -y

mkdir -p ~/ffmpeg_sources ~/bin
export PATH="$HOME/bin:$PATH"

sudo apt install -y \
  autoconf \
  automake \
  build-essential \
  cmake \
  git \
  libass-dev \
  libfreetype6-dev \
  libsdl2-dev \
  libtheora-dev \
  libtool \
  libva-dev \
  libvdpau-dev \
  libvorbis-dev \
  libxcb1-dev \
  libxcb-shm0-dev \
  libxcb-xfixes0-dev \
  mercurial \
  pkg-config \
  texinfo \
  wget \
  zlib1g-dev \
  nasm \
  yasm \
  libvpx-dev \
  libopus-dev \
  libx264-dev \
  libmp3lame-dev \
  libdrm-dev \
  libmfx-dev \
  libssl-dev \
  libfdk-aac-dev \
  zip \
  unzip \
  apache2 \
  php \
  php-curl \
  php-json \
  php-cgi \
  php-xsl \
  php-mbstring \
  php-opcache \
  php-gd \
  php-pgsql \
  php-intl \
  php-bcmath \
  php-soap

# Install av1 (libaom) from source.
mkdir -p ~/ffmpeg_sources/libaom && \
  cd ~/ffmpeg_sources/libaom && \
  git clone https://aomedia.googlesource.com/aom && \
  cmake ./aom && \
  make && \
  sudo make install

cd ~/ffmpeg_sources && \
  wget -O ffmpeg-snapshot.tar.bz2 https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 && \
  tar xjvf ffmpeg-snapshot.tar.bz2 && \
  cd ffmpeg && \
  PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
    --prefix="$HOME/ffmpeg_build" \
    --pkg-config-flags="--static" \
    --extra-cflags="-I$HOME/ffmpeg_build/include" \
    --extra-ldflags="-L$HOME/ffmpeg_build/lib" \
	--extra-cflags=-I/usr/local/cuda/include \
	--extra-ldflags=-L/usr/local/cuda/lib64 \
    --extra-libs="-lpthread -lm" \
    --bindir="$HOME/bin" \
    --enable-gpl \
    --enable-libass \
    --enable-libfdk-aac \
    --enable-libmp3lame \
    --enable-libx264 \
    --enable-libtheora \
    --enable-libfreetype \
    --enable-libvorbis \
    --enable-libopus \
    --enable-libvpx \
    --enable-libaom \
	--enable-cuda-nvcc \
	--enable-libnpp \
	--enable-cuvid \
	--enable-nvenc \
	--enable-nvdec \
	--enable-openssl \
	--enable-libdrm \
	--enable-opengl \
    --enable-nonfree && \
  make && \
  make install && \
  hash -r



