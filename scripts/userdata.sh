#!/bin/bash
echo "Hola mundo desde file "  > /home/ec2-user/saludo.txt
yum update -y
yum install httpd -y
systemctl enable httpd
systemctl start httpd
echo "<html><body><h1>Hola mundo desde el servidor web</h1></body></html>" > /var/www/html/index.html