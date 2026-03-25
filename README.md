# Imagine Math

> *Feel the structure behind formulas. See the rules that make mathematics work.*

Imagine Math is an interactive visual lab for mathematics. Every module answers one question through animation, geometry, and live controls — so you can imagine how a concept works, not just read its formula.

---

## Why This Exists

Most math tools either compute answers or show static graphs. This project does neither. It is built around one idea:

**You understand mathematics better when you can watch it move.**

Instead of memorizing rules, you manipulate them. You drag a vector and watch the whole coordinate space transform. You slide a matrix entry and watch the determinant change in real time. You see the grid bend.

---

## Live Modules

| Module | Question | Open |
|--------|----------|------|
| Linear Transformation | Why does a matrix move all of space, not just one vector? | [open](visualizations/linear-transformation.html) |

More modules are planned across linear algebra, calculus, statistics, and dynamical systems.

---

## How To Use

No installation. No server. No build step.

1. Clone or download this repository
2. Open any file inside `visualizations/` directly in your browser
3. Interact — drag, slide, press Play, change presets

```bash
git clone https://github.com/YOUR_USERNAME/imagineMath.git
```

Then double-click any `.html` file in the `visualizations/` folder.

---

## What Each Module Contains

Every visualization follows the same structure:

- **One question** — the mathematical idea being explored
- **Animated canvas** — space that moves and bends as you interact
- **Play button and morph slider** — watch the transformation happen smoothly
- **Draggable objects** — manipulate the math by touching the picture
- **Presets** — named examples that show distinct mathematical behaviors
- **Live readout** — exact numeric values updating in real time
- **Insight panel** — plain-language explanation of what the current state means

---

## Topics Covered

### Linear Algebra
- Matrix as linear transformation
- Determinant as area scaling
- Eigenvectors and eigenvalues
- Cramer's Rule
- Basis vectors and coordinate systems

### Calculus
- Derivative as tangent slope
- Integral as accumulation
- Riemann sums
- Gradient and optimization

### Statistics and Probability
- Normal distribution mean and variance
- Linear regression intuition
- Confidence intervals
- Sampling behavior

### Dynamical Systems
- Phase portraits
- Stability and equilibrium
- Oscillation and feedback

### Applied Mathematics
- Population genetics through linear transformations
- Migration and mutation as matrix systems
- PCA for structure detection

---

## Repository Structure

```
imagineMath/
  README.md                          ← this file
  visualizations/                    ← interactive HTML modules (open in browser)
  scripts/                           ← R and Python supporting scripts
  outputs/                           ← generated plots from scripts
  docs/                              ← mathematical notes per module
  prompts/                           ← agent and contributor guidelines
```

---

## Contributing a New Module

Every new module must be a single self-contained HTML file in `visualizations/`.
The full visualization standard — required elements, layout, color system, behavior rules — is documented in [prompts/README.md](prompts/README.md).

---

## Mission

Imagine Math exists to close the gap between formulas and understanding.

The goal is to help you move from:

- symbols → geometric meaning
- equations → motion
- procedures → intuition
- memorization → imagination
