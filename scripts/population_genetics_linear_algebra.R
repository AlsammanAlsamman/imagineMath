args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])

if (length(script_path) == 0) {
  stop("Run this file with Rscript so the script location can be detected.")
}

project_root <- normalizePath(file.path(dirname(script_path), ".."), winslash = "/")
output_dir <- file.path(project_root, "outputs")
dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

triangle_height <- sqrt(3) / 2

to_xy <- function(probabilities) {
  x <- probabilities[2] + 0.5 * probabilities[3]
  y <- triangle_height * probabilities[3]
  c(x, y)
}

iterate_linear_system <- function(transition_matrix, initial_state, steps) {
  path <- matrix(0, nrow = steps + 1, ncol = length(initial_state))
  path[1, ] <- initial_state

  for (step in seq_len(steps)) {
    path[step + 1, ] <- transition_matrix %*% path[step, ]
  }

  path
}

plot_mutation_dynamics <- function() {
  u <- 0.04
  v <- 0.01
  mutation_matrix <- matrix(c(1 - u, v,
                              u, 1 - v),
                            nrow = 2,
                            byrow = TRUE)

  initial_a <- c(0.98, 0.8, 0.55, 0.2, 0.03)
  generations <- 35
  equilibrium_a <- v / (u + v)
  colors <- c("#0B6E4F", "#C1121F", "#1D3557", "#BC6C25", "#6A4C93")

  png(file.path(output_dir, "01_mutation_two_allele.png"), width = 1100, height = 700)
  par(mar = c(5, 5, 5, 2))

  plot(c(0, generations), c(0, 1),
       type = "n",
       xlab = "Generation",
       ylab = "Allele A frequency",
       main = "Two-Allele Mutation As a Linear Transformation")

  grid(col = "#DDDDDD")
  abline(h = equilibrium_a, lty = 2, lwd = 2, col = "#444444")

  for (index in seq_along(initial_a)) {
    initial_state <- c(initial_a[index], 1 - initial_a[index])
    path <- iterate_linear_system(mutation_matrix, initial_state, generations)
    lines(0:generations, path[, 1], lwd = 3, col = colors[index])
    points(0:generations, path[, 1], pch = 16, cex = 0.55, col = colors[index])
  }

  legend("topright",
         legend = c(sprintf("start p(A)=%.2f", initial_a),
                    sprintf("equilibrium p(A)=%.3f", equilibrium_a)),
         col = c(colors, "#444444"),
         lty = c(rep(1, length(colors)), 2),
         lwd = c(rep(3, length(colors)), 2),
         pch = c(rep(16, length(colors)), NA),
         bty = "n")

  mtext("Each generation applies p_{t+1} = M p_t, where M mixes mutation away from A and back into A.", side = 3, line = 0.6)
  mtext(sprintf("M = [[%.2f, %.2f], [%.2f, %.2f]]", 1 - u, v, u, 1 - v), side = 3, line = -0.6)
  dev.off()
}

plot_migration_dynamics <- function() {
  migration_rate <- 0.12
  migration_matrix <- matrix(c(1 - migration_rate, migration_rate,
                               migration_rate, 1 - migration_rate),
                             nrow = 2,
                             byrow = TRUE)

  initial_states <- rbind(
    c(0.95, 0.05),
    c(0.85, 0.35),
    c(0.20, 0.80),
    c(0.10, 0.55),
    c(0.60, 0.15)
  )
  generations <- 18
  colors <- c("#0F4C5C", "#E36414", "#6A994E", "#7B2CBF", "#C32F27")

  png(file.path(output_dir, "02_migration_two_deme.png"), width = 850, height = 850)
  par(mar = c(5, 5, 5, 2))

  plot(c(0, 1), c(0, 1),
       type = "n",
       xlab = "Population 1 allele A frequency",
       ylab = "Population 2 allele A frequency",
       main = "Migration Matrix Pulls Populations Toward Shared Composition",
       asp = 1)

  grid(col = "#E0E0E0")
  abline(a = 0, b = 1, lty = 2, lwd = 2, col = "#444444")

  for (index in seq_len(nrow(initial_states))) {
    path <- iterate_linear_system(migration_matrix, initial_states[index, ], generations)
    lines(path[, 1], path[, 2], col = colors[index], lwd = 3)
    points(path[, 1], path[, 2], pch = 16, cex = 0.8, col = colors[index])
    arrows(path[-nrow(path), 1], path[-nrow(path), 2],
           path[-1, 1], path[-1, 2],
           length = 0.06, angle = 18, col = colors[index])
  }

  legend("bottomright",
         legend = apply(initial_states, 1, function(state) sprintf("start=(%.2f, %.2f)", state[1], state[2])),
         col = colors,
         lwd = 3,
         pch = 16,
         bty = "n")

  mtext("x_{t+1} = M x_t averages the two demes. The diagonal p1 = p2 is the shared-frequency subspace.", side = 3, line = 0.6)
  dev.off()
}

plot_three_allele_simplex <- function() {
  mutation_matrix <- matrix(c(0.92, 0.04, 0.02,
                              0.05, 0.90, 0.06,
                              0.03, 0.06, 0.92),
                            nrow = 3,
                            byrow = TRUE)

  initial_states <- rbind(
    c(0.96, 0.02, 0.02),
    c(0.05, 0.90, 0.05),
    c(0.08, 0.15, 0.77),
    c(0.55, 0.35, 0.10),
    c(0.20, 0.30, 0.50)
  )
  generations <- 28
  colors <- c("#9A031E", "#005F73", "#EE9B00", "#6A4C93", "#2B9348")

  vertex_a <- c(0, 0)
  vertex_b <- c(1, 0)
  vertex_c <- c(0.5, triangle_height)

  png(file.path(output_dir, "03_three_allele_simplex.png"), width = 900, height = 850)
  par(mar = c(4, 4, 5, 2))

  plot(c(-0.05, 1.05), c(-0.05, triangle_height + 0.07),
       type = "n",
       axes = FALSE,
       xlab = "",
       ylab = "",
       main = "Three-Allele Mutation Moves States Inside the Simplex",
       asp = 1)

  polygon(c(vertex_a[1], vertex_b[1], vertex_c[1]),
          c(vertex_a[2], vertex_b[2], vertex_c[2]),
          border = "#333333",
          lwd = 2,
          col = "#FAFAFA")

  text(vertex_a[1] - 0.03, vertex_a[2] - 0.02, "A", cex = 1.2)
  text(vertex_b[1] + 0.03, vertex_b[2] - 0.02, "B", cex = 1.2)
  text(vertex_c[1], vertex_c[2] + 0.04, "C", cex = 1.2)

  for (index in seq_len(nrow(initial_states))) {
    path <- iterate_linear_system(mutation_matrix, initial_states[index, ], generations)
    xy_path <- t(apply(path, 1, to_xy))
    lines(xy_path[, 1], xy_path[, 2], lwd = 3, col = colors[index])
    points(xy_path[, 1], xy_path[, 2], pch = 16, cex = 0.65, col = colors[index])
    arrows(xy_path[-nrow(xy_path), 1], xy_path[-nrow(xy_path), 2],
           xy_path[-1, 1], xy_path[-1, 2],
           length = 0.05, angle = 18, col = colors[index])
  }

  legend("topright",
         legend = apply(initial_states, 1, function(state) sprintf("start=(%.2f, %.2f, %.2f)", state[1], state[2], state[3])),
         col = colors,
         lwd = 3,
         pch = 16,
         cex = 0.85,
         bty = "n")

  mtext("A 3 x 3 mutation matrix acts on allele-frequency vectors that must stay inside the probability simplex.", side = 3, line = 0.6)
  dev.off()
}

plot_population_structure_pca <- function() {
  set.seed(7)

  snp_count <- 90
  individuals_per_group <- 55
  group_means <- list(
    seq(0.15, 0.35, length.out = snp_count),
    seq(0.45, 0.65, length.out = snp_count),
    seq(0.20, 0.75, length.out = snp_count)^0.9
  )

  simulate_group <- function(probabilities) {
    samples <- matrix(0, nrow = individuals_per_group, ncol = snp_count)

    for (snp in seq_len(snp_count)) {
      samples[, snp] <- rbinom(individuals_per_group, size = 2, prob = probabilities[snp])
    }

    samples
  }

  group_data <- lapply(group_means, simulate_group)
  genotype_matrix <- do.call(rbind, group_data)
  labels <- factor(rep(c("Population 1", "Population 2", "Population 3"), each = individuals_per_group))
  colors <- c("#1B4332", "#9C6644", "#5A189A")

  pca <- prcomp(genotype_matrix, center = TRUE, scale. = TRUE)
  variance_explained <- 100 * (pca$sdev^2 / sum(pca$sdev^2))

  png(file.path(output_dir, "04_population_structure_pca.png"), width = 950, height = 760)
  par(mar = c(5, 5, 5, 2))

  plot(pca$x[, 1], pca$x[, 2],
       col = colors[labels],
       pch = 16,
       cex = 1,
       xlab = sprintf("PC1 (%.1f%% variance)", variance_explained[1]),
       ylab = sprintf("PC2 (%.1f%% variance)", variance_explained[2]),
       main = "PCA Uses Linear Algebra To Reveal Population Structure")

  grid(col = "#E0E0E0")
  legend("topright",
         legend = levels(labels),
         col = colors,
         pch = 16,
         bty = "n")

  mtext("After centering the genotype matrix, PCA rotates the data onto directions of maximal variation.", side = 3, line = 0.6)
  dev.off()
}

plot_mutation_dynamics()
plot_migration_dynamics()
plot_three_allele_simplex()
plot_population_structure_pca()

message("Created plots in: ", output_dir)