# Utiliser Debian comme base
FROM debian:latest

# Mettre à jour le système et installer OpenSSH Server et Mosquitto Client
RUN apt-get update && \
    apt-get install -y openssh-server mosquitto-clients && \
    rm -rf /var/lib/apt/lists/*

# Configurer SSH
RUN mkdir /var/run/sshd

# Changer le mot de passe pour root (pour exemple, mot de passe 'root')
RUN echo 'root:root' | chpasswd

# Autoriser le démarrage de SSH avec un client distant
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Exposer les ports SSH et MQTT (si besoin)
EXPOSE 22

# Lancer le service SSH
CMD ["/usr/sbin/sshd", "-D"]