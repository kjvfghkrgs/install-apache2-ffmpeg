#!/usr/bin/env bash

# Installs apache2, ffmpeg from source (HEAD) with av1 (libaom) and vp9 (libvpx), as well as a few
# other common libraries. The binary will be at ~/bin/ffmpeg.

sudo apt update && sudo apt upgrade -y

mkdir -p ~/ffmpeg_sources ~/bin
export PATH="$HOME/bin:$PATH"

sudo apt install -y \
  nvidia-cuda-toolkit \
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
  libc6 \
  libc6-dev \
  libnuma1 \
  libnuma-dev \
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

# Clone nv-codec-headers
git clone https://git.videolan.org/git/ffmpeg/nv-codec-headers.git
cd nv-codec-headers
git checkout n12.0
sudo make install
cd -

# Install av1 (libaom) from source
mkdir -p ~/ffmpeg_sources/libaom
cd ~/ffmpeg_sources/libaom
git clone https://aomedia.googlesource.com/aom
mkdir -p aom_build
cd aom_build
cmake ../aom
make -j$(nproc)
sudo make install
cd ../../

# Clone ffmpeg repository
git clone https://git.ffmpeg.org/ffmpeg.git ffmpeg
cd ffmpeg
./configure \
  --extra-cflags="-I/usr/local/cuda/include" \
  --extra-ldflags="-L/usr/local/cuda/lib64" \
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
  --disable-static \
  --enable-shared \
  --enable-nonfree
make -j$(nproc)
sudo make install
hash -r

# Update LD_LIBRARY_PATH for Nvidia libraries
echo 'export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc

# Refresh shared library cache
sudo ldconfig
