#!/bin/bash

# Read the IP address from the file
new_ec2_instance_public_ip=$(cat new_ec2_instance_public_ip.txt)

# Read the name of the tag to use with the docker image
dockerImageTag=$(cat awesome_image_tag_name.txt)

scp -o StrictHostKeyChecking=accept-new ./docker-compose.yml ubuntu@"$new_ec2_instance_public_ip":/home/ubuntu/

# ssh -o StrictHostKeyChecking=accept-new ubuntu@"$new_ec2_instance_public_ip" "
# 	docker pull tsuroo/awesome-web:$dockerImageTag
# 	docker compose run --detach tsuroo/awesome-web:$dockerImageTag
# "