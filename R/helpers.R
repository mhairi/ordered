type_checking <- function(factor, order, rev){
  # Standard type checking
  if (length(factor) != length(order)){
    stop('factor and order not the same length')
  }
  if (!inherits(factor, 'factor') & !inherits(factor, 'character')){
    stop('factor not a factor or character vector')
  }
  if (!inherits(order, 'numeric')){
    stop('order must be numeric')
  }
  if (!inherits(rev, 'logical')){
    stop('rev must be TRUE or FALSE')
  }
  return(NULL)
}

