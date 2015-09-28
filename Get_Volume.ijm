// Tool to measure calcification in CT images
// Manuel Schutze - September 2015
// manuels@ufmg.br

macro "Get Volume Tool - C00cT1b10GT8b10V" {

      print("\\Clear");
      print("Get Volume Tool");

      if(selectionType()!=-1) {
	
	//get info
	getPixelSize(unit, pixelWidth, pixelHeight);
	sliceThickness = getInfo('0018,0050'); //DICOM_TAG for Slice Thickness
	getSelectionBounds(x, y, width, height); //square containing selection
	getStatistics(area, mean, min, max);

	Overlay.remove;
	setColor("red");

	//variables for this slice
	pxls1 = 0;
	pxls2 = 0;
	pxls3 = 0;
	pxls4 = 0;

	//iterate through selectionBounds
	for(w=x; w<(x+width); w++) {
    	     for(h=y; h<(y+height); h++) {
	          if(Roi.contains(w, h)==1) { //pixel inside selection
			value = calibrate(getPixel(w,h));
	 		if((value>130) && (value<200)) {
				Overlay.drawRect(w, h, 1, 1);
				pxls1 = pxls1+1;
			}
			value = calibrate(getPixel(w,h));
			if((value>199) && (value<300)) {
				Overlay.drawRect(w, h, 1, 1);
				pxls2 = pxls2+1;
			}
			value = calibrate(getPixel(w,h));
			if(value>299 && value<400) {
				Overlay.drawRect(w, h, 1, 1);
				pxls3 = pxls3+1;
			}
			value = calibrate(getPixel(w,h));
			if(value>399) {
				Overlay.drawRect(w, h, 1, 1);
				pxls4 = pxls4+1;
			}
	          }
    	     }
	}

	//print new row in results table
	row=nResults;
	setResult("Slice", row, getInfo("slice.label"));
	setResult("Px DS1", row, pxls1);
	setResult("Px DS2", row, pxls2);
	setResult("Px DS3", row, pxls3);
	setResult("Px DS4", row, pxls4);
	setResult("Area", row, (pxls1+pxls2+pxls3+pxls4)*pixelWidth*pixelHeight);
	lesionscore = pxls1 + 2*pxls2 + 3*pxls3 + 4*pxls4;
	setResult("Lesion Score", row, lesionscore*pixelWidth*pixelHeight);

	//calculate volume based on results in table (cumulative)
	volume=0;
	totalls=0;
	for(r=0; r<nResults; r++) {
		volume+=getResult("Area",r)*sliceThickness;
		totalls+=getResult("Lesion Score",r)*sliceThickness;
	}

	//print cumulative volume on each run
	print("Total Volume: "+volume+"mm3");
	print("Total Lesion Score: "+totalls+"mm3");
	
	Overlay.show;

      } else { //no selection
	waitForUser("Please make a selection!");
     }

} //end macro

macro "Get Volume Tool Options" {
	waitForUser("Click OK to clear results")
	run("Clear Results");
	Overlay.remove;
	print("\\Clear");
	print("Get Volume Tool");
	print("Results cleared!");
}
