# How to use ?
## Preprocessing

Before running the shape4D code, we need to generate a xml file that will contain all the information needed for the computation.
1. (optional) Most of the shapes has a very high number of vertices and not very normalized triangles. We first need to use a tool to decimate the number of vertices and normalized the triangles. [MeshLab](http://www.meshlab.net/#download) is a good software to do so but it doesn't accept VTK files. If you have VTK files, open them in [3D Slicer](http://download.slicer.org/) and immediately save them as STL. Then open MeshLab, load one of your shape, go to `Filters` -> `Remeshing, Simplification and Reconstruction` -> `Simplification: Quadric Edge Collapse Decimation`. A pop-up window should appear. Change the number of faces between 10k and 30k, depending on the overall size of your shape, then select `Preserve Normal` and `Preserve Topology`, finally click on Apply. You can now save the model, close the scene and repeat the operation for all your timepoints.
2. (optional) Convert input files to ASCII vtk files. You can load your stl/vtk files in [Paraview](https://www.paraview.org/download/) and save them as VTK and then ASCII.
3. Create/Update a csv file with in the first column the basename of all the different time points and in the second column the age corresponding to the file.

**** | **A** | **B**
--- | --- | ---
**1** | TimePoint1.vtk | *10*
**2** | TimePoint2.vtk | *20*
**3** | TimePoint3.vtk | *27*
**4** | TimePoint4.vtk | *45*

4. Update the perl script given as example to include paths to your files. The perl script will generate an xml file which will contain information relative to the computation.

       line4: folder containing the vtk files
       line5: folder where the outputs will be generated
       line8: path to the csv file
       line12: output xml file
       line14: path to the first time point
       line16: path to the last time point
       line18: first time point age
       line19: last time point age
       line20: number of time points
       line22: give a name to your project
       
5. Run perl script with the command `perl process_data.pl`. The console would show the each time point age if it worked fine and the xml would be generated at the location you entered in the script.

## Build Shape4D
1. (optional) Install CMake with `sudo apt-get install cmake` or with the [online installer](https://cmake.org/files/v3.8/cmake-3.8.2-Linux-x86_64.sh).
2. Create a folder `mkdir shape4D-build` and move to this folder `cd shape4D-build`.
3. Use CMake to configure the project `cmake /path/to/shape4D`.
4. Build the project `make`.

## Run
1. First check if the filepath you entered still matches with the files.
2. Go to the directory you built shape4D in and use the command `./shape4D timepoints.xml` adapting the name you gave to the xml produced by the perl script.
3. Wait for the results.

## Display the results
1. Go to the output folder to check the integrity of the results. There should be some files named `projectname_final_time_XXX.vtk`. The default parameter of the script will create 60 frames so you should have listed from 000 to 059. Those files are created as a group of file, some software can load them as one shape.
2. Open [Paraview](https://www.paraview.org/download/), click on Open and browse to your Output folder. You should find a group of file with `final_time` in the name. Load it and then click on Apply.
3. On the left panel, there should be a tab Coloring in which you can select `velocity` instead of `Solid Color` and select an axis or the Magnitude.
4. Below the `velocity` box you can find a button to edit the colormap. If you click on it you can see a tab on the right with your current colormap. You can add more colors by clicking on the specter and rescale the data range to fit your needs. I would recommend to load a preset by clicking on the folder with a small heart in the Mapping Data tab and select `Blue to Red Rainbow` for example. You can also change the legend properties on the top right button of the Color Map Editor (a colormap with a `e` on it). I used to change only Range Label to `%.4f`.
5. You can also add an annotation time by clicking on Filters -> Annotation -> Annotate Time Filter. A new panel would appear on bottom left part of the software. You can change the format to be `Years: %.0f`. The `%.0f` will get the current time frame and display it, 0 is for the number of floating number you want. The display will be by default from 0 to 60 but if we take the input example we want it from 10 to 45. First of all we need to calculate the scale which is (45-10)/59 = 0.593220389 and input this number as a scale. Then add a shift which corresponds to the difference between 0 and your time point (10). Click on Apply and you would see the time evolution based on your study. 
