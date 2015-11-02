library(ordered)
context('Test that order_by function does as expected')

test_that('factors are being returned with the right levels.',
  {
  expect_equal(
    order_by(letters[1:3], 1:3),
    factor(letters[1:3], levels = letters[1:3], ordered = TRUE)
  )
  expect_equal(
    order_by(letters[1:3], 1:3, TRUE),
    factor(letters[1:3], levels = letters[3:1], ordered = TRUE)
  )
  expect_equal(
    order_by(rep(letters[1:3], 3), rep(1:3, 3)),
    factor(rep(letters[1:3], 3), levels = letters[1:3], ordered = TRUE)
  )
  expect_equal(order_by(c('a', 'b', 'c', 'c'), c(10, 10.1, 10.1001, 10.1001)),
               factor(letters[c(1:3, 3)], levels = letters[1:3], ordered = TRUE)
  )
})

test_that('we have good behaviour regarding missing values.',
  {
  expect_equal(
    order_by(c(letters[1:3], NA), 1:4),
    factor(c(letters[1:3], NA), levels = letters[1:3], ordered = TRUE)
  )
  expect_equal(
    order_by(c(letters[1:3], NA), c(1:3, 3)),
    factor(c(letters[1:3], NA), levels = letters[1:3], ordered = TRUE)
  )
  expect_equal(
    order_by(c(letters[1:3], NA), c(1:3, NA)),
    factor(c(letters[1:3], NA), levels = letters[1:3], ordered = TRUE)
  )
})

test_that('we have failures where we expect failures,',
  {
  expect_error(order_by(c(letters[1:4]), c(1:3, NA)))
  expect_error(order_by(c('a', 'a', 'b', 'a'), c(1, 2, 5, 1)))
})

test_that('ties do not fail',
  {
  expect_equal(
    order_by(c(letters[1:3]), c(1:2, 2)),
    factor(letters[1:3], levels = letters[1:3], ordered = TRUE)
  )
  expect_equal(
      order_by(c('a', 'a', 'b'), rep(1, 3)),
      factor(c('a', 'a', 'b'), levels = letters[1:2], ordered = TRUE)
  )
})

