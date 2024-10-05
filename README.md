# Install Apache and FFmpeg for VP9 and AV1 with GPU on Ubuntu 24.04

1. Update apt and install GPU driver.

```sudo add-apt-repository ppa:graphics-drivers/ppa && sudo apt update && sudo apt upgrade -y && sudo apt install nvidia-driver-560 -y```

2. Reboot system.

```sudo reboot```

3. Auto setup.

```wget https://raw.githubusercontent.com/kjvfghkrgs/install-apache2-ffmpeg/refs/heads/main/setup.sh && sudo sh /root/setup.sh```


# Additional command

### Check drivers

```nvidia-smi```

### Check ffmpeg configs

```ffmpeg -hwaccels```

### Check nv-codec-headers

```ls /usr/local/include/ffnvcodec/```
