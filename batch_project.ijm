//Code by Michael Blanchard 4/9/2020
//email: michael_blanchard@hms.harvard.edu


//for input and output directories I just created a desktop input and output folder and typed their directories below
//place all .lif files into the input directory before start. For Mac change all back slashes to single forward slashes.
input = "C:\\Users\\Michael Blanchard\\Desktop\\input\\"
output = "C:\\Users\\Michael Blanchard\\Desktop\\output\\"

setBatchMode(true); 
//get list of all files in input directory
list = getFileList(input); 

//load in Bio-Formats macro Extension
run ("Bio-Formats Macro Extensions"); 

//loop over list of files
for (i = 0; i < list.length; i++)
        project(input, output, list[i]);

function project(input, output, filename) {
	//open the current series within .lif file
	Ext.setId(input + filename)
	//get the number of series in the .lif file
	Ext.getSeriesCount(seriesCount);
	//loop over all series in .lif file
	for(i = 0; i < seriesCount; i++){
		run("Bio-Formats Importer", "open=["+input + filename+"] color_mode=Colorized view=Hyperstack stack_order=XYCZT series_"+(i+1));
		run("Z Project...", "projection=[Max Intensity]");
		//set to current series
		Ext.setSeries(i);
		//extract series name 
		Ext.getSeriesName(seriesName); 
		saveAs("Tiff", output + seriesName);
	}
	close();
}
