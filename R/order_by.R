#' Order a factor by the levels of another variable.
#'
#' The factor and the order must be of the same length
#' and each value of factor must correspond with one
#' value of order.
#'
#' This is useful when you have unique values of factor
#' and numeric, but can be useful in other circumstances
#' when another variable corresponds to the ordering of the
#' factor.
#'
#' Ties are arbitrarily ordered for unique factors.
#'
#' @param factor A factor or character vector.
#' @param order A numeric variable (or coercible  to numeric).
#' @param desc Set to TRUE to order descending.
#'
#' @return An ordered factor.
#' @export
#'
#' @examples
#' # Ordering a factor where the values are unique
#' order_by(letters[1:3], 1:3)
#'
#' # Ordering a factor by a variable that provides the levels
#' order_by(c('a', 'a', 'b'), c(1, 1, 2))
#'
order_by <- function(factor, order, desc = FALSE){

  # Checking and coerceing inputs
  if (!inherits(order, 'numeric')) order <- as.numeric(order)

  if (any(is.na(order) & !is.na(factor))){
    stop('An element of order is missing while the element of factor is not missing')
  }

  type_checking(factor, order, desc)

  # Need to remove duplicates
  pairs <- data.frame(factor = factor, order = order)
  unique_pairs <- pairs[!duplicated(pairs),]

  if (nrow(unique_pairs) != length(unique(factor))) stop('More than one value of order for each value of factor. Do you want to use order_by_summary?')

  levels <- unique_pairs$factor[order(unique_pairs$order)]

  if (desc) levels <- rev(levels)

  return(factor(factor, levels = levels, ordered = TRUE))
}


#' Order a factor by the summary statistic of another variable.
#'
#' The factor and the order must be of the same length. The
#' order is summarised by the levels of factor, using the
#' summary function. The outcome of summarising is used
#' to order the factor variable.
#'
#' Ties are arbitrarily ordered.
#'
#' @param factor A factor or character vector.
#' @param order A numeric.
#' @param desc Set to TRUE to order descending.
#' @param summary A function to apply to each subset of order
#' which will return a single number
#' @param ... Further arguments to summary
#'
#' @return An ordered factor
#' @export
#'
#' @examples
#' factor = letters[rep(c(1, 2), 2)]
#' order = 1:4
#' order_by_summary(factor, order)
order_by_summary <- function(factor,
                              order,
                              summary = sum,
                              desc = FALSE,
                              ...){

  # Checking and coerceing inputs
  if (!inherits(order, 'numeric')) order <- as.numeric(order)

  if (!inherits(summary, 'function')) stop('summary should be a function')

  type_checking(factor, order, desc)

  # Summarise
  summarised <- tapply(order, factor, summary, ...)

  if (any(is.na(summarised))) stop('Missing vaues in summary function (try na.rm = TRUE)')

  levels <- names(summarised)[order(summarised)]

  if (desc) levels <- rev(levels)

  return(factor(factor, levels = levels, ordered = TRUE))
}



