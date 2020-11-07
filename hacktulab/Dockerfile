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
RUN echo "\e[0;31m" > /etc/motd && \                                                                                                                                                    
    echo "      .d888888  dP d888888P dP     dP dP         .d888888   888888ba  " >> /etc/motd && \
    echo "     d8'    88  88    88    88     88 88        d8'    88   88    '8b " >> /etc/motd && \
    echo "     88aaaaa88  88    88    88     88 88        88aaaaa88   88aaaa8P' " >> /etc/motd && \
    echo "     88     88  88    88    88     88 88        88     88   88   '8b. " >> /etc/motd && \
    echo "     88     88  88    88    Y8.   .8P 88        88     88   88    .88 " >> /etc/motd && \
    echo "     88     88  dP    dP    'Y88888P' 88888888P 88     88   88888888P " >> /etc/motd && \
    echo "\e[0;34m">> /etc/motd && \
    echo '\n' >> /etc/motd && \
    echo "                   \e[4mhttps://github.com/aituglo/aitulab">> /etc/motd && \
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
RUN apt-get install -y hping3

# Keylogger
RUN git clone --depth=1 https://github.com/tiagorlampert/sAINT /opt/sAINT

# FindMyHash
RUN git clone --depth=1 https://github.com/frdmn/findmyhash /opt/findmyhash

RUN mkdir /home/hacking/toolkit

# Sublist3r
RUN cd /home/hacking/toolkit && \
    git clone https://github.com/aboul3la/Sublist3r.git && \
    cd Sublist3r/ && \
    pip3 install -r requirements.txt && \
    ln -s /home/hacking/toolkit/Sublist3r/sublist3r.py /usr/local/bin/sublist3r

# seclists
RUN mkdir /home/hacking/wordlists && \
    cd /home/hacking/wordlists && \
    git clone --depth 1 https://github.com/danielmiessler/SecLists.git 

# knock
RUN cd /home/hacking/toolkit && \
    git clone https://github.com/guelfoweb/knock.git && \
    cd knock && \
    chmod +x setup.py && \
    python setup.py install

# massdns
RUN cd /home/hacking/toolkit && \
    git clone https://github.com/blechschmidt/massdns.git && \
    cd massdns/ && \
    make && \
    ln -sf /home/hacking/toolkit/massdns/bin/massdns /usr/local/bin/massdns

# wafw00f
RUN cd /home/hacking/toolkit && \
    git clone https://github.com/enablesecurity/wafw00f.git && \
    cd wafw00f && \
    chmod +x setup.py && \
    python setup.py install

# wpscan
RUN cd /home/hacking/toolkit && \
    git clone https://github.com/wpscanteam/wpscan.git && \
    cd wpscan/ && \
    gem install bundler && bundle install --without test && \
    gem install wpscan

# commix 
RUN cd /home/hacking/toolkit && \
    git clone https://github.com/commixproject/commix.git && \
    cd commix && \
    chmod +x commix.py && \
    ln -sf /home/hacking/toolkit/commix/commix.py /usr/local/bin/commix

# masscan
RUN cd /home/hacking/toolkit && \
    git clone https://github.com/robertdavidgraham/masscan.git && \
    cd masscan && \
    make && \
    ln -sf /home/hacking/toolkit/masscan/bin/masscan /usr/local/bin/masscan    

# altdns
RUN cd /home/hacking/toolkit && \
    git clone https://github.com/infosec-au/altdns.git && \
    cd altdns && \
    pip3 install -r requirements.txt && \
    chmod +x setup.py && \
    python setup.py install

# teh_s3_bucketeers
RUN cd /home/hacking/toolkit && \
    git clone https://github.com/tomdev/teh_s3_bucketeers.git && \
    cd teh_s3_bucketeers && \
    chmod +x bucketeer.sh && \
    ln -sf /home/hacking/toolkit/teh_s3_bucketeers/bucketeer.sh /usr/local/bin/bucketeer

# Recon-ng
RUN cd /home/hacking/toolkit && \
    git clone https://github.com/lanmaster53/recon-ng.git && \
    cd recon-ng && \
    pip3 install -r REQUIREMENTS && \
    chmod +x recon-ng && \
    ln -sf /home/hacking/toolkit/recon-ng/recon-ng /usr/local/bin/recon-ng

# XSStrike
RUN cd /home/hacking/toolkit && \
    git clone https://github.com/s0md3v/XSStrike.git && \
    cd XSStrike && \
    pip3 install -r requirements.txt && \
    chmod +x xsstrike.py && \
    ln -sf /home/hacking/toolkit/XSStrike/xsstrike.py /usr/local/bin/xsstrike

# theHarvester
RUN cd /home/hacking/toolkit && \
    git clone https://github.com/AlexisAhmed/theHarvester.git && \
    cd theHarvester && \
    pip3 install -r requirements.txt && \
    chmod +x theHarvester.py && \
    ln -sf /home/hacking/toolkit/theHarvester/theHarvester.py /usr/local/bin/theharvester

# CloudFlair
RUN cd /home/hacking/toolkit && \
    git clone https://github.com/christophetd/CloudFlair.git && \
    cd CloudFlair && \
    pip3 install -r requirements.txt && \
    chmod +x cloudflair.py && \
    ln -sf /home/hacking/toolkit/CloudFlair/cloudflair.py /usr/local/bin/cloudflair

# go
RUN cd /opt && \
    wget https://golang.org/dl/go1.15.4.linux-amd64.tar.gz && \
    tar -xvf go1.15.4.linux-amd64.tar.gz && \
    rm -rf /opt/go1.15.4.linux-amd64.tar.gz && \
    mv go /usr/local 
ENV GOROOT /usr/local/go
ENV GOPATH /root/go
ENV PATH ${GOPATH}/bin:${GOROOT}/bin:${PATH}

# gobuster
RUN cd /home/hacking/toolkit && \
    git clone https://github.com/OJ/gobuster.git && \
    cd gobuster && \
    go get && go install

# virtual-host-discovery
RUN cd /home/hacking/toolkit && \
    git clone https://github.com/AlexisAhmed/virtual-host-discovery.git && \
    cd virtual-host-discovery && \
    chmod +x scan.rb && \
    ln -sf /home/hacking/toolkit/virtual-host-discovery/scan.rb /usr/local/bin/virtual-host-discovery

# bucket_finder
RUN cd /home/hacking/toolkit && \
    git clone https://github.com/AlexisAhmed/bucket_finder.git && \
    cd bucket_finder && \
    chmod +x bucket_finder.rb && \
    ln -sf /home/hacking/toolkit/bucket_finder/bucket_finder.rb /usr/local/bin/bucket_finder

# dirsearch
RUN cd /home/hacking/toolkit && \
    git clone https://github.com/AlexisAhmed/dirsearch.git && \
    cd dirsearch && \
    chmod +x dirsearch.py && \
    ln -sf /home/hacking/toolkit/dirsearch/dirsearch.py /usr/local/bin/dirsearch

# s3recon
RUN pip3 install --upgrade setuptools && \
    pip3 install pyyaml pymongo requests s3recon

# fierce
RUN python3 -m pip install fierce

# GoSpider
RUN go get -u github.com/jaeles-project/gospider

# hakrawler
RUN go get github.com/hakluke/hakrawler

# SubDomainzer
RUN cd /home/hacking/toolkit && \
    git clone https://github.com/nsonaniya2010/SubDomainizer.git && \
    cd SubDomainizer && \
    pip3 install -r requirements.txt 

# Amass
RUN apt-get install -y amass

# Github-subdomain
RUN cd /home/hacking/toolkit && \
    wget https://raw.githubusercontent.com/gwen001/github-search/master/github-subdomains.py

# Shosubgo
RUN cd /home/hacking/toolkit && \
    git clone https://github.com/incogbyte/shosubgo

# shuffledns
RUN GO111MODULE=on go get -u -v github.com/projectdiscovery/shuffledns/cmd/shuffledns

# altdns
RUN pip3 install py-altdns

# dnmasscan
RUN cd /home/hacking/toolkit && \
    git clone https://github.com/rastating/dnmasscan

# Brutespray
RUN apt-get -y install brutespray

# SubOver
RUN go get github.com/Ice3man543/SubOver

# nuclei
RUN GO111MODULE=on go get -u -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei

# Asnlookup
RUN cd /home/hacking/toolkit && \
    git clone https://github.com/yassineaboukir/Asnlookup && \
    cd Asnlookup && \
    pip3 install -r requirements.txt

# Metabigor
RUN go get -u github.com/j3ssie/metabigor

# subfinder
RUN cd /home/hacking/toolkit && \
    git clone https://github.com/projectdiscovery/subfinder.git && \
    cd subfinder/v2/cmd/subfinder && \
    go build . && \
    mv subfinder /usr/local/bin/

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