cmdProxy='command'
command type -f sudo &> /dev/null && cmdProxy='sudo'

# Installation de Docker

${cmdProxy} docker build -f imgApache -t apache .

#${cmdProxy} docker run -d -p 4000:80 apache

# install MySQL
${cmdProxy} docker run --name mysql -e MYSQL_ROOT_PASSWORD=0000 -d mysql:latest .

# récup de l'id de l'image

${cmdProxy} rm id_mysql.txt
${cmdProxy} docker ps | grep mysql > id_mysql.txt
idMysql=${cmdProxy}cut -c1-12 id_mysql.txt

echo "$idMysql"

# link des containers apache et mysql
${cmdProxy} docker run --name apache --link ${idMysql} -p 4000:80 -d apache .

# récup de l'id de l'image

${cmdProxy} rm id_apache.txt
${cmdProxy} docker ps | grep apache > id_apache.txt
idApache=${cmdProxy}cut -c1-12 id_apache.txt

echo "$idApache"


${cmdProxy} docker exec -it ${idApache} bash

${cmdProxy} mysql -uroot -p0000 -h${idMysql}