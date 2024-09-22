# A lambda (λ) prompt.
# Green and red depending on exit status.

function fish_prompt
  if is_status_okay
    set_color green
  else
    set_color red
  end

  # In "nix develop" shell?
  # The second is hack to check if in "nix shell" shell.
  if test -n "$IN_NIX_SHELL"
    set_color blue
    echo -n  "($name) "

    set_color green
  end
  echo -n  'λ'
  
  set_color normal
  echo -n ' '
end
