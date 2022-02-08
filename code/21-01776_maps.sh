#! /bin/bash

## This script will need to br run within the MAPS coda environment

/opt/MAPS/bin/Arima-MAPS_v2.0.sh   -C 0   -m /home/steveped/DRMCRL/ZR-75_H3K27ac_HiChIP_testrun/data/ZR75_H3K27ac.bed   -I /home/steveped/DRMCRL/ZR-75_H3K27ac_HiChIP_testrun/data/fastq/21-01776   -O /home/steveped/DRMCRL/ZR-75_H3K27ac_HiChIP_testrun/output    -o 'hg19'   -b  /refs/gencode/grch37/GRCh37.primary_assembly.genome.fa   -t 8   -f 0 > /home/steveped/DRMCRL/ZR-75_H3K27ac_HiChIP_testrun/output/21-01776.log
  
