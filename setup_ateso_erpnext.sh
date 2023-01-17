# !/bin/bash

# Check if Docker is installed
echo "1. Checks if Docker is installed:"
if command -v docker >/dev/null 2>&1; then
  echo "Docker is already installed."
else
  # Update package list and install Docker
  sudo apt-get update
  sudo apt-get install -y docker.io
  echo "Docker has been installed."
fi

# Install ateso erpnext containers
echo "2. Install ateso erpnext containers"
COMMANDS="cd ateso_erpnext_container && 
docker compose -f compose.yaml -f overrides/compose.noproxy.yaml -f overrides/compose.mariadb.yaml -f overrides/compose.redis.yaml -f compose.override.yaml up -d &&
echo \"3. Install ateso erpnext containers\" &&
docker compose exec backend bench new-site frontend --mariadb-root-password 123 --admin-password admin --install-app erpnext --install-app erpnextswiss --set-default &&
docker compose restart backend
"

# Execute the command and store the return value
eval "$COMMANDS"

# Check the return value
if [ $? -eq 0 ]; then
  IP_ADDRESS=$(hostname -I)
  echo "
  
  Installation executed successfully. You can reach the web interface using http://$IP_ADDRESS:8080.
  
  Username: administrator
  Password: admin

  Thanks for using! 
  
        ^7??7~.                              7@@!                                                    
      .~?JJJJJJ?7:             .^~!!!~:      :5@@5::      .~!!!^.         .~!!!~:          :~!!!^.    
    .!JJJ?!~~~7?~..:         Y&@&BGGB#@@G.  ~#&@@&#B   :G@@&GGB&@&Y.    5&@&BGG#@@#^    ^B@@#GGB&@&Y  
  .!JJJJ^        ^???~.     7&&!      :@@B    ?@@7    ?@@G.     :&@@:  5@@?     .PGJ   Y@@P.     ^@@&:
  ?J??J?         .7??J?^       .~7JYYY5@@&    ?@@7   .@@@?!77777!5@@&  ^&@@#GY7^.     .@@&        ^@@#
  .7JJJJ^        ^???~.     .G@@#PYJ??J@@&    ?@@7   :@@@PGGGGGGGP55Y    .75B&&@@@#?  ^@@B        .@@@
    .!JJJ?!~^~7?~..:        @@@.       @@&    ?@@7    &@@:        ^^.  ^~:      .B@@!  @@@.       J@@P
      .~?JJJJJJ?7:          &@@?....^?#@@&    !@@B..  .#@@5^. .:7&@&:  P@@5:.  .~&@&.  :&@@J:. .~G@@5 
        ^7???!.             ?#@@@&&&G!#&#     Y&@@@!   ^5&@@@@@&G!     ^P&@@@@@@B7      ~G&@@@@@&Y.  
  


  "
else
  echo "
  Installation failed with return value $RETURN_VALUE.
  "
fi