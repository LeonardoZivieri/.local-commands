process=$(lsof -t -i:$1)

if [ -z "$process" ]; then
  echo "Process with port $1 not found"
  exit 0
else 
  echo "Process with port $1 is still running"
  echo "Killing process..."
  kill $process
  echo "Process with port $1 has been killed"
fi