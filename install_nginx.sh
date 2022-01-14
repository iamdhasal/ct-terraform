#! /bin/bash
sudo apt-get update
sudo apt-get install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
echo "<html> <h1> Hello from Vivek from $HOSTNAME </h1> </html>">>/var/www/html/index.html