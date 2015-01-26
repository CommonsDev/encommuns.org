Kind of a generic App catalog, such as Google Play or Apple Store, but for Web apps.

Meant to be the landing page for Unisson free software suite.


### Geting the code 
    
    git clone https://github.com/UnissonCo/xxxxx.git

### Updating config.js
 
    cp app/scripts/config.js.sample _public/js/config.js
    
  In config.js, change rest_uri with the API you use: "http://your.dataserver.host/api/v1"

### Install dependencies

    sudo apt-get install ruby-compass ruby-fssm coffeescript
    npm install
    node_modules/.bin/bower install
    
    
### Update Css
  
cd styles/
compass w

cd ..

python -m SimpleHTTPServer 8080
