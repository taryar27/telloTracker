# Tello Tracker
Face detection and visual servoing on DJI Tello drone with MATLAB.

This code provides the basic framework for interfacing a DJI tello drone with MATLAB.
Face detection and visual servoing algorithms are tested.

## Code Structure

```
main.m
```
main is the core script to run the project. Two modes are available to choose in startup.
```
0: Webcam
1: Drone
```
If '0' is chosen, the regular Webcam available (software package required) will be used.
If '1' is chosen, the DJI Tello drone (software package and hardware connection required) will be used.

Drone flight manipulations will only be performed in 'drone (1)' mode.

```
utils
  |-- Tello.m
  |-- ImageProcessor.m
  |-- Tracker.m
  |-- Camera.m
```
Utils folder includes utility classes employed in the project. More details are described in the README in utils folder and comments in the respective classes.


```
calibration
  |-- I1.jpg
  |-- ...
  |-- ...
  |-- Calib_Results.mat
```

Calibration folder includes checkerboard photos and calibration results for the camera onboard the DJI Tello drone.


## Drone Navigation

The drones moves in the following axes, which is different from image coordinates derived from visual servoing algorithm. Appropriate transformation must be carried out in order to move the drone to correct poses.

![](https://au.mathworks.com/help/supportpkg/ryzeio/ref/ryze_drone_with_axes.jpg)


## Software Requirement

* MATLAB R2020a'
* MATLAB Support Package for Ryze Tello Drone
* MATLAB Support Package for USB Webcams

'R2020a is required for Ryze Tello Support package installation. If you are not using the drone, the latest version is not required.

## Hardware Requirement

* DJI Tello Drone OR
* DJI Tello EDU Drone

## Developer's Note

The main script will run as follows.

First, the drone will start up, take off and fly slightly higher.
Then, the drone will rotate until it finds a target (face of a person). Then the drone will try to move in order to match the target position (blue box) with the observed position (green box).

Precaution: Drone movements can be sudden and dangerous and safety needs to be considered at all times.
