# WARNING: VERY DANGEROUS COMMAND
# Run if something other than apache is running on port 80
# Please run ./checkport80.sh before running this script

sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill
