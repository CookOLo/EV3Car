# EV3 Automated Car

## Objective
This ASU FSE100 Final Project involves using Matlab to remotely and autonomously move a car made from a Lego EV3 Kit through a maze. This project aims to imitate a rideshare service for the elderly and disabled. 

Specifically, the car would:
1) Automously move to the Blue Tile
2) Remotely pick up a miniature of a passenger on the Blue Tile
3) Automously move to the Red Tile
4) Stop at Red for two seconds
5) Automously move to the Yellow Tile
6) Remotely drop off on the Yellow Tile
7) Automously move to the Green Tile
8) Stop at the Green Tile permanently 

As of 12/04/24, the project is completed. This was worked on by a team of four.

Final Iteration: https://youtu.be/UxOwWiyrsro

## Skills Learned

- Scripting with MATLAB
- Communication and teamwork with a team of 4
- Committing to an interally developed schedule
- Development of critical thinking and problem solving skills in engineering

## EV3 Files
Needed in order for MATLAB to access the EV3 methods. Simply add to MATLAB folder, and in MATLAB:
  1) Right-Click on the Folder
  2) Add to Path > Selected Folders and Subfolders

## MovementScript.m
The actual code for the movement of the EV3 Car. 
### For Remote Control
* W: Move Forward
* S: Move Backward
* D: Turn Right
* A: Turn Left
* Space: Stop
* Up Arrow: Move Crane Up
* Down Arrow: Move Crane Down
* Q: Switch to Auto Control
### For Auto Control
* Space: Stop
* M: Switch to Remote Control 
