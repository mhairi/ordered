library(ordered)
context('Test that order_factor_by_summary function does as expected')

test_that('factors are being returned with the right levels.',
          {
            expect_equal(
              order_factor_by_summary(rep(letters[1:3], 3), 1:9),
              factor(rep(letters[1:3], 3), levels = letters[1:3], ordered = TRUE)
            )
            expect_equal(
              order_factor_by_summary(rep(letters[1:3], 3), 1:9, mean),
              factor(rep(letters[1:3], 3), levels = letters[1:3], ordered = TRUE)
            )
            expect_equal(
              order_factor_by_summary(rep(letters[1:3], 3), 1:9, mean, TRUE),
              factor(rep(letters[1:3], 3), levels = letters[3:1], ordered = TRUE)
            )
          })

test_that('we have good behaviour regarding missing values.',
          {
            expect_error(
              order_factor_by_summary(rep(letters[1:3], 3), c(1:8, NA))
            )
            expect_equal(
              order_factor_by_summary(rep(letters[1:3], 3), c(1:8, NA), na.rm = TRUE),
              factor(rep(letters[1:3], 3), levels = letters[c(3, 1, 2)], ordered = TRUE)
            )
            expect_equal(
              order_factor_by_summary(c(rep('a', 3), NA), c(1:4)),
              factor(c(rep('a', 3), NA), levels = 'a', ordered = TRUE)
            )
          })

test_that('ties do not fail',
          {
            expect_equal(
              order_factor_by_summary(rep(letters[1:3], 2), rep(1, 6)),
              factor(rep(letters[1:3], 2), levels = letters[1:3], ordered = TRUE)
            )
          })

