# VPS TCP Tune + Argo Toolkit

用于存放并后续融合两个上游一键脚本：

1. TCP 调优脚本：Eric86777/vps-tcp-tune
2. Argo 一键脚本：fscarmen/argox

## 当前可用功能

### TCP 一键全自动优化（仅保留原脚本菜单 66）

已单独整理为：

```text
scripts/tcp-one-click-optimize.sh
```

一键运行：

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/cshaizhihao/vps-tcp-argo-toolkit/main/scripts/tcp-one-click-optimize.sh)
```

功能来源于原 `net-tcp-tune.sh` 的菜单项：

```text
66. ⭐ 一键全自动优化 (BBR v3 + 网络调优)
```

执行逻辑保持原脚本一致：

- 如果当前不是 XanMod 内核：安装 XanMod + BBR v3，完成后提示重启
- 如果已经运行 XanMod 内核：自动执行网络优化流程
  - BBR 直连优化
  - DNS 净化
  - Realm 转发修复
  - 可选永久禁用 IPv6

> 当前版本只是把菜单 66 作为唯一入口暴露出来；内部仍保留原脚本依赖函数，避免抽取遗漏导致功能异常。

## 上游脚本归档

```text
scripts/upstream/
  vps-tcp-tune-install-alias.sh
  net-tcp-tune.sh
  argox.sh
```

## 原始安装命令

### TCP 调优脚本

```bash
bash <(curl -fsSL "https://raw.githubusercontent.com/Eric86777/vps-tcp-tune/main/install-alias.sh?$(date +%s)")
```

### Argo 一键脚本

```bash
bash <(wget -qO- https://raw.githubusercontent.com/fscarmen/argox/main/argox.sh) -l
```

## 后续计划

- 根据需求继续融合 Argo 功能
- 设计统一入口脚本
- 增加环境检测、参数菜单、日志、回滚/卸载说明
