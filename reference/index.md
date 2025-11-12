# Package index

## R objects

- [`study_data`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/study_data.md)
  : Study data retrieved from the OSF project
- [`models_list`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/models_list.md)
  : Models for all the variables predicted by Groups, Clusters and
  Sub-clusters

## Data manipulation

- [`filter_study_variables()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/filter_study_variables.md)
  :

  Filter the `Variable` column of a long format data frame

- [`format_association_table()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/format_association_table.md)
  : Display the association table for a specific variable in a clean
  format

- [`get_longer()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/get_longer.md)
  : Transform the main data frame to long format

- [`merge_clusters()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/merge_clusters.md)
  : Add the clustering and reduced variables to the main data frame

- [`scale_vars()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/scale_vars.md)
  : Scale original quantitative variables to a defined range

- [`scale_reduce_vars()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/scale_reduce_vars.md)
  : Reduce the number of variables to prepare for clustering

## Modelling

- [`cluster_selected_vars()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/cluster_selected_vars.md)
  : Use Gaussian Mixture Models to cluster selected variables
- [`fit_stan_glm()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/fit_stan_glm.md)
  : Fit a stan_glm model with predefined parameters
- [`get_association_models()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/get_association_models.md)
  : Fit and report Bayes Factors for associations with education, fields
  and occupations
- [`get_bf_inclusion()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/get_bf_inclusion.md)
  : Compute Bayes Factor for Inclusion for the groups and age covariate
- [`get_contrast_bf()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/get_contrast_bf.md)
  : Get contrasts between groups in a Bayesian model
- [`get_full_model_table()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/get_full_model_table.md)
  : Create a table summarising the models for each variable
- [`get_mean_sd()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/get_mean_sd.md)
  : Get the mean and standard deviation of a variable in a clean table
- [`correlate_vars()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/correlate_vars.md)
  : Correlate the original variables with a chosen method and correction

## Plotting

- [`add_significance_geoms()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/add_significance_geoms.md)
  : Add significance label and line to a plot
- [`plot_clusters_bic()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/plot_clusters_bic.md)
  : Plot the comparison of Gaussian Mixture Models (GMM) BIC scores
- [`plot_score_cor_graph()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/plot_score_cor_graph.md)
  : Plot a correlation graph
- [`plot_score_cor_joint()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/plot_score_cor_joint.md)
  : Create a joint matrix + graph correlation figure
- [`plot_score_cor_matrix()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/plot_score_cor_matrix.md)
  : Plot a correlation matrix
- [`plot_score_radars()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/plot_score_radars.md)
  : Plot scaled score variables as radar charts
- [`plot_score_violins()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/plot_score_violins.md)
  : Plot the study variables' distributions as half-violins with point
  averages and error bars.
- [`save_ggplot()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/save_ggplot.md)
  : Custom ggsave wrapper set with Nature's formatting guidelines
  (width-locked)
