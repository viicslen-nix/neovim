{
  config.vim = {
    lsp.mappings = {
      goToDeclaration = "<leader>gD";
      goToDefinition = "<leader>gd";
      goToType = "<leader>gt";
      hover = "<leader>h";
      listImplementations = "<leader>gi";
      listReferences = "<leader>gr";
    };

    tabline.nvimBufferline.mappings = {
      closeCurrent = "<leader>q";
      cycleNext = "<Tab>";
      cyclePrevious = "<S-Tab>";
    };

    assistant.copilot.mappings = {
      suggestion.acceptLine = "<M-L>";
    };

    comments.comment-nvim.mappings = {
      toggleCurrentLine = "<C-/>";
      toggleCurrentBlock = "<C-?>";
      toggleSelectedLine = "<C-/>";
      toggleSelectedBlock = "<C-?>";
      toggleOpLeaderLine = "<leader>/";
      toggleOpLeaderBlock = "<leader>?";
    };

    keymaps = [
      {
        key = "<C-s>";
        mode = ["n" "v" "i"];
        action = "<ESC>:w<CR>";
        desc = "Save file";
        silent = true;
        unique = false;
        noremap = true;
      }
      {
        key = "<leader>;";
        mode = ["n"];
        action = "<S-a>;<ESC>";
        desc = "Insert semicolon";
        noremap = true;
      }
      {
        key = "<leader>,";
        mode = ["n"];
        action = "<S-a>,<ESC>";
        desc = "Insert comma";
        noremap = true;
      }
      {
        key = ">";
        mode = ["v"];
        action = ">gv";
        desc = "Indent selection";
        noremap = true;
      }
      {
        key = "<";
        mode = ["v"];
        action = "<gv";
        desc = "Unindent selection";
        noremap = true;
      }

      # Laravel
      {
        key = "<leader>lla";
        action = ":Laravel artisan<cr>";
        desc = "Laravel Artisan";
        mode = "n";
      }
      {
        key = "<leader>llr";
        action = ":Laravel routes<cr>";
        desc = "Laravel Routes";
        mode = "n";
      }
      {
        key = "<leader>llm";
        action = ":Laravel related<cr>";
        desc = "Laravel Related";
        mode = "n";
      }
      {
        key = "gf";
        action = ''
          function()
            if require("laravel").app("gf").cursor_on_resource() then
              return "<cmd>Laravel gf<CR>"
            else
              return vim.lsp.buf.definition and "<cmd>lua vim.lsp.buf.definition()<CR>" or "gf"
            end
          end
        '';
        lua = true;
        noremap = false;
        expr = true;
        mode = "n";
      }

      # Worktrees
      {
        key = "<leader>gws";
        action = ''
          function()
            require("telescope").extensions.worktrees.list_worktrees(opts)
          end
        '';
        desc = "Worktrees picker";
        lua = true;
        mode = "n";
      }
      {
        key = "<leader>gwc";
        action = ":GitWorktreeCreate<CR>";
        desc = "New worktree";
        mode = "n";
      }
      {
        key = "<leader>gwa";
        action = ":GitWorktreeCreateExisting<CR>";
        desc = "Creating worktree for existing branch";
        mode = "n";
      }
    ];
  };
}
