# Note taking!
function note
  set date (date "+%b-%d-%Y")
  set base "/Users/vivelev/Documents/notes/"
  if test (count $argv) -eq 0
    set file "$base$date.typ"
  else
    set file "$base$date.$(string join '.' $argv).typ"
  end

  if not test -e $file
    echo "#set page(width: 16cm, margin: 1.5cm)" >> $file
    echo "" >> $file

    echo -n $date >> $file
    if test (count $argv) -gt 0
      echo -n " #h(1fr) $(string join ', ' $argv)" >> $file
    end
    echo "" >> $file
    echo "#line(length: 100%)" >> $file
  end

  vim $file
end
