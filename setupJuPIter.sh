#!/bin/bash

# install python modules
sudo rm /usr/bin/python 
sudo ln -s /usr/bin/python3 /usr/bin/python

sudo apt-get -y update
sudo apt-get -y install python3-matplotlib
sudo apt-get -y install python3-scipy
sudo apt-get -y install python3-pip
sudo pip3 install --upgrade pip

# install jupyterlab
sudo pip install jupyterlab

# setup jupyterlab as a service file
echo "[Unit]
    Description=Jupyter Lab
[Service]
    Type=simple
    PIDFile=/var/run/ipython-notebook.pid
    Environment="PATH=$PATH:/user/local/bin/"
    ExecStart=/usr/local/bin/jupyter-lab --no-browser --notebook-dir=/home/pi/notebooks/ --NotebookApp.token='piLab' --ip=0.0.0.0
    User=pi
    Group=pi
    WorkingDirectory=/home/pi
[Install]
    WantedBy=multi-user.target" > jupyterlab.service

# setup jupyter lab service
sudo chmod 777 jupyterlab.service
mkdir ./notebooks
sudo cp jupyterlab.service /lib/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start jupyterlab
sudo systemctl status jupyterlab

# look for the jupyter service
ps -ef | grep jupyter

# enable the jupyter service
sudo systemctl enable jupyterlab

#
echo "if you see the jupyter service, reboot the machine [sudo reboot]"
