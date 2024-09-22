# Note taking!
function note
  set date (date "+%b-%d-%Y")
  set base "/Users/vivelev/Documents/notes/"
  if test (count $argv) -eq 0
    set file "$base$date.md"
  else
    set file "$base$date.$(string join '.' $argv).md"
  end

  if not test -e $file
    echo "---" >> $file
    echo "author: Victor Velev" >> $file
    echo "date: $date" >> $file

    if test (count $argv) -gt 0
      echo "keywords:" >> $file
      for arg in $argv
        echo "  - $arg" >> $file
      end
    end
    echo "---" >> $file
  end

  vim $file
end
