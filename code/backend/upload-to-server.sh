rsync -e "ssh -i $HOME/.ssh/co300.pem" --exclude 'node_modules' --exclude '.env' -v -r ./ Nipun@weatheranalytics.tk:/home/Nipun/e18-3yp-Weather-Analytics-And-Travel-Path-Guider/code/backend/ 
