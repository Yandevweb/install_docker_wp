#!/bin/bash
# Installation de Docker

cmdProxy='command'
command type -f sudo &> /dev/null && cmdProxy='sudo'

# install MySQL
${cmdProxy} docker run --name mysql -e MYSQL_ROOT_PASSWORD=0000 -d mysql:latest


# récup de l'id de l'image
idMysql="$(docker ps -aqf "name="mysql)"

${cmdProxy} docker build -f imgApache -t apache .

# link des containers apache et mysql
docker run --name apache --link ${idMysql} -p 4000:80 -d apache

echo "======================================"
echo "${idMysql}"
echo "======================================"

# récup de l'id de l'image
idApache="$(docker ps -aqf "name="apache)"
echo "======================================"
echo "${idApache}" 
echo "======================================"


${cmdProxy} docker exec -it ${idApache} bash

${cmdProxy} mysql -uroot -p0000 -h${idMysql}
