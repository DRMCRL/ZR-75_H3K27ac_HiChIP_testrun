# Description of MAPS output

There are four output folders:

1. `arcplot_and_metaplot`
2. `feather_output`
3. `MACS2_peaks`
4. `MAPS_output`

In addition, there should be two files for each sample in this folder:

1. [sample]_Arima_QC_deep.txt
2. [sample]_Arima_QC_shallow.txt

These files are near-identical with the exception of one column.
In the *deep* file column 11 is entitled `loops` whilst in the *shallow* file, this column is entitled `Target Raw PE Reads`


## `arcplot_and_metaplot`

Three files are produced in this folder, and these are rewritten after every run

1. [sample].coverage_matrix.tab.gz
  + Contains ranges from the MACS2 bedfile as the backbone in the first 6 columns
  + The remaining 2000 columns represent the coverage for each MACS2 peak within 10kb of the centre, using 10bp bins
2. [sample].coverage.bigwig
  + The coverage for each file
3. [sample].heatmap.pdf
  + Heatmap presenting the data from the above coverage matrix

## `feather_output`

Despite the lack for formal documentation, it is understood that `feather` is the preprocessing step and detection of significant interactions for each MACS2 peak.
In this step AND and XOR interactions are fit separately using the model

log(µ~ij~) = β~0~ + β~1~.FL~ij~ + β~2~.GC~ij~ + β~3~.MS~ij~ + β~4~.IP~ij~

Under this model µ~ij~ is the mean of a zero-truncated Poisson model for the number of interactions between bins i and j.
Remaining covariates are:

- FL~ij~ = f~i*f~j~ (fragment length), although why this is estimated in a bin-pair specific manner is not clear
- GC = gc~i~*gc~j~ (GC content) across bins i & j
- MS = ms~i~*ms~j~ (Mappability Score) (not sure how this is calculated)
- IP (ChIP Enrichment level)

This is the model specified by *HPRep: Quantifying Reproducibility in HiChIP and
PLAC-Seq Datasets* and this differs from that specified by [MAPS: Model-based analysis of long-range chromatin interactions from PLAC-seq and HiChIP experiments](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1006982#sec028) as the genomic distance term is excluded.
**Reading the source code is avdvised to determine which model is being fit.**

### Subdirectories

Each **sample** will have it's own subdirectory with an entire run placed into it's own time-stamped folder.
The latest run is placed in the folder `[sample]_current` using a symlink to the most recent time-stamped output.
Inside these time-stamped folders are:

- `[sample].feather.qc` Stats from feather QC. Some appear to be consistent with the Arima_QC output, whilst other fields are less simple. This file contains FRiP stats
- `[sample].chr*.shrt.vip.bed` containing short-range (<1kb) valid interaction pairs including read identifiers
- `[sample].shrt.vip.sort.bed`: The ranges of all short-range VIPs sorted
- `[sample].chr*.long.intra.bedpe` Long range cis interactions including read identifiers by chromosome
- `[sample].long.intra.bedpe` Long range cis interactions including read identifiers *far all* chromosomes
- `[sample].long.intra.filtered.bedpe` Long range cis interactions after being considered as significant. No read identifiers
- another folder clearly marked as `tempfiles` containing bam and feather output during preprocessing


## MAPS_output

This simply contains all read pairs classified as AND and XOR, split by chromosome for model fitting