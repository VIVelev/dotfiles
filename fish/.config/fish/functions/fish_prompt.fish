function fish_prompt
  # In "nix develop" shell?
  # The second is hack to check if in "nix shell" shell.
  if test -n "$IN_NIX_SHELL"
    set_color white
    echo -n  "($name) "
  end
  set_color white
  echo -n (prompt_pwd)
  echo -n ' > '
  set_color normal
end
