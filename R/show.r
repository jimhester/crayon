
#' Show the ANSI colors on the screen
#'
#' @param colors Number of colors to show, meaningful values
#'   are 8 and 256. It is automatically set to the number of
#'   supported colors, if not specified.
#' @return The printed string, invisibly.
#'
#' @export

show_ansi_colors <- function(colors = num_colors()) {
  if (colors < 8) {
    cat("Colors are not supported")
  } else if (colors < 256) {
    cat(ansi_colors_8, sep = "")
    invisible(ansi_colors_8)
  } else {
    cat(ansi_colors_256, sep = "")
    invisible(ansi_colors_256)
  }
}

ansi_colors_256_col <-
  sapply(0:5, function(r) {
    sapply(0:5, function(g) {
      c(sapply(0:5, function(b) {
        s <- paste0("r:", r, " g:", g, " b:", b, " ")
        style(s, as = "grey", bg = rgb(r, g, b, maxColorValue = 5))
      }), "\n")
    })
  })

ansi_colors_256_grey <-
  sapply(0:23, function(g) {
    s <- paste0("grey ", format(g, width = 2), "    ")
    style(s, as = "grey", bg = grey(g / 23)) %+%
      (if ((g + 1) %% 6) "" else "\n")
  })

ansi_colors_256 <- c(ansi_colors_256_col, "\n", ansi_colors_256_grey)

ansi_colors_8 <-
  multicol(sapply(seq_along(builtin_styles), function(s) {
    st <- names(builtin_styles)[s]
    styled <- st %+% ": " %+% style("foobar", as = st) %+% " "
  }))
