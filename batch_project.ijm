//Code by Michael Blanchard 4/9/2020
//email: michael_blanchard@hms.harvard.edu


//for input and output directories I just created a desktop input and output folder and typed their directories below
//place all .lif files into the input directory before start
input = "C:\\your\\input\\directory\\here\\"
output = "C:\\your\\output\\directory\\here\\"

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
		saveAs("Tiff", output + (i+1) + "_" + filename);
	}
	close();
}
