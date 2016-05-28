#' Order by the numbers in a factor.
#'
#' Order the factor by the numbers used in the factor. This function
#' orders on symbolic numbers: 1, 2, 3 etc.
#'
#' Numbers present in the factor levels will be extracted and
#' used to order the factor. If more than one continous number is
#' present in the factor level then the first number will be used for
#' numbering.
#'
#' Ties between two different factor levels are ordered arbitarly.
#'
#' Factor levels without numbers are ordered lowest artibarily.
#'
#' @param factor The factor you want to order
#' @param desc Set to TRUE to order descending.
#'
#' @return an ordered factor
#' @export
#'
#' @examples
#' f <- c('group_1', 'group_2', 'group_3')
#' order_by_number(f)
#'
#' factor <- c('a_3', 'a_3', 'a_1', 'a', 'b')
#' order_by_number(factor)
order_by_number <- function(factor, desc = FALSE){

  # Type checking
  type_checking(factor, desc = desc)

  # Find the levels
  f <- as.factor(factor)
  levels <- levels(f)

  # Extract the first number
  matches <- regmatches(levels, gregexpr('[0-9]+', levels))
  numbers <- lapply(matches, function(x) ifelse(length(x) == 0, NA, x))
  numbers <- as.numeric(numbers)

  # Order factor
  f <- factor(f, levels = levels[order(numbers, na.last = FALSE, decreasing = desc)], ordered = TRUE)

  return(f)
}
