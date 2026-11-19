# Dotfiles

我的 Git、Zsh 和 VS Code 配置，使用 GNU Stow 将仓库中的文件链接到用户目录。

## 配置索引

| 配置包 | Stow 目标目录 |
| --- | --- |
| [`git/`](#git) | `~/` |
| [`zsh/`](#zsh) | `~/` |
| [`vscode/`](#vs-code) | `~/.config/Code/User/` |

### Git

- [`.gitconfig`](git/.gitconfig) 将新仓库的默认分支设为 `main`，并设置换行符处理和终端颜色。它还会读取 `~/.gitconfig.local`，供本机设置用户名和邮箱。

### Zsh

- [`.zshrc`](zsh/.zshrc) 是交互式 Zsh 的启动入口，加载 `.zshrc.custom.zsh`，并保留软件安装器写入的设置，例如 Codex 的 `PATH` 配置。
- [`.zshrc.custom.zsh`](zsh/.zshrc.custom.zsh) 管理命令历史、补全缓存、快捷键和别名，也负责初始化 Antidote 和 Powerlevel10k 提示符。
- [`.zsh_plugins.txt`](zsh/.zsh_plugins.txt) 是 Antidote 的插件清单，包含 Powerlevel10k、命令补全、历史建议、语法高亮和目录跳转等插件。
- [`.p10k.zsh`](zsh/.p10k.zsh) 定义 Powerlevel10k 提示符的布局和样式，包括当前目录、Git 状态和命令执行耗时。

#### 插件加载顺序

Antidote 根据插件清单生成两份脚本，将补全目录和其余插件分开加载。

1. **注册补全目录。** 加载标有 `kind:fpath` 的条目，把目录加入 Zsh 的补全搜索路径 `fpath`。
2. **初始化补全。** 运行 `compinit`，在缓存有效时复用缓存。
3. **加载其余插件。** 此时 `compdef` 已可用，依赖它的插件可以注册自己的补全规则。

### VS Code

- [`settings.json`](vscode/settings.json) 设置编辑器字体、字号和 Light Modern 主题，也调整文件资源管理器的确认提示、差异视图和 Markdown 预览字号。

## 部署

1. 在 Debian 上安装 Git、Zsh 和 GNU Stow。

   ```sh
   sudo apt install git zsh stow
   ```

2. 如果还没有安装 Antidote，将它克隆到 `~/.antidote`。本仓库的 Zsh 配置会从这里加载它。[Antidote 安装文档](https://antidote.sh/install)

   ```sh
   git clone --depth=1 https://github.com/mattmc3/antidote.git "$HOME/.antidote"
   ```

3. 如果链接目标已有同名配置，先检查并备份，再处理冲突。随后在仓库根目录创建 VS Code 的目标目录并运行部署脚本。

   ```sh
   mkdir -p "$HOME/.config/Code/User"
   bash bootstrap.sh
   ```
