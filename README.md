# GradPlanner 

A web application that generates a four-year plan for Santa Clara University students based on their needs. It is now open for beta testing - you can visit it [here!](http:gradplanner.herokuapp.com)

Originally named PlanForGrad / CoursePlanner. Cloned from repository (for CSCI 187 project): https://github.com/xiaogong1/Course-Planner

Refer to the wiki for setup information: https://github.com/park-junha/PlanForGrad/wiki

## First-Time Setup
1. Install `python3`, `pip3`, and `python3-venv`. You can use `brew` (Homebrew) to install on macOS or `apt-get` on Ubuntu / Debian to install these. (e.g. `brew install python3` on macOS, `sudo apt-get install python3` on Debian)
2. Create a Python3 virtual environment with `python3 -m venv ~/.virtualenv/GradPlanner`
3. Activate it with `source ~/.virtualenv/GradPlanner/bin/activate`
4. Navigate to your local repository (`cd path/to/directory`)
5. Run `pip3 install -r requirements.txt` to install all Python dependencies on the environment.

## Running
1. Start your virtual environment with `source ~/.virtualenv/GradPlanner/bin/activate`
2. Run `python3 main.py`, with the database password as your first command line argument.
3. Navigate to `localhost:5000` on your browser to access the frontend.

### Common Errors
- Make sure all dependencies are installed. You can do this with `pip3 install -r requirements.txt`.
- Try using a virtual environment. You can follow steps on how to do that above or [here](https://github.com/park-junha/PlanForGrad/wiki/Running). You will also need to `source` the virtual environment before running the Python app every time.

Contact jpark3@scu.edu if you are having difficulties running the app.
