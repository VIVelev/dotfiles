# A lambda (λ) prompt.
# Green and red depending on exit status.

function fish_prompt
  if is_status_okay
    set_color green
  else
    set_color red
  end

  if test -n "$IN_NIX_SHELL"
    set_color blue
    echo -n  '(nix-shell) '
    set_color green
  end
  echo -n  'λ'
  
  set_color normal
  echo -n ' '
end
