#!/bin/bash
BASE_DIR="$(cd "$(dirname "$0" )" && cd .. && pwd )"
APP_DIR=$BASE_DIR"/app.py"

sed -i '$ d' $APP_DIR
echo "    app.run()" >> $APP_DIR
sudo service apache2 restart
sed -i '$ d' $APP_DIR
echo "    app.run(debug=True)" >> $APP_DIR
