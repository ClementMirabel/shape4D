# How to use ?
## Preprocessing

Before running the shape4D code, we need to generate a xml file that will contain all the information needed for the computation.

1. Create/Update a csv file with in the first column the basename of all the different time points and in the second column the age corresponding to the file.

**** | **A** | **B**
--- | --- | ---
**1** | TimePoint1.vtk | *10*
**2** | TimePoint2.vtk | *20*
**3** | TimePoint3.vtk | *27*
**4** | TimePoint4.vtk | *45*

2. Update the perl script given as example to include paths to your files. The perl script will generate an xml file which will contain information relative to the computation.

       line4: folder containing the vtk files
       line5: folder where the outputs will be generated
       line8: path to the csv file
       line12: output xml file
       line14: path to the first time point
       line16: path to the last time point
       line18: first time point age
       line19: last time point age
       line20: number of time points
       
3. Run perl script with the command `perl process_data.pl`. The console would show the each time point age if it worked fine and the xml would be generated at the location you entered in the script.

## Build Shape4D
1. (optional) Install CMake with `sudo apt-get install cmake` or with the [online installer](https://cmake.org/files/v3.8/cmake-3.8.2-Linux-x86_64.sh).
2. Create a folder `mkdir shape4D-build` and move to this folder `cd shape4D-build`.
3. Use CMake to configure the project `cmake /path/to/shape4D`.
4. Build the project `make`.

## Run
1. First check if the filepath you entered still matches with the files.
2. Go to the directory you built shape4D in and use the command `./shape4D timepoints.xml` adapting the name you gave to the xml produced by the perl script.
3. Wait for the results.
