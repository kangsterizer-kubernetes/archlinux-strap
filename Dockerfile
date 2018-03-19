FROM scratch
MAINTAINER kang@insecure.ws
COPY archroot/* /
COPY mirrorlist /etc/pacman.d

# Update archlinux base and remove hardware-specific packages and other cruft
RUN pacman-key --init && \
	pacman-key --populate archlinux && \
	pacman --noconfirm -Syu --needed base vim && \
	pacman --noconfirm -Rsc \
		 cryptsetup \
		 device-mapper \
		 dhcpcd \
		 iproute2 \
		 jfsutils \
		 lvm2 \
		 mdadm \
		 nano \
		 pciutils \
		 pcmciautils \
		 reiserfsprogs \
		 systemd-sysvcompat \
		 usbutils \
		 xfsprogs && \
	rm -rf \
		/var/cache/pacman/pkg/* \
		/var/lib/pacman/sync/* \
		/etc/pacman.d/mirrorlist.pacnew \
		/README && \
	paccache -r
CMD /usr/bin/bash
