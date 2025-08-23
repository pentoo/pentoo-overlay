FROM pentoolinux/pentoo-core

#setup gentoo repo
WORKDIR /var/db/repos/
RUN git clone https://github.com/gentoo/gentoo.git --depth 1
#RUN git clone https://github.com/pentoo/pentoo-overlay.git pentoo --depth 1
# Use the github checkout for pentoo, that's what we are testing
COPY . pentoo
#RUN emerge --regen --jobs=$(nproc) --quiet
WORKDIR /home
#RUN sed -i 's#pentoo-in-a-container#pentoo-in-a-container -pentoo-full#' /etc/portage/make.conf
#disable minimal
RUN sed -i 's# pentoo-minimal##' /etc/portage/make.conf
#install libsndfile minimal to break circular deps
#RUN USE=minimal FEATURES="-ipc-sandbox -network-sandbox -pid-sandbox" emerge --getbinpkg=y --buildpkg=n --jobs=$(nproc) --load-average=$(nproc) --deep --update --newuse media-libs/libsndfile
#install pentoo/pentoo
RUN FEATURES="-ipc-sandbox -network-sandbox -pid-sandbox" time emerge --getbinpkg=y --buildpkg=n --jobs=$(nproc) --load-average=$(nproc) --deep --update --newuse pentoo/pentoo --verbose --pretend
