# test.R

## ---- scatter ----------
x <- rnorm(100)
y <- rnorm(100)
print(plot(y ~ x, pch = 19))

## ---- hists ----------
par(mfrow = c(1, 2))
hist(x)
hist(y)
