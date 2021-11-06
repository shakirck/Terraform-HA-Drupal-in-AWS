#!/bin/bash
sudo apt-get update
sudo apt-get -y install git binutils 
sudo git clone https://github.com/aws/efs-utils
cd efs-utils
./build-deb.sh
sudo apt-get -y install ./build/amazon-efs-utils*deb
cd ..
sudo mkdir /efs
sudo mount -t efs -o tls ${fsid1}:/ /efs

# aws efs describe-mount-targets --file-system-id fs-082c344f63dcd177b --region us-east-1
# |jq -r '.[]|.[]|select(.AvailailityZoneName|contains("us-east-1a"))'
# 

#   EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
#   EC2_REGION="`echo \"$EC2_AVAIL_ZONE\" | sed 's/[a-z]$//'`"

# src="/efs/backup.sql"
# [ ! -f "$src" ] && sudo mysqldump -u root -p bitnami_drupal > /efs/backup.sql || \
#  echo "Backup file  already found ..."

# sudo mysqldump -u root -p bitnami_drupal > /efs/backup.sql
src="/efs/backups/back.sql"
# [ ! -f "$src" ] && \
# sudo drush sql:dump --result-file=./back.sql && \
# sudo mkdir /efs/backups && \
# sudo mv /opt/bitnami/drupal/back.sql /efs/backups/back.sql && \
# # sudo cp -r /opt/bitnami/drupal /opt/bitnami/drupalcopy/
# # sudo cp -r /opt/bitnami/drupal /opt/bitnami/drupalcopy2/
# # sudo rm -rf /opt/bitnami/drupal
# # sudo mkdir /opt/bitnami/drupal
# # sudo mount -t efs -o tls ${fsid1}:/ /opt/bitnami/drupal
# # sudo mv /opt/bitnami/drupalcopy/* /opt/bitnami/drupal 
# #  echo "Backup and copying sql data to EFS"  || \
# #  echo "Backup already in EFS" &&
# #  sudo mount -t efs -o tls ${fsid1}:/ /opt/bitnami/drupal
# sudo cp -r /bitnami/drupal /bitnami/drupalcopy/
# sudo cp -r /bitnami/drupal /bitnami/drupalcopy2/
# sudo rm -rf /bitnami/drupal
# sudo mkdir /bitnami/drupal
# sudo mount -t efs -o tls ${fsid1}:/ /bitnami/drupal
# sudo mv /bitnami/drupalcopy/* /bitnami/drupal 
# sudo mysql -u dbadmin -p'12345678' -h ${DB_HOST} -D bitnami_drupal < /efs/backups/back.sql
# sed -i '806,815d' /bitnami/drupal/sites/default/settings.php 
#  echo "Backup and copying sql data to EFS"  || \
#  echo "Backup already in EFS" &&
#  sudo mount -t efs -o tls ${fsid1}:/ /bitnami/drupal


if [ ! -f "$src"  ]  
then
    sudo drush sql:dump --result-file=./back.sql 
    sudo mkdir /efs/backups 
    sudo mv /opt/bitnami/drupal/back.sql /efs/backups/back.sql 
    sudo cp -r /bitnami/drupal /bitnami/drupalcopy/
    sudo cp -r /opt/bitnami/drupal /opt/bitnami/drupalcopy2/
    sudo rm -rf /bitnami/drupal
    sudo rm -rf /opt/bitnami/drupal
    sudo mkdir /bitnami/drupal
    sudo mkdir /opt/bitnami/drupal
    sudo mount -t efs -o tls ${fsid1}:/ /bitnami/drupal
    sudo mount -t efs -o tls ${fsid2}:/ /opt/bitnami/drupal
    logger "coppying to drupal nfs"
    echo "coppying to drupal nfs"

    sudo cp -r /bitnami/drupalcopy/* /bitnami/drupal 
    sudo cp -r /opt/bitnami/drupalcopy2/* /opt/bitnami/drupal 
    sudo chmod -R  daemon:daemon /bitnami/drupal

    #  echo "Backup and copying sql data to EFS"  || \
    #  echo "Backup already in EFS" &&
    #  sudo mount -t efs -o tls ${fsid1}:/ /opt/bitnami/drupal
    # sudo cp -r /bitnami/drupal /bitnami/drupalcopy/
    # sudo cp -r /bitnami/drupal /bitnami/drupalcopy2/
    # sudo rm -rf /bitnami/drupal
    # sudo mkdir /bitnami/drupal
    # sudo mount -t efs -o tls ${fsid1}:/ /bitnami/drupal
    # sudo mv /bitnami/drupalcopy/* /bitnami/drupal 
    echo "updating rds"
    sudo mysql -u dbadmin -p'12345678' -h ${DB_HOST} -D bitnami_drupal < /efs/backups/back.sql


    echo "Backup and copying sql data to EFS"
    
    sudo drush cr
    sudo drush cc css-js

    sudo drush upwd user admin
    sudo drush -y config-set system.performance css.preprocess 0
    sudo drush -y config-set system.performance js.preprocess 0

sed -i '806,815d' /bitnami/drupal/sites/default/settings.php 
echo "updating settings.php"
sudo tee ./db.data <<EOF
 \$databases['default']['default'] = array (
  'database' => '${DB_NAME}',
  'username' => '${DB_USERNAME}',
  'password' => '${DB_PASSWORD}',
  'prefix' => '',
  'host' => '${DB_HOST}',
  'port' => '3306',
  'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
  'driver' => 'mysql',
);
EOF
sudo bash -c 'cat db.data >> bitnami/drupal/sites/default/settings.php' 
 sudo chown -R  daemon:root /bitnami/drupal
sudo chown -R  bitnami:daemon /opt/bitnami/drupal
else
    echo "Backup already in EFS"    
    sudo cp -r /bitnami/drupal /bitnami/drupalcopy/
    sudo cp -r /opt/bitnami/drupal /opt/bitnami/drupalcopy2/
    sudo rm -rf /bitnami/drupal
    sudo rm -rf /opt/bitnami/drupal
    sudo mkdir /bitnami/drupal
    sudo mkdir /opt/bitnami/drupal
    sudo mount -t efs -o tls ${fsid1}:/ /bitnami/drupal
    sudo mount -t efs -o tls ${fsid2}:/ /opt/bitnami/drupal
    logger "coppying to drupal nfs"
    echo "coppying to drupal nfs"

    sudo cp -r /bitnami/drupalcopy/* /bitnami/drupal 
    sudo cp -r /opt/bitnami/drupalcopy2/* /opt/bitnami/drupal 


    sudo chown -R  daemon:root /bitnami/drupal
    sudo chown -R  bitnami:daemon /opt/bitnami/drupal
    
    sudo drush cr
    sudo drush cc css-js
    sudo drush upwd user admin
    sudo drush -y config-set system.performance css.preprocess 0
    sudo drush -y config-set system.performance js.preprocess 0
fi

# # /opt/bitnami/drupal/drupalbckup.sql
# sudo mysql -u dbadmin -p'12345678' -h ${DB_HOST} -D bitnami_drupal < /efs/backups/back.sql
# sed -i '806,815d' /bitnami/drupal/sites/default/settings.php 

# sed -i '806,815d' /bitnami/drupal/sites/default/settings.php 
# echo "updating settings.php"
# sudo tee ./db.data <<EOF
#  \$databases['default']['default'] = array (
#   'database' => '${DB_NAME}',
#   'username' => '${DB_USERNAME}',
#   'password' => '${DB_PASSWORD}',
#   'prefix' => '',
#   'host' => '${DB_HOST}',
#   'port' => '3306',
#   'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
#   'driver' => 'mysql',
# );
# EOF
# sudo bash -c 'cat db.data >> bitnami/drupal/sites/default/settings.php' 
sudo chmod -R  daemon:daemon /bitnami/drupal
sudo drush cr
sudo drush upwd user admin
sudo drush cc css-js
sudo drush -y config-set system.performance css.preprocess 0
sudo drush -y config-set system.performance js.preprocess 0
sudo chown -R  daemon:root /bitnami/drupal
sudo chown -R  bitnami:daemon /opt/bitnami/drupal