# align_unmapped
This repository demonstrates a simple method for quantification of unmapped reads (of viral, micorbial, tranfection vector origin) obtained 
from standard host-aligned high-throughput barcoded libraries such as 10x genomics based pipelines for single-cell (cellranger) or spatial 
(spaceranger) or Drop-seq based pipelines for single-cell (Drop-seq, Seq-well) or spatial  (slide-seq).

Standard single-cell or spatial RNA profiling platforms offer untilities for alignment to usually hard-coded pre-defined sets of 'host' references.
While reference modification is usually possible, it's not always easy to implement or in retrospective studies it might not be needed to redo 
host-alignment step. In case of interest in alignments to custuom targets such as viral and microbial transcripts, cell therapy constructs such as CART, or transfection protocols introducing GFP reporter into cells, this process can be simplified for purposes of initial technology development iterations or re-use of the outputs from the standard pipelines.

The first step in this process is to extract the 'unmapped' reads from  already host-aligned libraries, in form of BAM files. The results is first a BAM 
file of unmapped reads which is then converted to fastq format. Extracted reads in fastq format are then subsequently aligned to the new custom 
reference of virus, transfection vectors, etc. Subsequently the aligned reads to this new reference are extracted and by sweeping accorss the intial 
unmapped BAM the metadata for these reads such barcode and UMI are saved. With information one can construct a new count matrix of aligned reads to the 
