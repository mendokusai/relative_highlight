# relative_highlight
---

This is a simple tool I've been wanting to try for a long time.
I love relative numberline, but need standard numberline, so this gives me both.

## Install

Copy `plugin/relative_highlight` into your Vim plugin path, or use a plugin manager like `vim-plug`:

```vim
Plug 'mendokusai/relative_highlight'
```

## Customisation

```vim
    let s:default_colors = {
          \ 'current_line': {'cterm': 'Yellow', 'gui': '#ffcc00'},
          \ 'five_line': {'cterm': 'Blue', 'gui': '#5fafff'},
          \ 'ten_line': {'cterm': 'Yellow', 'gui': '#ffd700'}
          \ }
```

If you want to set specifics.


This was made with chatgpt. I tried a few times to get it to do what I wanted, and it's finally gotten to the point where it could do so.

Let me know how much it sucks! -ryan

