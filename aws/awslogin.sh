ssh -i ~/Desktop/gradplanner10.pem -t ubuntu@ec2-13-52-238-219.us-west-1.compute.amazonaws.com "cd GradPlanner/aws; git checkout master && git pull; /bin/bash -i"
