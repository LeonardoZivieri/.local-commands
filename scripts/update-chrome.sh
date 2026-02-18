wget -O /tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt --fix-broken install
sudo dpkg -i /tmp/chrome.deb
dpkg -l | grep chrome
rm /tmp/chrome.deb