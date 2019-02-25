#!/usr/bin/env nextflow

params.file_dir = 'data/p2_abstracts/*.txt'
params.out_dir = 'data/'
params.out_file='Summary.csv'

file_channel = Channel.fromPath( params.file_dir )

process 1 {
	container 'rocker/tidyverse'
		

	input:
	file f from file_channel

	output:
	file '*.csv' into out_csvs

	"""
	Rscript $baseDir/bin/output_csv.R $f
	"""
}

process 2 {
	container 'rocker/tidyverse'
	publishDir params.out_dir, mode: 'copy'

	input:
	file i from out_csvs.collectFile(name: 'counts.csv', newLine: true)

	output:
	file params.out_file into params.out_dir

	"""
	Rscript $baseDir/bin/Combine_csv.R $i
	"""

}