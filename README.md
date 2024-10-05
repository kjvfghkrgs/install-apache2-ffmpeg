# Install Apache and FFmpeg for VP9 and AV1 with GPU on Ubuntu 24.04 #

#### 1. Update apt and install GPU driver ####

```sudo add-apt-repository ppa:graphics-drivers/ppa && sudo apt update && sudo apt upgrade -y && sudo apt install nvidia-driver-560 -y```

#### 2. Reboot the system ####

```sudo reboot```

#### 3. Run the automatic setup script ####

```wget https://raw.githubusercontent.com/kjvfghkrgs/install-apache2-ffmpeg/refs/heads/main/setup.sh && sudo sh /root/setup.sh```

# Additional commands #

#### Check the installed drivers ####

```nvidia-smi```

#### Check FFmpeg hardware acceleration options: ####

```ffmpeg -hwaccels```

#### Check NV-Codec-headers ####

```ls /usr/local/include/ffnvcodec/```
