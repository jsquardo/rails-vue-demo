  
#!/bin/bash
# git remote add heroku https://git.heroku.com/circleci-demo-python-flask.git
wget https://cli-assets.heroku.com/branches/stable/heroku-linux-amd64.tar.gz
sudo mkdir -p /usr/local/lib /usr/local/bin
sudo tar -xvzf heroku-linux-amd64.tar.gz -C /usr/local/lib
sudo ln -s /usr/local/lib/heroku/bin/heroku /usr/local/bin/heroku

cat > ~/.netrc << EOF
machine api.heroku.com
  login $HEROKU_LOGIN
  password $HEROKU_API_KEY
machine git.heroku.com
  login $HEROKU_LOGIN
  password $HEROKU_API_KEY
EOF

# Add heroku.com to the list of known hosts
ssh-keyscan -H heroku.com >> ~/.ssh/known_hosts

# Login
heroku login

# Setting for Heroku container 
heroku stack:set container --app ${HEROKU_APP_NAME}

# Setting for Heroku git
# git config --global url.ssh://git@heroku.com/.insteadOf https://git.heroku.com/
heroku git:remote -a ${HEROKU_APP_NAME}
