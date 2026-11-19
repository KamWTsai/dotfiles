# 仓库维护约定

- Stow 包及其部署目标以 `bootstrap.sh` 为准。新增或移除部署包、调整部署目标时，同步更新 `README.md`。
- `git/.gitconfig` 存放通用设置。将 `user.name`、`user.email` 等本机设置放在 `~/.gitconfig.local`，保留通用配置中对它的引用。
