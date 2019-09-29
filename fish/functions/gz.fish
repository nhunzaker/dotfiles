# Get the size of a file gzipped
function gz
  echo "orig size    (bytes): "
  cat "$argv[1]" | wc -c
  echo "gzipped size (bytes): "
  gzip -c "$argv[1]" | wc -c
end
