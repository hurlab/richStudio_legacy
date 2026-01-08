# richStudio: An Interactive Platform for Functional Enrichment Analysis and Clustering

**Authors:** Junguk Hur^1,*^, Sarah Hong^2^, Jane Kim^1^

^1^ Department of Biomedical Sciences, University of North Dakota School of Medicine and Health Sciences, Grand Forks, ND, USA

^2^ Department of Biomedical Informatics, Columbia University, New York, NY, USA

^*^ Corresponding author: hurlabshared@gmail.com

---

## Abstract

**Summary:** Functional enrichment analysis is a fundamental step in interpreting high-throughput genomics data. However, when analyzing multiple gene sets or experimental conditions, researchers often face challenges in comparing and synthesizing enrichment results across datasets. We present richStudio, an interactive R/Shiny application that enables integrative functional enrichment analysis and clustering of enrichment results. richStudio supports multiple clustering algorithms (Kappa-based, hierarchical, and DAVID-style), provides interactive visualizations, and allows researchers to save and share analysis sessions for reproducible research.

**Availability and Implementation:** richStudio is available as an R package from Bioconductor (https://bioconductor.org/packages/richStudio) and GitHub (https://github.com/hurlab/richStudio). The application runs on any platform supporting R (≥4.0.0) with a modern web browser.

**Contact:** hurlabshared@gmail.com

**Supplementary information:** Supplementary data are available at Bioinformatics online.

---

## 1. Introduction

Functional enrichment analysis has become an indispensable tool in genomics research, enabling researchers to identify biological pathways and processes overrepresented in gene sets derived from differential expression, GWAS, or other high-throughput experiments (Subramanian et al., 2005; Huang et al., 2009). While numerous tools exist for performing enrichment analysis on individual gene sets, researchers increasingly need to compare enrichment results across multiple experimental conditions, time points, or tissues.

Existing tools such as DAVID (Huang et al., 2009), Enrichr (Kuleshov et al., 2016), and clusterProfiler (Wu et al., 2021) provide excellent single-sample enrichment analysis capabilities. However, comparing and integrating results across multiple samples often requires substantial bioinformatics expertise and custom scripting. Furthermore, the resulting enrichment terms can number in the hundreds, making interpretation challenging without systematic clustering approaches.

To address these challenges, we developed richStudio, an interactive Shiny application that provides: (1) multi-sample enrichment analysis and comparison, (2) multiple clustering algorithms to group functionally related terms, (3) interactive visualizations including heatmaps and network plots, and (4) session save/load functionality for reproducible analysis.

---

## 2. Methods and Features

### 2.1 Architecture

richStudio is implemented as an R package with an embedded Shiny application, following Bioconductor package guidelines. The application uses a modular architecture with separate Shiny modules for enrichment analysis, clustering, visualization, and session management. The backend includes C++ code (via Rcpp) for computationally intensive operations such as Kappa similarity matrix calculations.

### 2.2 Enrichment Analysis

Users can upload differentially expressed gene (DEG) lists in standard formats (CSV, TSV, Excel) and perform enrichment analysis against Gene Ontology (GO), KEGG, and Reactome databases. The application leverages the richR package for enrichment calculations and bioAnno for biological annotations across multiple species.

### 2.3 Multi-Method Clustering

A key feature of richStudio is its support for multiple clustering algorithms to group functionally related enrichment terms:

**Kappa-based clustering (richR):** Uses Cohen's Kappa coefficient to measure gene overlap between terms, implementing the algorithm described by Huang et al. (2009). This method is suitable for identifying terms with shared gene membership.

**Hierarchical clustering:** Provides flexible hierarchical clustering with selectable distance metrics (Kappa, Jaccard) and linkage methods (single, complete, average, Ward). Users can fine-tune distance and linkage cutoffs interactively.

**DAVID-style clustering:** Implements the seed-based functional annotation clustering algorithm from DAVID, using multiple linkage thresholds to form robust clusters.

### 2.4 Interactive Visualizations

richStudio provides multiple visualization types:
- **Bar and dot plots:** Display enrichment significance with customizable parameters
- **Heatmaps:** Show enrichment patterns across multiple samples with clustering dendrograms
- **Network plots:** Visualize term relationships based on gene overlap
- **Cluster heatmaps:** Display representative terms per cluster with p-value summaries

All plots are interactive (via plotly) with zoom, pan, and export capabilities.

### 2.5 Session Management

Analysis sessions can be saved in RDS or JSON format and reloaded for continued analysis or sharing. Individual results can be exported as CSV, TSV, or Excel files, and complete sessions as ZIP archives.

---

## 3. Implementation and Usage

### 3.1 Installation

```r
# From Bioconductor
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("richStudio")

# Launch application
library(richStudio)
launch_richStudio()
```

### 3.2 Programmatic Interface

In addition to the interactive application, richStudio exports core functions for scripting:

```r
# Merge multiple enrichment results
merged <- merge_genesets(list(sample1 = enrich1, sample2 = enrich2))

# Perform clustering
result <- perform_clustering(merged, method = "hierarchical",
                            params = list(distance_cutoff = 0.5))
```

### 3.3 Workflow Example

A typical richStudio workflow involves:
1. Uploading DEG lists or pre-computed enrichment results
2. Running enrichment analysis (if starting from DEGs)
3. Selecting enrichment results for clustering
4. Choosing a clustering method and adjusting parameters
5. Visualizing clusters via heatmaps
6. Exporting results and saving the session

---

## 4. Conclusion

richStudio provides an accessible, interactive platform for integrative functional enrichment analysis. By supporting multiple clustering algorithms and interactive visualizations, it enables researchers to systematically compare and interpret enrichment results across experimental conditions. The session management features ensure reproducibility and facilitate collaboration.

---

## Acknowledgements

We thank Kai Guo for the richR package and the Bioconductor community for their valuable feedback.

## Funding

This work was supported by [funding information to be added].

## Conflict of Interest

None declared.

---

## References

Huang, D.W., Sherman, B.T. and Lempicki, R.A. (2009) Systematic and integrative analysis of large gene lists using DAVID bioinformatics resources. *Nature Protocols*, **4**, 44-57.

Kuleshov, M.V., et al. (2016) Enrichr: a comprehensive gene set enrichment analysis web server 2016 update. *Nucleic Acids Research*, **44**, W90-W97.

Subramanian, A., et al. (2005) Gene set enrichment analysis: a knowledge-based approach for interpreting genome-wide expression profiles. *Proceedings of the National Academy of Sciences*, **102**, 15545-15550.

Wu, T., et al. (2021) clusterProfiler 4.0: A universal enrichment tool for interpreting omics data. *The Innovation*, **2**, 100141.

---

## Figures

### Figure 1. richStudio Application Overview

**(A)** The main interface showing the enrichment analysis workflow with DEG upload (left), enrichment execution (center), and results table (right).

**(B)** Clustering panel with method selection, dynamic parameter controls, and cluster summary table.

**(C)** Visualization options including bar plots, dot plots, heatmaps, and network graphs for enrichment results.

**(D)** Cluster heatmap showing representative terms per cluster across multiple samples with hierarchical clustering.

### Figure 2. Multi-Method Clustering Comparison

**(A)** Workflow diagram showing how enrichment results from multiple samples are merged and clustered.

**(B)** Comparison of clustering results using Kappa-based (richR), hierarchical, and DAVID methods on the same dataset.

**(C)** Interactive cluster visualization with expandable term details and export options.

---

## Supplementary Information

### S1. Installation of Optional Dependencies

For full functionality, install the following packages from GitHub:

```r
# Install remotes if needed
install.packages("remotes")

# Install richR for enrichment analysis
remotes::install_github("guokai8/richR")

# Install bioAnno for annotations
remotes::install_github("guokai8/bioAnno")

# Install richCluster for additional clustering methods
remotes::install_github("hurlab/richCluster")
```

### S2. Supported File Formats

**Input:**
- DEG files: CSV, TSV, TXT (tab-delimited), Excel (.xls, .xlsx)
- Enrichment results: Same formats with columns: Term, GeneID, Pvalue, Padj

**Output:**
- Individual results: CSV, TSV, Excel
- Complete session: RDS, JSON
- All results: ZIP archive

### S3. System Requirements

- R version ≥ 4.0.0
- Modern web browser (Chrome, Firefox, Safari, Edge)
- Minimum 4GB RAM recommended
- Operating systems: Windows, macOS, Linux
