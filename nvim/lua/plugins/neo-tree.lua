return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    opts = {
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        window = {
          mappings = {
            ["<RightMouse>"] = function(state)
              local commands =
                  require("neo-tree.sources.filesystem.commands")

              vim.ui.select({
                "Copy",
                "Cut",
                "Paste",
                "Rename",
                "Delete",
              }, {
                prompt = "File actions",
              }, function(choice)
                if not choice then
                  return
                end

                local actions = {
                  Copy = commands.copy_to_clipboard,
                  Cut = commands.cut_to_clipboard,
                  Paste = commands.paste_from_clipboard,
                  Rename = commands.rename,
                  Delete = commands.delete,
                }

                actions[choice](state)
              end)
            end,
          },
        },
      },
    },
  },
}
