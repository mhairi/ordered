type_checking <- function(factor, order = numeric(length(factor)), desc = TRUE){
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
  if (!inherits(desc, 'logical') | length(desc) > 1){
    stop('desc must be TRUE or FALSE')
  }
  return(NULL)
}

