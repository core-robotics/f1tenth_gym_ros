## Start with mamba (conda)
```bash
mamba env create -n f1tenth_gym_ros python=3.10
echo 'alias mam_f1tenth_gym_ros='\''cd ~/<your_workspace> && mamba activate f1tenth_gym_ros && export PYTHONPATH="/home/<your_name>/miniforge3/envs/f1tenth_gym_ros/lib/python3.10/site-packages:$PYTHONPATH" && export PYTHONPATH=$PYTHONPATH:/home/<your_name>/<your_workspace>/src/f1tenth_gym'\''' >> ~/.bashrc
```
</br>

**Install Dependencies**
```bash
cd src/ &&
git clone https://github.com/geonwoo-kim-2002/f1tenth_gym.git

sudo apt install ros-humble-nav2-lifecycle-manager -y &&
sudo apt install ros-humble-nav2-map-server -y

mam_f1tenth_gym_ros
pip install -r src/f1tenth_gym_ros/requirements.txt
```
</br>

## Getting Started
```bash
mam_f1tenth_gym_ros
colcon build --symlink-install
source install/setup.bash
ros2 launch f1tenth_gym_ros gym_bridge_launch.py
```
</br>

### ❌ Error
```md
--- stderr: f1tenth_gym_ros
/home/a/miniforge3/envs/f1tenth_gym_ros/lib/python3.10/site-packages/setuptools/_distutils/dist.py:289: UserWarning: Unknown distribution option: 'tests_require'
  warnings.warn(msg)
usage: setup.py [global_opts] cmd1 [cmd1_opts] [cmd2 [cmd2_opts] ...]
   or: setup.py --help [cmd1 cmd2 ...]
   or: setup.py --help-commands
   or: setup.py cmd --help

error: option --editable not recognized
---
```
**solution**
```bash
pip install --upgrade "setuptools<66"
```