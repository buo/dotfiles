# Usage: extract <file>
# Description: extracts archived files / mounts disk images
# Note: .dmg/hdiutil is Mac OS X-specific.
function extract
  set -l file $argv[1]
  if test -f $file
    echo "$file"
    switch "$file"
      case "*.bz2";              bunzip2 $file
      case "*.dmg";              hdiutil mount $file
      case "*.gz";               gunzip $file
      case "*.pax";              cat $file | pax -r
      case "*.pax.Z";            uncompress $file --stdout | pax -r
      case "*.tar";              tar -xvf $file
      case "*.tar.bz2" "*.tbz2"; tar -jxvf $file
      case "*.tar.gz" "*.tgz";   tar -zxvf $file
      case "*.zip" "*.ZIP";      unzip $file
      case *.Z;                  uncompress $file
      case "*";                  echo "'$file' cannot be extracted/mounted via extract()" ;
    end
  else
    echo "'$file' is not a valid file"
  end
end
