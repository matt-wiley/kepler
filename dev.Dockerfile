# Use Ubuntu as the base image
FROM ubuntu:latest

# Install OpenSSH Server and other necessary packages
RUN apt-get update && apt-get install -y \
    openssh-server \
    vim \
    curl \
    sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configure SSH for password authentication
RUN mkdir -p /var/run/sshd \
    && echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
    && echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config \
    && echo 'root:password' | chpasswd

# Create user 'frodo' with password 'ringbearer'
RUN useradd -m -s /bin/bash frodo \
    && echo 'frodo:ringbearer' | chpasswd \
    && usermod -aG sudo frodo

COPY . /home/frodo/repospace/kepler

RUN chown -R frodo:frodo /home/frodo

# SSH login fix. Otherwise user is kicked off after login
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

# Expose the SSH port
EXPOSE 22

# Set the entrypoint
CMD ["/usr/sbin/sshd", "-D"]