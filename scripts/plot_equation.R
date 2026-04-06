# Plot: x^3 = 9x^2 + 22x
# Rearranged as f(x) = x^3 - 9x^2 - 22x = 0
# Roots: x = 0, x = -2, x = 11

x <- seq(-5, 14, length.out = 1000)
y <- x^3 - 9*x^2 - 22*x

# Find roots analytically
roots <- c(-2, 0, 11)

plot(x, y,
     type = "l",
     lwd  = 2.5,
     col  = "steelblue",
     main = expression(x^3 == 9*x^2 + 22*x),
     xlab = "x",
     ylab = expression(f(x) == x^3 - 9*x^2 - 22*x),
     ylim = c(min(y), max(y))
)

# Zero reference line
abline(h = 0, col = "gray40", lty = 2)
abline(v = 0, col = "gray40", lty = 2)

# Mark the roots
points(roots, rep(0, length(roots)),
       pch  = 21,
       bg   = "tomato",
       col  = "darkred",
       cex  = 1.8)

# Label the roots
text(roots, rep(0, length(roots)),
     labels = paste0("x = ", roots),
     pos    = c(3, 4, 3),
     offset = 0.8,
     col    = "darkred",
     font   = 2)

grid(col = "lightgray", lty = 1)
