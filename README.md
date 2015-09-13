# Get Volume
Get Volume is an ImageJ macro that calculates the volume of calcification in CT images using DICOM info about pixel size and slice thickness. 

How to use:
- Install in ImageJ using Plugins > Macros > Install
- Open DICOM image using File > Import > Image sequence
- For each slice, select the area to measure calcification (can be a coarse selection like a circle or a square)
- Press the GV button and click on the image to count all pixels with HU > 130. The number of pixels found and the area is shown in the results table. Total volume is calculated using ALL measures in the results table and uptated at each slice. 

Click twice on the GV button and press OK to clear results or change the standard HU threshold of 130.
