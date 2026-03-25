# Imagine Math

Imagine Math is an interactive project for visualizing mathematics, statistics, algebra, calculus, and dynamical systems in a way that builds intuition.

The goal is not only to calculate results. The goal is to help people imagine how mathematics works.

Every visualization should answer a question.

Examples:
- Why does matrix-vector multiplication represent a linear transformation?
- Why does the determinant describe area scaling?
- Why does Cramer's Rule solve a system of linear equations?
- What does a derivative mean geometrically?
- How does an integral represent accumulation?

## Vision

This project is a visual intuition lab for mathematics.

Instead of starting with formulas only, each module starts with a mathematical question, then uses motion, interaction, diagrams, and small experiments to make the idea visible.

The platform should help users:
- see the structure behind formulas
- understand rules through interaction
- connect equations to geometry and motion
- build intuition before formalism

## Core Principle

Each module should answer one main question.

Good example:
- What happens to the unit square under this matrix?

Weak example:
- Learn all of linear algebra

If a module tries to teach too much at once, it becomes harder to understand. A focused question makes the visualization clearer and more useful.

## Learning Model

Each visualization module should follow the same structure:

1. Question
2. Intuition
3. Interactive visualization
4. Mathematical rule
5. Formula
6. What to notice
7. Real-world or conceptual application

This keeps the experience consistent and helps the user move from visual understanding to formal understanding.

## Example Topics

### Linear Algebra
- vector addition and scaling
- matrix-vector multiplication
- basis vectors and coordinate systems
- determinant as area scaling
- eigenvectors and eigenvalues
- Cramer's Rule in 2D and 3D

### Calculus
- derivative as tangent slope
- derivative as local rate of change
- integral as accumulation
- Riemann sums and area
- parametric motion
- gradient and optimization intuition

### Statistics and Probability
- mean and variance
- normal distribution behavior
- sampling intuition
- regression as fitting
- correlation versus causation
- confidence intervals as uncertainty bands

### Dynamical Systems
- phase portraits
- equilibrium points
- stability and instability
- oscillation and feedback
- discrete iteration and chaos

## First Modules To Build

Recommended MVP:

1. Vector addition and scaling
2. Matrix as linear transformation
3. Determinant as area scaling
4. Cramer's Rule in 2D
5. Derivative as tangent slope
6. Integral as accumulation
7. Normal distribution with mean and variance sliders
8. Linear regression intuition

These modules are visual, foundational, and strong enough to define the style of the project.

## Example Module Template

### Title
Matrix as Linear Transformation

### Main Question
Why does multiplying a vector by a matrix transform space?

### Intuition
A matrix does not only transform one vector. It transforms the entire coordinate system. When the basis changes, every vector changes with it.

### Visualization
- draw a 2D grid
- show the standard basis vectors
- show an input vector
- apply the matrix to the basis and the vector
- animate how the grid changes
- allow the user to change matrix entries with sliders

### Rule
The columns of a matrix show where the basis vectors move.

### Formula
For a matrix $A$ and vector $x$, the transformed vector is $Ax$.

### What To Notice
- the whole space changes, not just one point
- area may stretch or collapse
- some transformations preserve orientation, others flip it

### Application
Computer graphics, robotics, physics, and machine learning all rely on linear transformations.

## Design Rules

To keep the project useful and coherent:

- one module should answer one question
- visuals should clarify meaning, not decorate the page
- controls should change the mathematical behavior, not just the appearance
- formulas should support the visual explanation, not replace it
- examples can use simplified or synthetic data when real data is unnecessary
- each module should end with a clear takeaway

## Visualization Standard — How Every Module Must Be Built

This section defines the exact style every agent or contributor must follow when creating a new module. The reference implementation is [visualizations/linear-transformation.html](visualizations/linear-transformation.html).

### Format

Every interactive module must be a single self-contained HTML file.

- no build step required
- opens directly in any browser by double-clicking the file
- all logic, styles, and assets are inline or loaded from a CDN
- no local server, no framework, no compilation

### Required Visual Elements

Every module must include all of the following:

**1. A live animated canvas**
The main area must animate the mathematical idea. The user should be able to watch the concept move and change, not only look at a static picture.

**2. A morph / play animation**
Every module must have a Play button and a slider that morphs the visualization continuously between the start state and the end state. For example, the grid morphs from the original coordinate space to the transformed coordinate space.

**3. Interactive controls tied to math parameters**
Sliders, number inputs, or drag handles must change the actual mathematical parameters, not cosmetic properties. Moving a slider changes the matrix, the function value, the probability, or the physical constant — and the visualization updates immediately.

**4. Drag interaction on the main object**
The main mathematical object (a vector tip, a point on a curve, a distribution handle) must be draggable directly on the canvas. The user should be able to manipulate the math by touching the picture, not only by typing numbers.

**5. Preset library**
Every module must include a row of named preset buttons. Each preset loads a meaningful configuration that demonstrates a distinct behavior. Examples for a transformation module: Identity, Rotate 90°, Shear, Collapse. Examples for a calculus module: Linear, Quadratic, Sinusoidal, Exponential.

**6. Live numeric readout panel**
A panel must show the current values of all relevant mathematical quantities updating in real time as the user interacts. For transformations this means: input vector, output vector, determinant, area scale. For derivatives this means: x position, f(x), f'(x), slope. The readout makes the formula feel real.

**7. Insight text block**
A short sentence or two that interprets the current state in plain language. This text must change dynamically as parameters change. It connects what the user sees on screen to the mathematical meaning. It should complete the sentence "What this means is...".

**8. Dark theme with high contrast colors**
All modules use a dark background (near `#0f1117`). Mathematical objects use distinct, saturated colors: original objects in warm tones (gold, amber, lime), transformed objects in cool tones (cyan, blue), axes in muted gray. The color language must be consistent across the whole project.

### Visual Layer Rules

- the grid or space itself must be visible and must change when the transformation changes
- the original state must remain visible as a ghost or faint reference when morphed
- arrows must have arrowheads
- labels must be placed next to objects, not in a separate legend only
- no clutter — remove anything that does not directly explain the math

### Behavior Rules

- controls must respond immediately with no delay
- animation must be smooth (requestAnimationFrame, not setTimeout)
- the visualization must never break or go blank for edge-case inputs (zero vector, singular matrix, degenerate input)
- dragging must feel direct and responsive

### What Each Module Must Teach

Every module must make one claim visually that the user could not easily understand from the formula alone. The visual must add something the formula does not show on its own.

Examples of claims that are worth visualizing:
- the matrix does not move one vector, it moves all of space at once
- the determinant is the area of the parallelogram formed by the column vectors
- the derivative is the slope of the curve at exactly one point, not across an interval
- the integral is the accumulating sum of infinitely thin slices
- eigenvectors are the directions that a matrix leaves unchanged in direction

If the visualization only shows the formula result without showing this deeper claim, it must be redesigned.

### Page Layout

Every file must follow this layout from top to bottom:

1. Title and one-sentence question
2. Short intuition paragraph in plain language
3. Main canvas (full width on small screens, left column on wide screens)
4. Controls panel (right column on wide screens, below canvas on small screens)
5. Live readout
6. Insight block

### Technology Direction

Primary: plain HTML + JavaScript + D3.js (loaded from CDN)
Formulas: KaTeX (loaded from CDN) where needed
Charts: D3.js or Plotly (loaded from CDN)
No React, no bundler, no build pipeline for individual modules

Python and R may be used for generating supporting plots or static images but are not used for interactive browser modules.

The reason for keeping modules as plain HTML files:
- no setup cost for the viewer
- works offline
- easy to share
- the mathematics is front and center, not the toolchain

## Repository Goals

This repository should eventually contain:

- a small web application for interactive math modules
- reusable visualization components
- a clear content structure for modules and lessons
- notes explaining the mathematical question behind each module
- room to expand into algebra, calculus, statistics, and dynamics

## Proposed Folder Structure

```text
imagineMath/
  README.md
  docs/
    module-specs/
  app/
    components/
    modules/
    math/
    styles/
```

## Project Mission

Imagine Math exists to make mathematics feel visible.

The project should help users move from:

- abstract symbols to geometric meaning
- formulas to motion
- procedures to understanding
- memorization to intuition

## Next Step

The best next implementation step is to build the first module:

Matrix as Linear Transformation

That module captures the spirit of the project and establishes the visual and educational pattern for everything that follows.