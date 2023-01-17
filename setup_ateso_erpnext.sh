# !/bin/bash

# Check if Docker is installed
if command -v docker >/dev/null 2>&1; then
  echo "Docker is already installed."
else
  # Update package list and install Docker
  sudo apt-get update
  sudo apt-get install -y docker.io
  echo "Docker has been installed."
fi

# Install ateso erpnext containers
COMMAND="
docker-compose -f compose.yaml -f overrides/compose.noproxy.yaml -f overrides/compose.mariadb.yaml -f overrides/compose.redis.yaml -f compose.override.yaml up -d;
docker-compose exec backend bench new-site frontend --mariadb-root-password 123 --admin-password admin --install-app erpnext --install-app erpnextswiss --set-default;
docker-compose restart backend
"

# Execute the command and store the return value
$COMMAND
RETURN_VALUE=$?

# Check the return value
if [ $RETURN_VALUE -eq 0 ]; then
  echo "Installation executed successfully. You can reach the web interface via the https://your-system-ip:8080.
  Username: administrator
  Password: admin

  Enjoy!
  
                                 ^7JJ?~.                                
                             ^?JJJJJJ?~                               
                          .~?JJ?!^^~77: :.                            
                         ~?JJJ~       .7??!:                          
                        .J??JJ         ^???J~                         
                         ^?JJJ~       .7??!.                          
                           ^?JJ?!~^~77: ..                            
                             ^?JJJJJJ?~                               
                  ..           :!777^                                 
                 ^@@!                                                 
   :~7???~:     ^Y@@P^^     .~7??!:        .~7??7~.        .~7??7^    
 Y@@#G55G&@@7  .B&@@&BP   7&@&G5P#@@G.   :#@&GP5G&@@!    !&@&G5PB@@B: 
~##~      5@@:   ^@@!    B@@^      B@@:  &@@.     ?5J   P@@!      G@@!
   .~?YY55#@@~   ^@@7   ~@@#7?????7Y@@#  7@@@#PJ!:     :@@P        &@@
.P@@B5J?77G@@~   ^@@7   ?@@#5PPPPPP5YY?    :?PB&@@@&Y  ~@@?        &@@
&@@.      !@@~   ^@@!   .@@B        ^^.  ~^.      Y@@7 .@@#       :@@B
#@@7.  .^5@@@~   :@@G..  ~&@#!.  .~&@&.  #@@!.  .:G@@:  ^&@&~.  .J@@B 
 ?#@@@&&#YY@@^    J&@@@:   7B@@@@@@B7     7#@@@@@@&J.     7#@@@@@&G^  
  "
else
  echo "Installation failed with return value $RETURN_VALUE."
fi