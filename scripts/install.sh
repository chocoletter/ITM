#!/bin/bash

echo -e "\e[32minstalleren dotnet sdk\e[0m"
sudo apt update
sudo apt install -y dotnet-sdk-8.0 git

echo -e "\e[32mnaar home directory\e[0m"
cd /home/server/ || exit

echo -e "\e[32mrepo clonen of updaten\e[0m"
if [ -d "/home/server/ITM/.git" ]; then
	echo -e "\e[32mrepo word geupdate\e[0m"
	cd /home/server/ITM || exit
	git pull
else
	echo -e "\e[32mrepo wordt gecloned\e[0m"
	git clone git@github.com:chocoletter/ITM.git
fi

echo -e "\e[32mnaar de goeie directory gaan en hem runnen\e[0m"
cd /home/server/ITM/frontend/EasyDevOps || exit
dotnet run --urls "http://192.168.10.131:2000"
