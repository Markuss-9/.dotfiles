# Stow

Using stow to automatically install configuration packages, it doesnt install programs but it only creates symlinks of the configuration files.
Naming convention: `<package name>/<directory>` for example `nvim/.config/nvim` because nvim is inside `.config/nvim`



## Hyprland

Use `web` command to see the key events from Wayland.
DON'T USE `sudo showkey`, runs in Linux console giving the raw kernel keycode (not correct for hyprland)


## Others

Run the following command to let all shell files executable

```bash
find . -type f -name "*.sh" -exec chmod +x {} +
```


# WIP debuggers


https://github.com/mfussenegger/nvim-dap

https://github.com/rcarriga/nvim-dap-ui
