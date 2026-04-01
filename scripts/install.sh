#!/bin/bash

#installeren dotnet sdk
sudo apt update
sudo apt install -y dotnet-sdk-8.0 git

#naar home directory
cd /home/server/ || exit

#repo clonen of update
if [ -d "/home/server/ITM/.git" ]; then
	cd /home/server/ITM || exit
	git pull
else
	git clone git@github.com:chocoletter/ITM.git
fi

#naar de goeie directory gaan en hem runnen
cd /home/server/ITM/frontend/EasyDevOps || exit
dotnet run --urls "http://192.168.10.131:2000"
