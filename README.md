# Laid line detection algorithme

This pipeline is developed to extract Laid Lines from manuscript images. The algorithm applies preprocessing to delete the text with the tool Magic Eraser. It uses a Total Variation Spectral Decomposition algorithme to remove unnecessary textures, leaving only laid lines with more clarity. In addition, the Radon Transform is used with a cross section and a vertical projection to locate the laid lines, detect how many lines are in the paper patch, and also how many lines are in 10 mm and 20 mm of real paper.

This work is based on the research work of "Hidden Knowledge: Mathematical Methods for the Extraction of the Fingerprint of Medieval Paper from Digital Images" by Tamara G. Grossmann, Carola-Bibiane Schönlieb and Orietta Da Rold.

Some changes were made in order to adapt it to the needs of the project and improve its functioning. You will find some images and matlab documents in the folder of this project to check the execution of the algorithm

@article{grossmann2023extracting, title={Extracting chain lines and laid lines from digital images of medieval paper using spectral total variation decomposition}, author={Grossmann, Tamara G and Sch{"o}nlieb, Carola-Bibiane and Da Rold, Orietta}, journal={Heritage Science}, volume={11}, number={1}, pages={180}, year={2023}, publisher={Springer} }

If you want to read more about the project and see some resultst you can check the link below.

## Document with results:

