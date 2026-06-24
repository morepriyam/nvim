# Neovim Keymaps & Motions Cheatsheet

Complete reference for this Neovim setup. Covers:

1. [Basic Vim Motions](#1-basic-vim-motions) — the built-in language of movement & editing
2. [Custom Keymaps](#2-custom-keymaps-this-config) — what *you* defined in this config
3. [Plugin Keymaps](#3-plugin-keymaps) — leader-driven bindings from your plugins
4. [Plugin Default Keymaps](#4-plugin-default-keymaps) — defaults you get "for free"
5. [tmux Keybindings](#5-tmux-keybindings) — your terminal multiplexer layer

> **Leader key** = `<Space>`. So `<leader>ff` means `Space` then `f` then `f`.
> Press `<leader>?` anytime to see buffer-local keymaps via which-key.

---

## 1. Basic Vim Motions

These are **built into Vim/Neovim** — no config needed. The grammar is
`operator` + `count` + `motion` (e.g. `d2w` = delete 2 words).

### Modes

| Key | Action |
|-----|--------|
| `i` | Insert before cursor |
| `a` | Insert (append) after cursor |
| `I` | Insert at first non-blank of line |
| `A` | Append at end of line |
| `o` | Open new line below + insert |
| `O` | Open new line above + insert |
| `v` | Visual (character) mode |
| `V` | Visual line mode |
| `<C-v>` | Visual block mode |
| `R` | Replace mode |
| `<Esc>` | Return to Normal mode |
| `:` | Command-line mode |

### Horizontal motion

| Key | Action |
|-----|--------|
| `h` / `l` | Left / right |
| `0` | Start of line |
| `^` | First non-blank char |
| `$` | End of line |
| `w` / `W` | Next word / WORD start |
| `e` / `E` | Next word / WORD end |
| `b` / `B` | Previous word / WORD start |
| `ge` | Previous word end |
| `f{c}` / `F{c}` | Jump to next/prev char `c` on line |
| `t{c}` / `T{c}` | Jump till before next/prev char `c` |
| `;` / `,` | Repeat last `f/t` forward / backward |

> **word** = stops at punctuation. **WORD** (capital) = whitespace-delimited only.

### Vertical motion

| Key | Action |
|-----|--------|
| `j` / `k` | Down / up |
| `gg` | Top of file |
| `G` | Bottom of file |
| `{count}G` | Go to line number |
| `{` / `}` | Previous / next paragraph |
| `H` / `M` / `L` | Top / middle / bottom of screen |
| `<C-d>` / `<C-u>` | Half-page down / up *(remapped to recenter — see §2)* |
| `<C-f>` / `<C-b>` | Full page forward / back |
| `<C-e>` / `<C-y>` | Scroll line down / up |
| `zz` / `zt` / `zb` | Center / top / bottom current line on screen |

### Within-line jumps & search

| Key | Action |
|-----|--------|
| `%` | Jump to matching bracket `()[]{}` |
| `*` / `#` | Search word under cursor forward / back |
| `/{pat}` / `?{pat}` | Search forward / back |
| `n` / `N` | Next / previous match |
| `''` / `` `` `` | Jump back to last position |
| `<C-o>` / `<C-i>` | Jump list: older / newer position |

### Operators (combine with motions)

| Key | Action |
|-----|--------|
| `d` | Delete |
| `c` | Change (delete + insert) |
| `y` | Yank (copy) |
| `>` / `<` | Indent / dedent |
| `=` | Auto-format/indent |
| `gu` / `gU` | Lowercase / uppercase |
| `g~` | Toggle case |

Common combos: `dw` (del word), `cw` (change word), `dd` (del line),
`yy` (yank line), `cc` (change line), `d$`/`D` (del to EOL), `c$`/`C` (change to EOL),
`y$` (yank to EOL), `dG` (del to end of file), `dgg` (del to start).

### Text objects (use with operators: `d`, `c`, `y`, `v`)

| Object | Meaning |
|--------|---------|
| `iw` / `aw` | Inner / a word |
| `is` / `as` | Inner / a sentence |
| `ip` / `ap` | Inner / a paragraph |
| `i"` / `a"` | Inside / around double quotes |
| `i'` `i\`` | Inside single quote / backtick |
| `i(` `i)` `ib` | Inside parentheses |
| `i{` `i}` `iB` | Inside braces |
| `i[` / `i]` | Inside brackets |
| `i<` / `i>` | Inside angle brackets |
| `it` / `at` | Inner / around HTML/XML tag |

Examples: `ciw` (change word), `di"` (delete inside quotes),
`ya(` (yank around parens), `vip` (select paragraph), `cit` (change tag contents).

### Editing & misc

| Key | Action |
|-----|--------|
| `x` / `X` | Delete char under / before cursor |
| `r{c}` | Replace single char with `c` |
| `s` | Substitute char (delete + insert) |
| `~` | Toggle case of char |
| `J` | Join line below into current |
| `p` / `P` | Paste after / before cursor |
| `u` | Undo |
| `<C-r>` | Redo |
| `.` | Repeat last change |
| `>>` / `<<` | Indent / dedent line |
| `==` | Auto-indent line |

### Registers, marks, macros

| Key | Action |
|-----|--------|
| `"{r}y` / `"{r}p` | Yank/paste using register `r` |
| `"+y` / `"+p` | Yank/paste system clipboard *(default here — see §2)* |
| `"0p` | Paste last yank (unaffected by deletes) |
| `m{a}` | Set mark `a` |
| `` `{a} `` / `'{a}` | Jump to mark `a` (exact / line) |
| `q{a}` … `q` | Record macro into register `a` |
| `@{a}` / `@@` | Play macro `a` / replay last |

### Window / split commands

| Key | Action |
|-----|--------|
| `<C-w>s` / `<C-w>v` | Split horizontal / vertical |
| `<C-w>w` | Cycle windows |
| `<C-w>q` | Close window |
| `<C-w>=` | Equalize sizes |
| `<C-w>h/j/k/l` | Move to window *(remapped for tmux — see §3)* |

---

## 2. Custom Keymaps (this config)

Defined in [`lua/options.lua`](lua/options.lua).

### Files & quitting

| Key | Mode | Action |
|-----|------|--------|
| `<leader>w` | n | Save (`:w`) |
| `<leader>q` | n | Quit (`:q`) — warns on unsaved changes |
| `<leader>Q` | n | Force quit, discard changes (`:q!`) |
| `<leader>x` | n | Save and quit (`:x`) |

### Scrolling (recentered)

| Key | Mode | Action |
|-----|------|--------|
| `<C-u>` | n | Half-page up **+ recenter** (`<C-u>zz`) |
| `<C-d>` | n | Half-page down **+ recenter** (`<C-d>zz`) |

### Display & terminal

| Key | Mode | Action |
|-----|------|--------|
| `<leader>W` | n | Toggle line wrap |
| `<Esc><Esc>` | t | Exit terminal mode (double-tap; single `<Esc>` passes through to the program) |

### Behavioral defaults set here

- **System clipboard** is the default register — `y`/`p`/`d` use `"+` automatically (`clipboard = "unnamedplus"`).
- **Relative + absolute line numbers** are on (hybrid numbering).
- **Mouse** enabled in all modes; right-click opens a popup menu.
- **Auto-reload**: buffers refresh from disk on focus/idle (handy when Claude edits files); a notification fires on reload.

### Right-click popup menu (LSP actions on symbol under cursor)

Go to Definition · Find References · Rename Symbol · Code Action

---

## 3. Plugin Keymaps

### LSP — active when a language server attaches ([lsp-config.lua](lua/plugins/lsp-config.lua))

| Key | Mode | Action |
|-----|------|--------|
| `K` | n | Hover documentation |
| `gd` | n | Go to definition |
| `gi` | n | Go to implementation |
| `gr` | n | References (Telescope) |
| `<leader>ca` | n, v | Code action |
| `<leader>rn` | n | Rename symbol |
| `<leader>ih` | n | Toggle inlay hints |
| `<leader>e` | n | Show full error/warning message at cursor (float) |

> In **Rust** files, `K` shows hover *with actions* and `<leader>ca` uses rustaceanvim's grouped code actions.

### Diagnostics / Problems — Trouble ([trouble.lua](lua/plugins/trouble.lua))

| Key | Action |
|-----|--------|
| `<leader>xx` | Toggle all problems across the workspace |
| `<leader>xX` | Toggle problems in the current file only |
| `<leader>xs` | Toggle document symbols outline |
| `<leader>xq` | Toggle quickfix list |
| `<leader>xl` | Toggle location list |
| `]d` / `[d` | Jump to next / previous diagnostic (built-in) |
| `<leader>e` | Float showing the full message at cursor (built-in) |

### Formatting — none-ls ([none-ls.lua](lua/plugins/none-ls.lua))

| Key | Mode | Action |
|-----|------|--------|
| `<leader>cf` | n | Format buffer |
| `<leader>cF` | n | Format whole project |

### Find / Pickers — Telescope ([telescope.lua](lua/plugins/telescope.lua))

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fs` | Grep for an input string |
| `<leader>fr` | Recent files |
| `<leader>fb` | Open buffers |
| `<leader>fh` | Help tags |
| `<leader>f/` | Fuzzy find in current buffer |

### File tree — Neo-tree ([neotree.lua](lua/plugins/neotree.lua))

| Key | Action |
|-----|--------|
| `<leader>n` | Toggle file explorer |
| `<leader>gt` | Toggle git-status tree |

### Buffers / tabs — Bufferline ([bufferline.lua](lua/plugins/bufferline.lua))

| Key | Action |
|-----|--------|
| `]b` | Next buffer |
| `[b` | Previous buffer |
| `<leader>bd` | Close buffer |
| `<leader>bp` | Pin / unpin buffer |

### Git hunks — Gitsigns ([gitsigns.lua](lua/plugins/gitsigns.lua))

| Key | Action |
|-----|--------|
| `]c` / `[c` | Next / previous hunk |
| `<leader>hs` / `<leader>hr` | Stage / reset hunk |
| `<leader>hS` / `<leader>hR` | Stage / reset whole buffer |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line (full) |
| `<leader>hd` | Diff this file |
| `<leader>tb` | Toggle inline line blame |

### Git — Fugitive ([fugitive.lua](lua/plugins/fugitive.lua))

| Key | Mode | Action |
|-----|------|--------|
| `<leader>gs` | n | Git status (fugitive hub) |
| `<leader>gc` | n | Git commit |
| `<leader>gd` | n | Git diff (vertical split) |
| `<leader>gb` | n | Git blame |
| `<leader>gl` | n | Git log (graph) |
| `<leader>gp` | n | Git push |
| `<leader>gP` | n | Git pull (rebase) |
| `<leader>gf` | n | Git fetch |
| `<leader>ga` | n | Git add all changes |
| `<leader>gw` | n | Stage current file (`:Gwrite`) |
| `<leader>gr` | n | Discard current file (`:Gread`) |
| `<leader>ge` | n | Back to working copy (`:Gedit`) |
| `<leader>gB` | n, v | Open file/line on GitHub |
| `<leader>gh` | n | Merge conflict: take left (HEAD) |
| `<leader>gm` | n | Merge conflict: take right (incoming) |

### Git — Neogit & Diffview

| Key | Action |
|-----|--------|
| `<leader>gg` | Neogit source-control panel |
| `<leader>gv` | Diffview: all changes |
| `<leader>gV` | Diffview: close |
| `<leader>gH` | Diffview: current file history |
| `<leader>gG` | Diffview: branch/repo history |

### Debug — DAP ([dap.lua](lua/plugins/dap.lua))

| Key | Action |
|-----|--------|
| `<F5>` | Continue / start |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F9>` | Step out |
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>dr` | Toggle REPL |
| `<leader>dl` | Run last |
| `<leader>du` | Toggle DAP UI |
| `<leader>dt` | Terminate |

### Rust — rustaceanvim ([rustaceanvim.lua](lua/plugins/rustaceanvim.lua))

| Key | Action |
|-----|--------|
| `<leader>rr` | Runnables |
| `<leader>rd` | Debuggables |
| `<leader>rm` | Expand macro |

### Java tests — jdtls (Java buffers only)

| Key | Action |
|-----|--------|
| `<leader>df` | Test class |
| `<leader>dn` | Test nearest method |

### AI — Claude Code ([claudecode.lua](lua/plugins/claudecode.lua))

| Key | Mode | Action |
|-----|------|--------|
| `<leader>ac` | n | Toggle Claude |
| `<leader>af` | n | Focus Claude |
| `<leader>ar` | n | Resume Claude |
| `<leader>aC` | n | Continue Claude |
| `<leader>am` | n | Select model |
| `<leader>ab` | n | Add current buffer to context |
| `<leader>as` | v | Send selection to Claude |
| `<leader>as` | tree | Add file from tree |
| `<leader>aa` | n | Accept diff |
| `<leader>ad` | n | Deny diff |

### Typing practice — typr

| Key | Action |
|-----|--------|
| `<leader>tp` | Typing practice |
| `<leader>ts` | Typing stats |

### Help

| Key | Action |
|-----|--------|
| `<leader>?` | Show buffer-local keymaps (which-key) |

---

## 4. Plugin Default Keymaps

Bindings you get "for free" from plugins without explicit config.

### Completion — nvim-cmp (insert mode, when menu is open)

| Key | Action |
|-----|--------|
| `<C-Space>` | Trigger completion |
| `<CR>` | Confirm selected item |
| `<C-e>` | Abort / close menu |
| `<C-b>` / `<C-f>` | Scroll docs up / down |
| `<C-n>` / `<C-p>` | Next / previous item (cmp default) |

### Copilot — copilot.vim (insert mode)

| Key | Action |
|-----|--------|
| `<Tab>` | Accept suggestion |
| `<M-]>` / `<M-[>` | Next / previous suggestion |
| `<M-\>` | Manually trigger |
| `<C-]>` | Dismiss suggestion |

Commands: `:Copilot setup`, `:Copilot enable`, `:Copilot disable`, `:Copilot panel`.

### Neo-tree (inside the tree window)

| Key | Action |
|-----|--------|
| `<CR>` / `o` | Open file/folder |
| `s` / `S` | Open in vertical / horizontal split |
| `a` | Add file/folder (end with `/` for dir) |
| `d` | Delete |
| `r` | Rename |
| `c` / `m` | Copy / move |
| `x` / `p` | Cut / paste |
| `y` | Copy to clipboard |
| `H` | Toggle hidden files |
| `R` | Refresh |
| `?` | Show all neo-tree mappings |
| `q` | Close window |

### Telescope (inside a picker)

| Key | Mode | Action |
|-----|------|--------|
| `<C-n>` / `<C-p>` | i | Next / previous result |
| `<C-j>` / `<C-k>` | i | Next / previous result |
| `<CR>` | i | Open selection |
| `<C-x>` / `<C-v>` | i | Open in horizontal / vertical split |
| `<C-t>` | i | Open in new tab |
| `<C-u>` / `<C-d>` | i | Scroll preview up / down |
| `<C-q>` | i | Send results to quickfix |
| `<Esc>` | i | Switch to normal mode in picker |
| `q` | n | Close picker |

### Fugitive status window (`<leader>gs`)

| Key | Action |
|-----|--------|
| `s` / `u` | Stage / unstage item under cursor |
| `=` | Toggle inline diff |
| `cc` | Create commit |
| `ca` | Amend commit |
| `dv` | Diff in vertical split |
| `<CR>` | Open file |
| `g?` | Show all fugitive mappings |

### Diffview (inside the view)

| Key | Action |
|-----|--------|
| `<Tab>` / `<S-Tab>` | Next / previous changed file |
| `<CR>` | Open file from panel |
| `g?` | Show all diffview mappings |

### gitsigns staged hunk (visual mode)

Select lines in visual mode then `<leader>hs` / `<leader>hr` stages/resets just those lines.

---

## 5. tmux Keybindings

**Prefix** = `<C-b>` (tmux default — not rebound in your config). Notation
`<prefix> x` means press `Ctrl-b`, release, then `x`.

### 5a. Your custom bindings

From [`.tmux.conf`](.tmux.conf).

| Key | Action |
|-----|--------|
| `<prefix> \` | Split window horizontally → new pane (keeps current dir) |
| `<prefix> -` | Split window vertically → new pane (keeps current dir) |
| `<prefix> h` | Resize pane left by 5 (repeatable — hold without re-pressing prefix) |
| `<prefix> j` | Resize pane down by 5 (repeatable) |
| `<prefix> k` | Resize pane up by 5 (repeatable) |
| `<prefix> l` | Resize pane right by 5 (repeatable) |
| `<prefix> m` | Toggle pane zoom / maximize (repeatable) |
| `<prefix> f` | Run **tmux-sessionizer** in a new window (project switcher) |
| `<C-h/j/k/l>` | Move between vim splits **and** tmux panes seamlessly (vim-tmux-navigator — **no prefix**) |

**Disabled defaults** (rebound away in your config):
`<prefix> %` and `<prefix> "` no longer split — use `\` and `-` instead.

#### Copy mode (vi-style, your bindings)

Enter copy mode with `<prefix> [`, then:

| Key | Action |
|-----|--------|
| `v` | Begin selection |
| `y` | Copy selection → system clipboard (`pbcopy`) and exit |
| `q` | Quit copy mode |

> Mouse is on, so click-dragging a selection also copies to the system clipboard.

#### Behavioral settings you've enabled

- **Mouse** on — click panes/windows to focus, drag borders to resize, scroll to enter copy mode.
- **vi mode-keys** — copy-mode navigation uses Vim motions (`h/j/k/l`, `w`, `/` search, `g`/`G`).
- **Windows auto-renumber** — closing a window re-sequences the rest (no gaps).
- **Focus events** forwarded — Neovim's `FocusGained` fires so autoread/checktime works.
- **OSC52 clipboard passthrough** + truecolor to iTerm.

#### Plugins (via TPM)

`tpm` · `vim-tmux-navigator` · `tmux-themepack` (powerline yellow theme).
Manage with `<prefix> I` (install), `<prefix> U` (update), `<prefix> alt-u` (uninstall).

---

### 5b. Default tmux commands you get

Standard tmux bindings available even though they're not in your config (all use `<prefix>`).

#### Sessions

| Key | Action |
|-----|--------|
| `<prefix> d` | Detach from session |
| `<prefix> s` | Interactive session/window tree (switch) |
| `<prefix> $` | Rename current session |
| `<prefix> (` / `)` | Previous / next session |
| `<prefix> L` | Switch to last (most recent) session |

#### Windows (tabs)

| Key | Action |
|-----|--------|
| `<prefix> c` | Create new window |
| `<prefix> ,` | Rename current window |
| `<prefix> &` | Kill current window (with confirm) |
| `<prefix> n` / `p` | Next / previous window |
| `<prefix> 0`–`9` | Jump to window by number |
| `<prefix> w` | Interactive window list |
| `<prefix> '` | Prompt for window index to select |
| `<prefix> l` | *(default = last window — overridden by your resize binding)* |
| `<prefix> .` | Move window to another index |
| `<prefix> f` | *(default = find window — overridden by your sessionizer binding)* |

#### Panes

| Key | Action |
|-----|--------|
| `<prefix> o` | Cycle to next pane |
| `<prefix> ;` | Toggle to last active pane |
| `<prefix> q` | Show pane numbers (press number to jump) |
| `<prefix> x` | Kill current pane (with confirm) |
| `<prefix> z` | Toggle pane zoom *(you also have `m`)* |
| `<prefix> {` / `}` | Swap pane with previous / next |
| `<prefix> !` | Break pane out into its own window |
| `<prefix> space` | Cycle through pane layouts |
| `<prefix> ←↑↓→` | Move to pane by arrow direction |
| `<prefix> C-←↑↓→` | Resize pane by 1 (arrow keys) |
| `<prefix> t` | Show a big clock |

#### Copy mode & buffers

| Key | Action |
|-----|--------|
| `<prefix> [` | Enter copy mode (scroll back / select text) |
| `<prefix> ]` | Paste most recent buffer |
| `<prefix> =` | Choose which paste buffer to paste |
| `<prefix> PgUp` | Enter copy mode and scroll up one page |

#### Misc / control

| Key | Action |
|-----|--------|
| `<prefix> ?` | List **all** key bindings (searchable help) |
| `<prefix> :` | tmux command prompt |
| `<prefix> r` | *(no default — common reload binding; add `bind r source-file ~/.tmux.conf` if you want it)* |
| `<prefix> C-z` | Suspend the tmux client |
| `<prefix> ~` | Show tmux message log |

> **Tip:** `<prefix> ?` is the canonical way to see every active binding live, including
> whatever the themepack/navigator plugins add.

---

## Quick mental model

- `<Space>` opens almost everything. Watch the **which-key** popup after pressing it — groups: `a`=AI, `b`=Buffers, `c`=Code, `d`=Debug, `f`=Find, `g`=Git, `h`=Hunks, `r`=Rust/Rename.
- `g` prefix = "go to" (definition, implementation, references).
- `]`/`[` = next/previous (hunks `]c`, buffers `]b`).
- `<C-h/j/k/l>` always moves between panes/splits — vim or tmux, doesn't matter.
