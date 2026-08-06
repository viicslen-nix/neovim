{
  worktrees-nvim,
  neotest-pest,
  laravel-nvim,
  mcphub-nvim,
  mcp-hub,
  laravel-lsp,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./keybinds.nix
  ];
  config = {
    vim = {
      viAlias = true;
      vimAlias = true;
      hideSearchHighlight = true;
      syntaxHighlighting = true;
      undoFile.enable = true;
      withNodeJs = true;

      options = {
        shiftwidth = 4;
        tabstop = 4;
      };

      spellcheck = {
        enable = false;
        languages = ["en" "es"];
      };

      # LSP
      languages = {
        enableDAP = true;
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        bash.enable = true;
        clang.enable = true;
        css.enable = true;
        go.enable = true;
        hcl.enable = true;
        html.enable = true;
        lua.enable = true;
        markdown.enable = true;
        nix.enable = true;
        nu.enable = true;
        python.enable = true;
        sql.enable = true;
        tailwind.enable = true;
        terraform.enable = true;
        zig.enable = true;
        php = {
          enable = true;
          lsp.servers = ["intelephense"];
        };

        ts = {
          enable = true;
          extensions.ts-error-translator.enable = true;
        };
      };

      lsp = {
        enable = true;
        lightbulb.enable = true;
        lspSignature.enable = true;
        lspkind.enable = true;
        otter-nvim.enable = true;
        trouble.enable = true;

        # Laravel LSP (framework-aware; runs alongside intelephense)
        lspconfig.sources.laravel-lsp = ''
          vim.lsp.config('laravel_lsp', {
            cmd = { 'laravel-lsp' },
            filetypes = { 'php', 'blade' },
            root_markers = { 'artisan', 'composer.json', '.git' },
            capabilities = capabilities,
          })
          vim.lsp.enable('laravel_lsp')
        '';

        # lspconfig.sources.phpactor = mkForce ''
        #   lspconfig.phpactor.setup {
        #     capabilities = capabilities,
        #     on_attach = default_on_attach,
        #     cmd = {
        #       "${getExe pkgs.phpactor}",
        #       "language-server"
        #     },
        #   }
        # '';
      };

      formatter.conform-nvim = {
        enable = true;
        setupOpts = {
          formatters_by_ft = {
            php = ["pint"];
          };
        };
      };

      # UI
      ui = {
        borders.enable = true;
        nvim-ufo.enable = true;
        colorizer.enable = true;
        illuminate.enable = true;
        fastaction.enable = true;
        modes-nvim.enable = true; # Look
        smartcolumn.enable = true;

        breadcrumbs = {
          enable = true;
          navbuddy.enable = true;
        };
      };

      theme = {
        enable = true;
        name = "onedark";
        style = "darker";
        transparent = true;
      };

      # Plugins
      telescope = {
        enable = true;
        setupOpts.pickers.find_files = {
          hidden = true;
          no_ignore = true;
        };
        extensions = [
          {
            name = "worktrees";
            packages = [worktrees-nvim];
          }
        ];
      };

      treesitter = {
        fold = true;
        autotagHtml = true;
        context.enable = true;
        indent.enable = true;
      };

      autocomplete = {
        enableSharedCmpSources = true;
        nvim-cmp.enable = true;
      };

      dashboard.alpha.enable = true;
      autopairs.nvim-autopairs.enable = true;
      projects.project-nvim.enable = true;
      runner.run-nvim.enable = true;
      statusline.lualine.enable = true;
      tabline.nvimBufferline.enable = true;
      comments.comment-nvim.enable = true;
      snippets.luasnip.enable = true;
      diagnostics.enable = true;

      notify.nvim-notify = {
        enable = true;
        setupOpts = {
          background_colour = "#000000";
        };
      };

      utility = {
        mkdir.enable = true;
        direnv.enable = true;
        surround.enable = true;
        motion.leap.enable = true;
        multicursors.enable = true;
        vim-wakatime.enable = true;
        outline.aerial-nvim.enable = true;
        preview.markdownPreview.enable = true;

        snacks-nvim = {
          enable = true;
          setupOpts = {
            lazygit.configure = true;
            explorer.replace_netrw = true;
            input = lib.mkLuaInline "{}";
            quickfile = lib.mkLuaInline "{}";
            picker.sources.explorer = lib.mkLuaInline "{}";
          };
        };
      };

      visuals = {
        cinnamon-nvim.enable = true;
        indent-blankline.enable = true;
        nvim-scrollbar.enable = true;
        nvim-web-devicons.enable = true;

        nvim-cursorline = {
          enable = true;
          setupOpts = {
            cursorword.enable = true;
            cursorline.enable = true;
          };
        };
      };

      assistant = {
        copilot = {
          enable = true;
          cmp.enable = true;
        };
        avante-nvim = {
          enable = true;
          setupOpts = {
            provider = "copilot";
            cursor_applying_provider = "copilot";
            auto_suggestions_provider = "copilot";
            enable_cursor_planning_mode = true;
            enable_claude_text_editor_tool_mode = true;
            behaviour.auto_suggestions = false;
            selector = {
              exclude_auto_select = ["NvimTree"];
            };
            system_prompt = lib.mkLuaInline ''
              function()
                local hub = require("mcphub").get_hub_instance()
                return hub and hub:get_active_servers_prompt() or ""
              end
            '';
            custom_tools = lib.mkLuaInline ''
              function()
                return {
                    require("mcphub.extensions.avante").mcp_tool(),
                }
              end
            '';
          };
        };
      };

      binds = {
        cheatsheet.enable = true;
        hardtime-nvim = {
          enable = true;
          setupOpts = {
            disable_mouse = false;
            restriction_mode = "hint";
            force_exit_insert_mode = true;
            disabled_keys = lib.mkLuaInline "{}";
          };
        };

        whichKey = {
          enable = true;
          setupOpts.preset = "helix";
        };
      };

      debugger.nvim-dap = {
        enable = true;
        ui.enable = true;
      };

      filetree.nvimTree = {
        enable = true;
        openOnSetup = false;
        setupOpts = {
          git.enable = true;
          modified.enable = true;
          hijack_cursor = true;
          renderer.highlight_opened_files = "all";
          view.cursorline = true;
        };
      };

      git = {
        enable = true;
        vim-fugitive.enable = true;
        git-conflict.enable = true;
        gitlinker-nvim.enable = true;
        gitsigns = {
          enable = true;
          codeActions.enable = true;
        };
      };

      terminal.toggleterm = {
        enable = true;
        lazygit.enable = true;
      };

      lazy.plugins = with pkgs.vimPlugins; {
        "harpoon" = {
          package = harpoon;
          setupModule = "harpoon";
          setupOpts = {};
          lazy = true;
        };

        "neotest" = {
          package = neotest;
          setupModule = "neotest";
          setupOpts = {};
          lazy = true;
        };

        "neotest-pest" = {
          package = neotest-pest;
          setupModule = "neotest-pest";
          setupOpts = {};
          lazy = true;
        };

        "laravel.nvim" = {
          package = laravel-nvim;
          setupModule = "laravel";
          cmd = ["Laravel"];
          lazy = true;
          setupOpts = {
            lsp_server = "intelephense";
          };
        };

        "worktrees.nvim" = {
          package = worktrees-nvim;
          setupModule = "worktrees";
          setupOpts = {};
          lazy = true;
        };

        "mcphub.nvim" = {
          package = mcphub-nvim;
          setupModule = "mcphub";
          setupOpts = {
            workspace = {
              enabled = true;
              look_for = [".mcphub/servers.json" ".vscode/mcp.json" ".cursor/mcp.json"];
              reload_on_dir_changed = true;
              port_range = {
                min = 40000;
                max = 41000;
              };
              get_port = lib.mkLuaInline "nil";
            };
            extensions = {
              avante = {
                make_slash_commands = true;
              };
            };
          };
        };
      };

      extraPackages = [
        mcp-hub
        laravel-lsp
      ];
    };
  };
}
