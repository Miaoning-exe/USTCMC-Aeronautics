# USTCMC Aeronautics Server Network

**Built with Velocity and Docker by miaoning.**

<br><br>

## Getting Started

### 1. Install Docker

First, install the Docker engine and necessary system tools:

Update system packages
```bash
sudo apt-get update     # Ubuntu
sudo yum update         # CentOS
```

Install basic tools like Git, Curl, etc.
```bash
sudo apt-get install -y git curl wget   # Ubuntu
sudo yum install -y git curl wget       # CentOS
```

Install Docker using the official convenience script
```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

Enable Docker to start on boot
```bash
systemctl start docker
systemctl enable docker
```

Install Docker Compose plugin
```bash
sudo apt-get install -y docker-compose-plugin   # Ubuntu
sudo yum install -y docker-compose-plugin       # CentOS
```

Verify the installation
```bash
docker --version
docker compose version
```
If the Docker version is displayed successfully, the installation is complete.

Add the current user to the docker group (to run docker commands without sudo)
```bash
sudo usermod -aG docker $USER
```
Note: After executing the above command, it is recommended to exit the terminal and reconnect via SSH for the permissions to take effect.

### 2. Get Project Configuration

Create and navigate to the project directory

```bash
sudo mkdir Aeronautics_network_server
sudo chown -R $USER:$USER Aeronautics_network_server
cd Aeronautics_network_server
```

Clone this repository to the server's root directory

```bash
git clone https://github.com/Miaoning-exe/USTCMC-Aeronautics.git
```

### 3. Execute Automated Deployment Script

The large binary files (such as mods) for this project are hosted on the club's official CDN. We provide a one-click deployment script deploy.sh, which automatically synchronizes, extracts the latest configuration and modpacks, and starts the containers.

Navigate to the project root directory
```bash
cd USTCMC-Aeronautics/
```

Grant execution permissions to the script
```bash
chmod +x deploy.sh
```

Execute
```bash
./deploy.sh
```

Start containers
```bash
sudo docker compose up -d --remove-orphans
```

The first startup may take 3-5 minutes for loading and initialization, which is normal.

### 4. Firewall Settings

To allow players to connect normally, if you are using a cloud server, please ensure the following ports are permitted in your cloud provider's console:

TCP 25565: Velocity gateway main port

(Optional) UDP 25566-25567: Sable UDP port reservation

Docker ignores the UFW firewall by default. Therefore, for MC servers deployed with Docker, as long as the cloud server's security group is open, the external network can usually connect directly without configuring UFW.

### 5. Common Maintenance Commands

After deployment, you can use the following commands to monitor the server status:

View all running MC containers
```bash
docker ps | grep mc-
```

View Velocity proxy gateway real-time logs
```bash
docker logs -f mc-velocity
```

View survival server real-time logs
```bash
docker logs -f mc-survival
```

Completely shut down and destroy currently running containers (does not affect data volumes)
```bash
docker compose down
```



### 📂 Project Structure
```
.
├── docker-compose.yml       # Core container orchestration file
├── deploy.sh                # One-click update and deployment script
├── velocity/                # Proxy configuration (velocity.toml, forwarding.secret, etc.)
├── survival/                # Survival server configuration (server.properties, etc.)
└── creative/                # Creative server configuration

```