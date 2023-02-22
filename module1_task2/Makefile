build:		# Build with Hugo
	hugo

clean:		# Delete the dist/ directory
	rm -rf dist

post:		# Create a new post
	echo '---' >> ./content/posts/$(POST_NAME).md
	echo "title: $(POST_TITLE)" >> ./content/posts/$(POST_NAME).md
	echo '---' >> ./content/posts/$(POST_NAME).md

help:		# Displays help for this makefile
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done