sudo cat /etc/nginx/sites-available/default > /tmp/nginx.conf
sudo cp /tmp/nginx.conf /tmp/nginx.conf.bak
code --wait /tmp/nginx.conf;
wait 2;

while true; do
  code --wait /tmp/nginx.conf;
  sudo cp /tmp/nginx.conf /etc/nginx/sites-available/default;
  result=$(sudo nginx -t 2>&1)
  successful=$(echo "$result" | grep -c "successful")
  if [ $successful -gt 0 ]; then
    echo "Conf is OK"
    sudo systemctl restart nginx.service
    break
  else
    echo "FAILED"
    echo "$result"
    sudo cp /tmp/nginx.conf.bak /etc/nginx/sites-available/default
    code --wait /tmp/nginx.conf;
    wait 2;
  fi
done