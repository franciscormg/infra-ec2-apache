#!/bin/bash
yum update -y
yum install -y httpd

systemctl enable httpd
systemctl start httpd

cat << 'EOF' > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Hola Pancho</title>
</head>
<body>
    <h1>Apache corriendo en EC2 creada por Terraform + Jenkins</h1>
    <p>Esto salió desde user_data.sh</p>
</body>
</html>
EOF
