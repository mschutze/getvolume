# Get Volume
Get Volume is an ImageJ macro that calculates the volume of calcification in CT images (according to Agatston, 1990) using DICOM info about pixel size and slice thickness. 

How to use:
- Download the Get_volume.ijm file to your computer
- Install in ImageJ using Plugins > Macros > Install
- Open a DICOM CT image using File > Import > Image sequence
- For each slice, select the area to measure calcification (can be a coarse selection like a circle or a fine delimited area)
- Press the GV button and click anywhere on the image to count all pixels with HU > 130 inside the selection (these pixels are colored in red). The pixel count for each density score is shown in the results table (PxDS1-PxDS4). The area for the selected pixels is calculated multiplying the number of pixels by the pixel's width and height (obtained from DICOM info). Total lesion score for each slice is calculated pixelwise by multiplying each pixel's area by a density score of 1-4 according to the pixel's density (130-199HU=1, 200-299HU=2, 300-399HU=3, >399HU=4). Total volume / total lesion score is calculated using ALL measures in the results table together with the slice thickness.
- The measurements for each slice in the results table can be individually deleted by selecting the line > right click > clear (in case of measuring a slice twice or making a wrong selection). Important: if you delete lines in the results table, total volume and lesion score are only updated when the next measurement is made!

Click twice or right click on the GV toolbox button and press OK to clear all results and start over.
