# PacMan Mini-Game (Processing)

A simple PacMan-inspired game built in the **Processing** IDE. Eat pellets to score, grab fruit to stun the ghost, and avoid getting caught!

## Project Overview
- PacMan moves horizontally between two blue track lines with an animated mouth.
- **Pellets** are placed across the lane; eating them increases your **score**.
- A **ghost** patrols the lane and changes direction randomly — colliding with it causes **game over**.
- A **fruit power-up** makes the ghost **harmless for ~3 seconds**; fruit respawns at a new position.
- Pellets **respawn** automatically after you clear them all.
- Screen **wrap**: PacMan and the ghost reappear on the opposite side when leaving the screen.

## Features
- Mouth animation (open/close cycle).
- Pellet system with respawn when all are eaten.
- Score counter displayed on screen.
- Ghost with random direction changes and collision detection.
- Fruit power-up with a harmless timer for the ghost.
- Single-lane movement with screen wrapping.
- Simple, clean code that’s easy to tweak (e.g., speed, pellet count).

## Controls
- **SPACE** — reverse PacMan’s direction.

## How to Run
1. Download or clone this repository.
2. Open `PacMan.pde` in the **Processing** IDE (Processing 3 or later).
3. Click **Run**.

## File Structure
PacMan.pde # Main sketch (all game logic, rendering, input)

## Key Implementation Notes
- Adjustable settings at the top of the sketch:
  - `speed` — movement speed for PacMan and the ghost.
  - `pelletCount` — number of pellets laid out across the lane.
- Fruit power-up uses a frame-based timer (`ghostHarmlessTimer` ≈ 180 frames ≈ ~3 seconds at ~60 FPS).
- Pellets are managed with parallel arrays for **position** and **eaten** state.

## (Optional) Future Ideas
- Restart key and start/game-over screens.
- Multiple lanes or maze, walls, and proper pathfinding ghosts.
- Sound effects and sprite graphics.
- High-score tracking.

## Screenshot / Demo

<img src="assets/PacManGIF.gif" alt="PacMan Demo" width="500"/>
