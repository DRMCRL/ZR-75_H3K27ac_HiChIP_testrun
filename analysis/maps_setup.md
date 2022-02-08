# Notes on setup

## Setup the Conda Environment

First create a conda environment with the correct dependencies.
These are contained in the file `maps.yaml`

```
mamba env create --name MAPS --file maps.yaml
conda activate MAPS
```

## Index the genome

Now we need to make sure the genome is indexed

```
bwa index /refs/gencode/grch37/GRCh37.primary_assembly.genome.fa
```

## Install MAPS

The MAPS workflow can be installed into `/opt`.
This is a bit of a lazy way to change permissions, but it gets the job done.

```
sudo chmod 777 /opt
cd /opt
git clone https://github.com/ijuric/MAPS.git
sudo chmod 775 /opt
```

Now change back to the working directory

```
cd [path_to_wd]
```

Currently the `fastq` files are in a folder called `fastq`

```
tree -L 1 fastq/
	fastq/
	├── 21-01774_R1.fastq.gz
	├── 21-01774_R2.fastq.gz
	├── 21-01775_R1.fastq.gz
	├── 21-01775_R2.fastq.gz
	├── 21-01776_R1.fastq.gz
	├── 21-01776_R2.fastq.gz
	├── 21-01777_R1.fastq.gz
	├── 21-01777_R2.fastq.gz
	├── fastq.md5
	├── Reports
	├── Stats
	├── Undetermined_R1.fastq.gz
	└── Undetermined_R2.fastq.gz
```

The output should be written to the folder caled `output`

```
mkdir output
```

## Run MAPS Using Pre-Defined Peaks

As instructed, the Arima modified script **needs to be copied** into the `bin` folder

```
cp /opt/MAPS/Arima_Genomics/Arima-MAPS_v2.0.sh /opt/MAPS/bin/
```

### 21-01774

```
/opt/MAPS/bin/Arima-MAPS_v2.0.sh   \
  -C 0 \
  -m "./ZR75_H3K27ac.bed" \
  -I fastq/21-01774 \
  -O output \
  -o "hg19" \
  -b /refs/gencode/grch37/GRCh37.primary_assembly.genome.fa \
  -t 8 \
  -f 0 
```


The tempfiles can be deleted, although these directory names are timestamped so will change on every run

```
rm -rf output/feather_output/21-01774_20220204_164412/tempfiles
```

### 21-01775

```
/opt/MAPS/bin/Arima-MAPS_v2.0.sh   \
  -C 0 \
  -m "./ZR75_H3K27ac.bed" \
  -I fastq/21-01775 \
  -O output \
  -o "hg19" \
  -b /refs/gencode/grch37/GRCh37.primary_assembly.genome.fa \
  -t 8 \
  -f 0 
```

```
rm -rf output/feather_output/21-01774_20220204_164412/tempfiles
```

### 21-01776

```
/opt/MAPS/bin/Arima-MAPS_v2.0.sh   \
  -C 0 \
  -m "./ZR75_H3K27ac.bed" \
  -I fastq/21-01776 \
  -O output \
  -o "hg19" \
  -b /refs/gencode/grch37/GRCh37.primary_assembly.genome.fa \
  -t 8 \
  -f 0 
```

### 21-01777

```
/opt/MAPS/bin/Arima-MAPS_v2.0.sh   \
  -C 0 \
  -m "./ZR75_H3K27ac.bed" \
  -I fastq/21-01777 \
  -O output \
  -o "hg19" \
  -b /refs/gencode/grch37/GRCh37.primary_assembly.genome.fa \
  -t 8 \
  -f 0 
```

```
conda deactivate 
```
