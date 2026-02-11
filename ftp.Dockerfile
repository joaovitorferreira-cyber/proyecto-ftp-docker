# Selecció de la imatge base (Ubuntu 24.04)
FROM ubuntu:24.04

# Evitar interaccions durant la instal·lació
ENV DEBIAN_FRONTEND=noninteractive

# 1. Actualitzar repositoris i instal·lar el servei vsftpd [cite: 29, 30]
# 2. Instal·lar mòduls PAM per a LDAP i RADIUS 
RUN apt-get update -y && \
    apt-get install -y \
    vsftpd \
    libpam-ldap \
    libpam-radius-auth \
    openssl \
    db-util && \
    apt-get clean

# Creació de directoris necessaris per al funcionament de vsftpd [cite: 175]
RUN mkdir -p /var/run/vsftpd/empty && \
    mkdir -p /etc/vsftpd

# Exposició de ports:
# Port 21 per al canal de control [cite: 100]
# Rang 21100-21110 per al mode passiu (recomanat en entorns Docker)
EXPOSE 21
EXPOSE 21100-21110

# Execució del servei vsftpd apuntant al fitxer de configuració persistent
CMD ["/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf"]
