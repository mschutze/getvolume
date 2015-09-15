// Tool to measure calcification in CT images
// Manuel Schutze - September 2015

// How to use:
// 1. Install in ImageJ using Plugins > Macros > Install
// 2. Open DICOM image using File > Import > Image sequence
// 3. For each slice, select the area to measure calcification (can be
// a coarse selection like a circle or a square)
// 4. Press the GV button and click on the image to count all pixels 
// with HU > 130. The number of pixels found and the area is shown in the
// results table. Total volume is calculated using ALL measures in
// the results table and uptated at each slice. 
// Click twice on the GV button and press OK to clear results.

var huThreshold = 130;

macro "Get Volume Tool - C00cT1b10GT8b10V" {
	print("\\Clear");
	print("Get Volume Tool");
	//get pixel width and height and slice thickness
	getPixelSize(unit, pixelWidth, pixelHeight);
	sliceThickness = getInfo('0018,0050'); //DICOM_TAG for Slice Thickness
	//get info for current selection
	getStatistics(area, mean, min, max)
	if(max>huThreshold) {
		//get pixels higher than huThreshold
		getHistogram(values,counts,max-huThreshold,huThreshold,max);
		//count pixels
		pixels=0;
		for(i=0; i<lengthOf(counts); i++) {
			pixels+=counts[i];
		}
		//print new row in results table
		row=nResults;
		setResult("Slice", row, getInfo("slice.label"));
		setResult("Pixels", row, pixels);
		setResult("Area", row, pixels*pixelWidth*pixelHeight);
		//calculate volume based on results in table (cumulative)
		volume=0;
		for(r=0; r<nResults; r++) {
			volume+=getResult("Area",r)*sliceThickness;
		}
		//print cumulative volume on each run
		print("Total volume: "+volume+"mm3");
		print("Pixels selected: "+pixels);
	} else {
		//calculate volume based on results in table (cumulative)
		volume=0;
		for(r=0; r<nResults; r++) {
			volume+=getResult("Area",r)*sliceThickness;
		}
		print("Total volume: "+volume+"mm3");
		print("No pixels selected!");
	} 
}

macro "Get Volume Tool Options" {
	huThreshold = getNumber("HU Threshold:",huThreshold);
	run("Clear Results");
	print("\\Clear");
	print("Results cleared!");
}
