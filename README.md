# USTCMC Aeronautics Server Network

**Built with velocity and docker by miaoning.**

## Getting Started

### Install Docker 

首先，安装 Docker 引擎以及必需的系统工具：

更新系统软件包
```bash
sudo apt-get update
```

安装 Git, Curl 等基础工具
```bash
sudo apt-get install -y git curl wget
```

使用官方一键脚本安装 Docker
```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

安装 Docker Compose 插件
```bash
sudo apt-get install -y docker-compose-plugin
```

将当前用户加入 docker 组 (免 sudo 执行 docker 命令)
```bash
sudo usermod -aG docker $USER
```
注意：执行完上一句后，建议退出终端重新 SSH 连接以使权限生效！

2. Clone the Repository
将本仓库克隆到服务器的工作目录

```bash
sudo mkdir -p /opt/Aeronautics_network_server
cd /opt/Aeronautics_network_server
```

```bash
# 替换为你的实际 Git 仓库地址
git clone <你的仓库地址> .
```

3. Automated Deployment
本项目的大体积二进制文件（如 mods/）已托管至社团官网 CDN。我们提供了一键部署脚本 deploy.sh，它会自动完成最新配置和模组包的同步、解压及容器启动。

```bash
# 赋予脚本执行权限
chmod +x deploy.sh

# 执行部署
./deploy.sh
```

脚本执行成功后，所有容器将在后台自动拉起。首次启动子服可能需要 3-5 分钟来生成世界和加载航空学模组。

4. 防火墙与安全配置 (Security & Networking)
为了让玩家能够正常连接，请确保服务器所在的云服务商控制台（或系统自带的 UFW 防火墙）放行了以下端口：

TCP 25565: Velocity 网关主端口（玩家进服唯一入口）

(可选) UDP 25566-25567: Sable 物理网络同步端口预留

5. 常用运维指令 (Maintenance Commands)
部署完成后，你可以使用以下指令监控服务器状态：

```bash
# 查看所有运行中的 MC 容器
docker ps | grep mc-

# 查看 Velocity 代理网关实时日志
docker logs -f mc-velocity

# 查看 生存服(Survival) 实时日志
docker logs -f mc-survival

# 彻底关闭并销毁当前运行的容器（不影响数据卷）
docker compose down
```



📂 目录结构说明
```
.
├── docker-compose.yml       # 核心容器编排文件
├── deploy.sh                # 一键更新与部署脚本
├── velocity/                # 代理端配置 (velocity.toml, forwarding.secret 等)
├── survival/                # 生存服配置 (server.properties 等)
└── creative/                # 创造服配置
```