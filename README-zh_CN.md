# USTCMC Aeronautics Server Network

**Built with Velocity and Docker by miaoning.**

<br><br>

## 部署指南

### 1. 安装 Docker

首先，安装 Docker 引擎以及必需的系统工具：

更新系统软件包
```bash
sudo apt-get update     # Ubuntu
sudo yum update         # CentOS
```

安装 Git, Curl 等基础工具
```bash
sudo apt-get install -y git curl wget   # Ubuntu
sudo yum install -y git curl wget       # CentOS
```

使用官方一键脚本安装 Docker
```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

设置开机自启
```bash
systemctl start docker
systemctl enable docker
```

安装 Docker Compose 插件
```bash
sudo apt-get install -y docker-compose-plugin   # Ubuntu
sudo yum install -y docker-compose-plugin       # CentOS
```

验证安装成功
```bash
docker --version
docker compose version
```
如果成功显示 docker 版本号，则说明安装成功。

将当前用户加入 docker 组 (免 sudo 执行 docker 命令)
```bash
sudo usermod -aG docker $USER
```
注意：执行完上一句后，建议退出终端重新 SSH 连接以使权限生效。

### 2. 获取项目配置

创建并转到项目目录

```bash
sudo mkdir Aeronautics_network_server
sudo chown -R $USER:$USER Aeronautics_network_server
cd Aeronautics_network_server
```

将本仓库克隆到服务器的根目录

```bash
git clone https://github.com/Miaoning-exe/USTCMC-Aeronautics.git
```

### 3. 执行自动化部署脚本
本项目的大体积二进制文件（比如 mods）已托管至社团官网 CDN。我们提供了一键部署脚本 deploy.sh，它会自动完成最新配置和模组包的同步、解压及容器启动。

转到项目根目录
```bash
cd USTCMC-Aeronautics/
```

赋予脚本执行权限
```bash
chmod +x deploy.sh
```

执行
```bash
./deploy.sh
```

启动容器
```bash
sudo docker compose up -d --remove-orphans
```

首次启动可能需要 3-5 分钟进行加载和初始化，这是正常的。

### 4. 防火墙设置
为了让玩家能够正常连接，如果你使用的是云服务器，请确保服务器所在的云服务商控制台放行了以下端口：

- TCP 25565: Velocity 网关主端口

- (可选) UDP 25566-25567: Sable UDP端口预留

Docker 默认会无视 UFW 防火墙。因此，对于 Docker 部署的 MC 服务器，只要云服务器安全组开放了，外网通常就能直接连入，无需配置 UFW。




### 5. 常用运维指令
部署完成后，你可以使用以下指令监控服务器状态：

查看所有运行中的 MC 容器
```bash
docker ps | grep mc-
```

查看 Velocity 代理网关实时日志
```bash
docker logs -f mc-velocity
```

查看生存服实时日志
```bash
docker logs -f mc-survival
```

彻底关闭并销毁当前运行的容器（不影响数据卷）
```bash
docker compose down
```



## 📂 项目结构
```
.
├── docker-compose.yml       # 核心容器编排文件
├── deploy.sh                # 一键更新与部署脚本
├── velocity/                # 代理端配置 (velocity.toml, forwarding.secret 等)
├── survival/                # 生存服配置 (server.properties 等)
└── creative/                # 创造服配置
```