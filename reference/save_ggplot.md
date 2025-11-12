# Custom ggsave wrapper set with Nature's formatting guidelines (width-locked)

See:
https://www.nature.com/documents/NRJs-guide-to-preparing-final-artwork.pdf
It's pretty strict. A one column figure is 88 mm wide and a two column
figure is 180 mm wide. Depending on the length of the figure caption,
there are different maximum heights (see the PDF). Most figures types
must be in vector format to prevent quality loss when zooming in. Ever
since I found these guidelines, I use them for all figures, even if they
are not for Nature... Because it looks nice and I like it.

## Usage

``` r
save_ggplot(
  plot,
  path,
  ncol = 1,
  height = 90,
  show = FALSE,
  verbose = TRUE,
  ...
)
```

## Arguments

- plot:

  The ggplot object to save.

- path:

  A character string with the path to save the plot.

- ncol:

  The number of columns for the plot. Either 1 (default) or 2.

- height:

  The height of the plot in mm. Default is 90 mm.

- show:

  Logical. Whether to return the plot visibly or not. Default is FALSE,
  the plot is returned invisibly.

- verbose:

  Logical. Whether to print a message in the console when the saving is
  done. Default is TRUE.

- ...:

  Additional arguments passed to `ggsave()`.

## Value

Nothing. The function saves the ggplot to the specified path.
