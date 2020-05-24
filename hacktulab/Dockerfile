FROM kalilinux/kali

########
# INIT #
########

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

ARG USER_ID
ARG GROUP_ID

RUN groupadd -f -g $GROUP_ID hacking
RUN useradd -u $USER_ID -g $GROUP_ID -m -p '' hacking

# Term
ENV TERM xterm

# Packages
RUN echo 'deb http://old.kali.org/kali sana main non-free contrib' >> /etc/apt/sources.list
RUN apt-get update --fix-missing

# Locale
RUN apt-get install -y locales && sed -i -e 's/\# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8

# Utils
RUN apt-get install -y vim wget curl nano tmux silversearcher-ag apt-file git zsh ncdu

# Dependencies
RUN apt-get install -y openvpn zenity mingw32 xterm gnome-terminal default-jre default-jdk aapt dex2jar zlib1g-dev libmagickwand-dev imagemagick zipalign cowpatty bully lighttpd macchanger php-cgi isc-dhcp-server python3-dev python3-setuptools python-pip python3-pip libssl-dev xprobe2 golang-go whatweb sslyze sslscan wafw00f dnsenum && \
    apt-get install -y wine && \
    git clone --depth=1 https://github.com/noxxi/p5-io-socket-ssl && cd p5-io-socket-ssl && perl Makefile.PL && make && make install && rm -r /p5-io-socket-ssl

# MOTD
RUN echo -e "\e[0;31m" > /etc/motd && \                                                                                                                                                    
    echo "      .d888888  dP d888888P dP     dP dP         .d888888   888888ba  " >> /etc/motd && \
    echo "     d8'    88  88    88    88     88 88        d8'    88   88    '8b " >> /etc/motd && \
    echo "     88aaaaa88  88    88    88     88 88        88aaaaa88   88aaaa8P' " >> /etc/motd && \
    echo "     88     88  88    88    88     88 88        88     88   88   '8b. " >> /etc/motd && \
    echo "     88     88  88    88    Y8.   .8P 88        88     88   88    .88 " >> /etc/motd && \
    echo "     88     88  dP    dP    'Y88888P' 88888888P 88     88   88888888P " >> /etc/motd && \
    echo -e "\e[0;34m">> /etc/motd && \
    echo -e "\e[4m">> /etc/motd && \
    echo '\n' >> /etc/motd && \
    echo "                   https://github.com/aituglo/aitulab">> /etc/motd && \
    echo '\n' >> /etc/motd

# Add files
ADD .cheat/ /home/hacking/.cheat/
ADD .config/ /home/hacking/.config/
ADD wordlists /usr/share/

# Add tools
ADD tools/* /opt/tools/

# Adding user to sudoers
RUN apt-get update && \
      apt-get -y install sudo

RUN adduser hacking sudo

RUN sudo chown hacking /home/hacking/

# MOTD
RUN git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh /home/hacking/.oh-my-zsh && \
    cp /home/hacking/.oh-my-zsh/templates/zshrc.zsh-template /home/hacking/.zshrc && \
    sed -i -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="bira"/g' /home/hacking/.zshrc && \
    apt-file update

RUN echo '[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/motd' >> /home/hacking/.zshrc

WORKDIR /home/hacking

#################
# INSTALL TOOLS #
#################

# Install pip
RUN apt-get remove -y python-pip && \
    wget https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py  && \
    rm get-pip.py

# Footprinting / Information-Gathering / OSINT / Fingerprint
RUN apt-get install -y whois dnsutils dnsmap nmap theharvester dmitry netdiscover fierce
RUN git clone --depth=1 https://github.com/1N3/Sn1per /opt/Sn1per && cd /opt/Sn1per && chmod +x install.sh && ./install.sh
RUN curl -o /usr/local/bin/googler https://raw.githubusercontent.com/jarun/googler/v2.3/googler && chmod +x /usr/local/bin/googler
RUN easy_install shodan
RUN git clone --depth=1 https://github.com/maurosoria/dirsearch /opt/dirsearch && \
    git clone --depth=1 https://github.com/HatBashBR/ShodanHat /opt/ShodanHat

# Pentest Framework
RUN pip3 install pwntools
RUN apt-get install -y metasploit-framework websploit && \
    git clone --depth=1 https://github.com/Manisso/fsociety /opt/fsociety

# MITM / ARP poisoning / Spoofing / Sniffing
RUN apt-get update
RUN apt-get install -y  python-impacket mitmproxy dsniff mitmf tcpdump ngrep
RUN git clone --depth=1 https://github.com/r00t-3xp10it/morpheus /opt/morpheus && \
    git clone --depth=1 https://github.com/evilsocket/bettercap /opt/bettercap 

# Crack password
# RUN git clone --depth=1 https://github.com/berzerk0/Probable-Wordlists /opt/Probable-Wordlists
RUN apt-get install -y hydra john 

# Vulnerability Scanner (SQL, XSS, LFI, RFI etc...)
RUN apt-get install -y arachni nikto wapiti fimap

# SQL Injection
RUN apt-get install -y sqlmap themole

# Phishing
RUN apt-get install -y httrack && \
    git clone --depth=1 https://github.com/UndeadSec/SocialFish.git /opt/SocialFish && \
    git clone --depth=1 https://github.com/kgretzky/evilginx /opt/evilginx

# NMAP NSE Script vulscan
RUN curl -s http://www.computec.ch/projekte/vulscan/download/nmap_nse_vulscan-2.0.tar.gz | tar xzvf - -C /usr/share/nmap/scripts/ && \
    wget -P /usr/share/nmap/scripts/ https://raw.githubusercontent.com/cldrn/nmap-nse-scripts/master/scripts/smb-vuln-ms17-010.nse && \
    wget -P /usr/share/nmap/scripts/ https://raw.githubusercontent.com/vulnersCom/nmap-vulners/master/vulners.nse

# Wireless networks, WEP WPA
RUN apt-get install -y wifite wifiphisher mdk3 tshark
RUN git clone --depth=1 https://github.com/kylemcdonald/FreeWifi /opt/FreeWifi && cd /opt/FreeWifi && pip install -r requirements.txt && \
    git clone --depth=1 https://github.com/FluxionNetwork/fluxion /opt/fluxion 

# Reverse Engineering
RUN apt-get install -y apktool set && \
    git clone --depth=1 https://github.com/radare/radare2 /opt/radare2 && \
    apt-get install -y gdb

# Backdoor / Remote Access Trojan (RAT)
RUN git clone --depth=1 https://github.com/Screetsec/TheFatRat /opt/TheFatRat && \
    echo "*\n*\n*\n*\nmsfconsole\nmsfvenom\nbackdoor-factory\nsearchsploit" > /opt/TheFatRat/config/config.path && \
    chmod +x /opt/TheFatRat/fatrat
RUN apt-get install -y mingw-w64

# Search exploit
RUN apt-get install -y exploitdb

# Shellcode
RUN git clone --depth=1 https://github.com/reyammer/shellnoob /opt/shellnoob

# Wordpress
RUN apt-get install -y wpscan
RUN git clone --depth=1 https://github.com/n00py/WPForce /opt/WPForce && \
    git clone --depth=1 https://github.com/m4ll0k/WPSeku /opt/WPSeku

# Paquet manipulation
RUN apt-get install -y hping3 scapy

# Keylogger
RUN git clone --depth=1 https://github.com/tiagorlampert/sAINT /opt/sAINT

# FindMyHash
RUN git clone --depth=1 https://github.com/frdmn/findmyhash /opt/findmyhash

# Adding Cheat

RUN wget https://github.com/cheat/cheat/releases/download/3.10.1/cheat-linux-amd64.gz
RUN gzip -d cheat-linux-amd64.gz && \
    mv cheat-linux-amd64 /usr/bin/cheat && \
    chmod +x /usr/bin/cheat


#########
# CLEAN #
#########

RUN apt-get autoremove -y && \
    rm -rf /tmp/* && \
    rm -rf /var/lib/{apt,dpkg,cache,log,tmp}/*

USER hacking