# A lambda (λ) prompt.
# Green and red depending on exit status.

function fish_prompt
    if is_status_okay
      set_color green
    else
      set_color red
    end
    echo -n  'λ'
  
    set_color normal
    echo -n ' '
end
