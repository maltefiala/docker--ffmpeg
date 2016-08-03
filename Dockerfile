#================#
#   BASIC INFO   #
#================#

FROM debian:wheezy
MAINTAINER 3dox "code@3dox.com"


#==============================#
#   INSTALL BUILD ESSENTIALS   #
#==============================#

RUN apt-get update; \
	apt-get -y install autoconf automake build-essential \
	libass-dev libfreetype6-dev libgpac-dev wget \
	libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libx11-dev \
	libxext-dev libxfixes-dev pkg-config texi2html zlib1g-dev

RUN mkdir -p /opt/ffmpeg_sources


#================#
#   BUILD YASM   #
#================#

RUN mkdir -p /opt/ffmpeg_sources/yasm; \
	wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz -o /opt/ffmpeg_sources/yasm; \
	tar xzvf /opt/ffmpeg_sources/yasm/yasm-1.3.0.tar.gz; \
	./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" /opt/ffmpeg_sources/yasm/yasm-1.3.0

RUN /opt/ffmpeg_sources/yasm/yasm-1.3.0/make; make install; make distclean



#=====================#
#   REMOVE PACKAGES   #
#=====================#

RUN apt-get update; \
	apt-get -y install purge autoconf automake build-essential \
	libass-dev libfreetype6-dev libgpac-dev \
	libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libx11-dev \
	libxext-dev libxfixes-dev pkg-config texi2html zlib1g-dev
RUN rm -r /opt/ffmpeg_sources
