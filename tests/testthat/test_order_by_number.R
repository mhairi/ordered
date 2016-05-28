library(ordered)
context('Test that order_by_number function does as expected')

test_that('Ordering works as expected',
          {
            f <- c('group_1', 'group_2', 'group_3')
            expect_equal(
              order_by_number(f),
              factor(f, levels = f, ordered = TRUE)
            )
            f <- c('group_1', 'group_2', 'group_3')
            expect_equal(
              order_by_number(f, desc = TRUE),
              factor(f, levels = f[3:1], ordered = TRUE)
            )
            f <- c('group_1', 'group_4', 'group_3', 'group_1', 'group_4')
            expect_equal(
              order_by_number(f),
              factor(f, levels = f[c(1, 3, 2)], ordered = TRUE)
            )
            f <- c('group2556g', 'group3456h', 'group88888_d-d')
            expect_equal(
              order_by_number(f),
              factor(f, levels = f, ordered = TRUE)
            )
          })


test_that('Ties are accepted',
          {
            f <- c('group_1', 'group_2', 'groups_2')
            expect_equal(
              order_by_number(f),
              factor(f, levels = f, ordered = TRUE)
            )
          })


test_that('No number are lowest.',
          {
            f <- c('group_1', 'group_2', 'group')
            expect_equal(
              order_by_number(f),
              factor(f, levels = f[c(3, 1, 2)], ordered = TRUE)
            )
          })


test_that('First number present is used',
          {
            f <- c('group_1_8', 'group_2_7', 'group_3_7')
            expect_equal(
              order_by_number(f),
              factor(f, levels = f, ordered = TRUE)
            )
          })
