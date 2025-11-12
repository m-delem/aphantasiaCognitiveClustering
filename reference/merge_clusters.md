# Add the clustering and reduced variables to the main data frame

Add the clustering and reduced variables to the main data frame

## Usage

``` r
merge_clusters(df_raw, df_red, clustering, names = c("B", "C", "A"))
```

## Arguments

- df_raw:

  A data frame containing the raw data, usually `study_data`.

- df_red:

  A data frame containing the reduced variables, usually from
  [`scale_reduce_vars()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/scale_reduce_vars.md).

- clustering:

  A fitted Mclust object containing the clustering results, usually from
  [`cluster_selected_vars()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/cluster_selected_vars.md).

- names:

  A character vector of cluster names. Default is `c("B", "C", "A")`.
  The default is based on the last iteration of the clustering to date
  (which the article is based on).

## Value

A data frame with the columns from the raw data, the reduced variables,
a cluster column with the cluster names and a subcluster column with the
cluster and group names.

## Examples

``` r
df_merged <- merge_clusters(
  df_raw     = study_data,
  df_red     = scale_reduce_vars(study_data),
  clustering = cluster_selected_vars(study_data)
)
head(df_merged)
#> # A tibble: 6 × 37
#>   id    group      cluster     subcluster   age sex   education field field_code
#>   <chr> <fct>      <fct>       <fct>      <dbl> <fct> <fct>     <fct> <fct>     
#> 1 7210  Control    C (Control) C (Contro…    25 m     Master    Soci… 3         
#> 2 7213  Control    C (Control) C (Contro…    22 f     Master    Soci… 3         
#> 3 7238  Control    B (Mixed)   B-Control     52 f     Bachelor  Natu… 5         
#> 4 7242  Control    C (Control) C (Contro…    48 f     Post-sec… Busi… 4         
#> 5 7254  Aphantasic A (Aphant.) A (Aphant…    37 f     Doctorate Heal… 9         
#> 6 7257  Control    B (Mixed)   B-Control     36 m     Bachelor  Natu… 5         
#> # ℹ 28 more variables: occupation <fct>, occupation_code <fct>, vviq <dbl>,
#> #   osivq_o <dbl>, osivq_s <dbl>, osivq_v <dbl>, psiq_vis <dbl>,
#> #   psiq_aud <dbl>, psiq_od <dbl>, psiq_gout <dbl>, psiq_tou <dbl>,
#> #   psiq_sens <dbl>, psiq_feel <dbl>, score_raven <dbl>, score_sri <dbl>,
#> #   span_spatial <dbl>, span_digit <dbl>, wcst_accuracy <dbl>,
#> #   score_similarities <dbl>, score_comprehension <dbl>, visual_imagery <dbl>,
#> #   auditory_imagery <dbl>, sensory_imagery <dbl>, spatial_imagery <dbl>, …
colnames(df_merged)
#>  [1] "id"                  "group"               "cluster"            
#>  [4] "subcluster"          "age"                 "sex"                
#>  [7] "education"           "field"               "field_code"         
#> [10] "occupation"          "occupation_code"     "vviq"               
#> [13] "osivq_o"             "osivq_s"             "osivq_v"            
#> [16] "psiq_vis"            "psiq_aud"            "psiq_od"            
#> [19] "psiq_gout"           "psiq_tou"            "psiq_sens"          
#> [22] "psiq_feel"           "score_raven"         "score_sri"          
#> [25] "span_spatial"        "span_digit"          "wcst_accuracy"      
#> [28] "score_similarities"  "score_comprehension" "visual_imagery"     
#> [31] "auditory_imagery"    "sensory_imagery"     "spatial_imagery"    
#> [34] "verbal_strategies"   "fluid_intelligence"  "verbal_reasoning"   
#> [37] "spatial_span"       
df_merged |>
  dplyr::reframe(
    .by = cluster,
    n = dplyr::n(),
    vviq    = mean(vviq),
    object  = mean(osivq_o),
    spatial = mean(osivq_s),
    verbal  = mean(osivq_v)
   ) |>
   dplyr::arrange(cluster) |>
   print()
#> # A tibble: 3 × 6
#>   cluster         n  vviq object spatial verbal
#>   <fct>       <int> <dbl>  <dbl>   <dbl>  <dbl>
#> 1 A (Aphant.)    32  18.1   23.9    37.6   52.8
#> 2 B (Mixed)      30  36.5   39.1    47.5   41.4
#> 3 C (Control)    34  62.2   56.7    40.0   44  
```
