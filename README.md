# Speed Slayer

**VPS 网络加速 · Argo 隧道 · VMess WebSocket**

Speed Slayer 是一个面向 VPS 的一键工具，用于完成：

- **BBR v3 / XanMod / TCP 智能调优**
- **Cloudflare Argo Tunnel + VMess WebSocket 节点部署**
- **订阅链接生成、诊断、日志、修复与重复安装清理**

项目地址：<https://github.com/cshaizhihao/speed-slayer>  
作者：NodeSeek @cshaizhihao  
当前版本：`v0.9.0-beta`

---

## 一键开始

```bash
curl -fsSL -H "Accept: application/vnd.github.raw" -H "Cache-Control: no-cache" "https://api.github.com/repos/cshaizhihao/speed-slayer/contents/scripts/vps-argo-vmess-oneclick.sh?ref=main&ts=$(date +%s)" -o /tmp/speed && bash /tmp/speed --all
```

`--all` 是安全主页模式，不会直接修改系统；选择完整流程后才会进入 TCP/Argo 部署。

安装快捷命令后，后续直接输入：

```bash
speed
```

---

## 常用命令

```bash
speed                  # 打开控制台；重启后自动续跑
speed --update-self    # 更新 speed 自身
speed --version        # 查看版本
speed --doctor         # 全链路诊断
speed --logs           # 查看日志菜单
speed --repair         # 清理残留并重装 Argo VMess+WS
speed --speedtest      # Ookla Speedtest 测速
speed --netcheck       # DNS / GitHub / Cloudflare / 出站连通性检测
```

---

## 控制台菜单

```text
『Speed Slayer 控制台』

1. 一键执行完整流程        2. 节点管理
3. TCP 加速                4. 诊断与日志
5. 修复与清理              6. 更新
0. 退出
```

---

## 完整流程

1. 安装 `speed` 快捷命令
2. 检测当前内核 / TCP 状态
3. 安装 XanMod / BBR v3 内核（如需要）
4. 提示确认重启，重启后输入 `speed` 自动续跑
5. 执行 TCP 智能调优
6. 部署 Argo VMess+WS
7. 生成 VMess URL 与订阅链接
8. 执行健康检查并输出结果页
9. 提示本地优选 Cloudflare CDN

---

## TCP 智能调优

进入 XanMod 内核后，Speed Slayer 会执行：

1. 检测内存 / SWAP
2. 执行 Speedtest 或读取手动带宽
3. 根据带宽、内存、地区计算 TCP buffer
4. 清理 sysctl 冲突项
5. 写入 BBR / FQ / TCP 参数
6. 应用网卡 FQ 队列、limits、DNS、IPv6 策略
7. 验证 BBR / FQ / buffer 状态

可手动指定带宽和地区：

```bash
SPEED_BANDWIDTH_MBPS=2000 SPEED_REGION=global speed --optimize
SPEED_AUTO_SPEEDTEST=0 speed --optimize
```

带宽来源会明确显示：

- `measured`：Ookla Speedtest 实测
- `manual`：手动指定
- `default`：测速失败或关闭测速后回退默认值

---

## Argo VMess+WS

Speed Slayer 自动部署：

- `cloudflared`
- `Xray VMess + WebSocket`
- `Nginx WebSocket 反代与订阅接口`
- `systemd` 服务
- VMess URL / Base64 / Clash / Shadowrocket / Auto 订阅

重复安装前会自动清理旧服务、旧进程、旧配置，并备份 `/etc/argox`。

---

## 日志位置

```text
/etc/vps-argo-vmess/install.log
/etc/vps-argo-vmess/kernel-install.log
/etc/vps-argo-vmess/tcp-optimize.log
/etc/vps-argo-vmess/speedtest.log
/etc/vps-argo-vmess/netcheck.log
/etc/argox/argo.log
/etc/argox/xray-error.log
```

查看日志：

```bash
speed --logs
speed --logs tcp
speed --logs argo
speed --logs xray
```

---

## 更新

推荐：

```bash
speed --update-self
```

如果本机脚本损坏，可强制覆盖：

```bash
curl -fsSL -H "Accept: application/vnd.github.raw" -H "Cache-Control: no-cache" "https://api.github.com/repos/cshaizhihao/speed-slayer/contents/scripts/vps-argo-vmess-oneclick.sh?ref=main&ts=$(date +%s)" -o /usr/local/bin/speed && chmod +x /usr/local/bin/speed
```

---

## Beta 状态

当前版本：`v0.9.0-beta`

已具备主流程能力，建议继续进行多系统实机回归：

- Debian 12
- Ubuntu 22.04 / 24.04
- 1C1G / 1C2G 小内存机器
- 重复安装 / 残留环境

---

## License

MIT or repository default license. See repository files for details.
