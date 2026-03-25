# Population Genetics Through Linear Algebra

This note explains the visualizations in [scripts/population_genetics_linear_algebra.R](../scripts/population_genetics_linear_algebra.R).

The point of these plots is not only to show data. The point is to show how a matrix or a linear method acts on a biological state.

## Why Linear Algebra Appears Here

Population genetics often tracks a state vector.

Examples of state vectors:
- allele frequencies in one population
- allele frequencies across several populations
- genotype or ancestry summaries across many individuals

Once the biological rule can be written as a matrix action, the next state is computed with:

$$
x_{t+1} = M x_t
$$

That is the central linear algebra idea in these examples.

## Plot 1: Two-Allele Mutation

Output: [outputs/01_mutation_two_allele.png](../outputs/01_mutation_two_allele.png)

State vector:

$$
x_t = \begin{bmatrix} p_t(A) \\ p_t(a) \end{bmatrix}
$$

Mutation model:

$$
x_{t+1} =
\begin{bmatrix}
1-u & v \\
u & 1-v
\end{bmatrix} x_t
$$

What to notice:
- each starting population moves toward the same equilibrium
- the matrix mixes probability mass between alleles
- repeated matrix multiplication creates the full trajectory

Intuition:
The mutation matrix is a machine that redistributes frequency from one allele to the other each generation.

## Plot 2: Migration Between Two Populations

Output: [outputs/02_migration_two_deme.png](../outputs/02_migration_two_deme.png)

State vector:

$$
x_t = \begin{bmatrix} p_t^{(1)}(A) \\ p_t^{(2)}(A) \end{bmatrix}
$$

Migration model:

$$
x_{t+1} =
\begin{bmatrix}
1-m & m \\
m & 1-m
\end{bmatrix} x_t
$$

What to notice:
- every point moves toward the diagonal line $p_1 = p_2$
- the diagonal is the subspace where both populations have the same allele frequency
- migration is visually an averaging transformation

Intuition:
Linear algebra lets you think of migration as moving points in a state plane until differences between populations shrink.

## Plot 3: Three-Allele Mutation In the Simplex

Output: [outputs/03_three_allele_simplex.png](../outputs/03_three_allele_simplex.png)

State vector:

$$
x_t = \begin{bmatrix} p_t(A) \\ p_t(B) \\ p_t(C) \end{bmatrix}, \quad p_t(A)+p_t(B)+p_t(C)=1
$$

Model:

$$
x_{t+1} = M x_t
$$

with a $3 \times 3$ mutation matrix.

What to notice:
- every valid population state stays inside the triangle because the coordinates remain probabilities
- the matrix does not move points randomly; it moves them along structured paths
- the simplex is the geometric home of all possible allele-frequency states

Intuition:
The triangle is a probability space. Linear algebra shows how a biological rule pushes populations around inside that space.

## Plot 4: PCA For Population Structure

Output: [outputs/04_population_structure_pca.png](../outputs/04_population_structure_pca.png)

This is a different use of linear algebra.

Instead of modeling time evolution, PCA analyzes a genotype matrix and finds directions of strongest variation.

What to notice:
- individuals from similar populations cluster together
- PCA rotates the data into new axes called principal components
- those axes are chosen by eigenvalue and singular value structure

Intuition:
Here linear algebra is not advancing a population forward in time. It is changing coordinates so hidden structure becomes visible.

## How To Run

From the repository root, run:

```powershell
Rscript scripts/population_genetics_linear_algebra.R
```

The generated images will appear in [outputs](../outputs).

## How To Read These Visuals

Use this sequence when looking at any plot:

1. Identify the state vector.
2. Ask what the matrix is doing to that state.
3. Look for fixed points, convergence, or geometric constraints.
4. Connect the picture back to the biological meaning.

That is the practical bridge from linear algebra to population genetics.