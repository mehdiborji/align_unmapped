# align_unmapped
This repository demonstrates a simple method for quantification of unmapped reads (of viral, micorbial, tranfection vector origin) obtained 
from standard host-aligned high-throughput barcoded libraries such as 10x genomics based pipelines for single-cell (cellranger) or spatial 
(spaceranger) or Drop-seq based pipelines for single-cell (Drop-seq, Seq-well) or spatial  (slide-seq).

Standard single-cell or spatial RNA profiling platforms offer untilities for alignment to usually hard-coded pre-defined sets of 'host' references.
While reference modification is usually possible, it's not always easy to implement or in retrospective studies it might not be needed to redo 
host-alignment step. In case of interest in alignments to custuom targets such as viral and microbial transcripts, cell therapy constructs such as CART, or transfection protocols introducing GFP reporter into cells, this process can be simplified for purposes of initial technology development iterations or re-use of the outputs from the standard pipelines.

The first step in this process is to extract the 'unmapped' reads from the already host-aligned libraries, in form of BAM files. This is 'possorted_genome_bam' for 10X libraries. The results is a BAM file of unmapped reads which is then converted to fastq format. Script `matchbam2fq.sh` does this extraction.

Next step is to use the extracted reads in fastq format and aligned them to a new custom reference of viruses, bacteria, transfection vectors, etc.

Scripts `STAR_ref.sh` and `STAR_align.sh` make the custom reference and perform alignments using [STAR](https://github.com/alexdobin/STAR) aligner.

Scripts `align_one.sh` makes the custom reference and performs alignment using [minimap2](https://github.com/lh3/minimap2)  aligner.

STAR is recommended for short spliced rna-seq reads. In most cases minimap2 makes more sense for bacterial and viral reads.

Subsequently the aligned reads to this new reference are extracted using [pysam] (https://github.com/pysam-developers/pysam). One can perform some quality controls on the alignments at this step. For exmample alignments scores, mismatch rates and reference positions can help to remove some of the non-specific reads. One major problem for metagenomic references is abundance of low-complexity sequences or contaminantations in the assemblies. Such regions ususally will cause false positives in a clustered fashion where a small region of 100nt or less will have all have many reads mapped to them. One improvement of this pipeline is to indentify such clustered alignments of remove them.

Lastly `pysam` is used again to sweep accorss the intial unmapped BAM which contains the metadata for these reads (such as barcode and UMI). Now we can quantify the metagenomic reads at bead/cell and UMI level. With this information one can construct a new count matrix of aligned reads to the metagenomics transcriptome.
