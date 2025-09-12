from setuptools import setup
import os
from glob import glob

package_name = 'f1tenth_gym_ros'

def get_map_data_files():
    map_files = []
    for root, dirs, files in os.walk('maps'):
        for file in files:
            full_path = os.path.join(root, file)
            install_path = os.path.join('share', package_name, root)
            map_files.append((install_path, [full_path]))
    return map_files

setup(
    name=package_name,
    version='0.0.0',
    packages=[package_name],
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
        (os.path.join('share', package_name, 'launch'), glob('launch/*.py')),
        (os.path.join('share', package_name, 'launch'), glob('launch/*.xacro')),
        (os.path.join('share', package_name, 'launch'), glob('launch/*.rviz')),
        (os.path.join('share', package_name, 'config'), glob('config/*.yaml')),
    ] + get_map_data_files(),
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='Billy Zheng',
    maintainer_email='billyzheng.bz@gmail.com',
    description='Bridge for using f1tenth_gym in ROS2',
    license='MIT',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            'gym_bridge = f1tenth_gym_ros.gym_bridge:main'
        ],
    },
)
