#!/usr/bin/perl

#Local workstation
$basepath = "/home/mirclem/Desktop/shape4D/example/inputVTKs/";
$outpath = "/home/mirclem/Desktop/shape4D/example/output/";

#Internal processing file
$file_list = "/home/mirclem/Desktop/shape4D/example/timepoints.csv";

#Outfile
#Local workstation
$outfile = "/home/mirclem/Desktop/shape4D/example/timepoints.xml";

$initial_file = "/home/mirclem/Desktop/shape4D/example/inputVTKs/TimePoint1.vtk";

$target_file = "/home/mirclem/Desktop/shape4D/example/inputVTKs/TimePoint4.vtk";

$t0 = 10;
$tn = 45;
$numberoftp = 4;

$projectname = "Shape4D-Example";

open(OUTFILE, ">$outfile");
print OUTFILE "<?xml version=\"1.0\">\n";
print OUTFILE "<experiment name=\"$projectname\">\n";
print OUTFILE " <algorithm name=\"RegressionVelocity\">\n";
print OUTFILE "     <source>\n";
print OUTFILE "         <input>\n";
print OUTFILE "             <shape> $initial_file </shape>\n";
print OUTFILE "         </input>\n";
print OUTFILE "         <sigmaV> 30.0 </sigmaV>\n";
print OUTFILE "         <gammaR> 0.01 </gammaR>\n";
print OUTFILE "         <t0> $t0 </t0>\n";
print OUTFILE "         <tn> $tn </tn>\n";
print OUTFILE "         <T> 60 </T>\n";
print OUTFILE "         <kernelType>   p3m   </kernelType>\n";
print OUTFILE "         <estimateBaseline>   0   </estimateBaseline>\n";
print OUTFILE "         <useFista>   1   </useFista>\n";
print OUTFILE "         <maxIters> 50 </maxIters>\n";
print OUTFILE "         <breakRatio> 1e-6 </breakRatio>\n";
print OUTFILE "     </source>\n";
print OUTFILE "     <targets>\n";
print OUTFILE "         <target>\n";
print OUTFILE "             <shape> $target_file </shape>\n";
print OUTFILE "             <type> SURFACE </type>\n";
print OUTFILE "             <tris> 0 </tris>\n";
print OUTFILE "             <sigmaW> 30.0 </sigmaW>\n";
print OUTFILE "             <timept> $tn </timept>\n";
print OUTFILE "             <weight> 1.0 </weight>\n";
print OUTFILE "         </target>\n";
print OUTFILE "     </targets>\n";
print OUTFILE " </algorithm>\n";

print OUTFILE "	<algorithm name=\"RegressionAccel\">\n";
print OUTFILE "	    <source>\n";
print OUTFILE "	        <input>\n";
print OUTFILE "		       <shape> $initial_file  </shape>\n";
print OUTFILE "         </input>\n";
print OUTFILE "         <sigmaV> 10.0 </sigmaV>\n";
print OUTFILE "         <gammaR> 0.01 </gammaR>\n";
print OUTFILE "	        <t0> $t0 </t0>\n"; 
print OUTFILE "	        <tn> $tn </tn>\n";
print OUTFILE "	        <T> 60 </T>\n";
print OUTFILE "	        <useInitV0> 1 </useInitV0>\n";
print OUTFILE "         <useFista>   0   </useFista>\n";
print OUTFILE "         <v0weight> 1.0 </v0weight>\n";
print OUTFILE "         <kernelType> p3m </kernelType>\n";
print OUTFILE "         <estimateBaseline> 0 </estimateBaseline>\n";
print OUTFILE "         <breakRatio> 1e-8 </breakRatio>\n";
print OUTFILE "         <maxIters> 5500 </maxIters>\n";
print OUTFILE "	        <output>\n";
print OUTFILE "		       <saveProgress> 200 </saveProgress>\n";
print OUTFILE "		       <dir> $outpath </dir>\n";
print OUTFILE "		       <prefix> $projectname </prefix>\n";
print OUTFILE "		   </output>\n";
print OUTFILE "		</source>\n";
print OUTFILE "	<targets>\n";

#READ header first, do not need processing
open(FILE, "$file_list");   
$in_line = <FILE>; #Header doesnt need to be processed

$count_masks = $count_masks + 1;

#READ line by line from FILE which is the filehandle for the input file .txt
while($in_line = <FILE>)
{          
   
    @line = split ( /,/, $in_line );
    $weight = $numberoftp - $count_masks;

    $filename=$basepath.$line[0];
    print "$filename\n";
    if ( -e $filename )
    {
            print OUTFILE " <target>\n";
            print OUTFILE "     <shape> $filename  </shape>\n";
            print OUTFILE "     <type> SURFACE </type>\n";
            print OUTFILE "     <tris> 0 </tris>\n";
            print OUTFILE "     <sigmaW> 4.0 </sigmaW>\n";
            print OUTFILE "     <timept> $line[1] </timept>\n";
            print "This is a $line[1] years old sample.\n";
            print OUTFILE "     <weight> 1.0 </weight>\n";
            print OUTFILE " </target>\n";
            $count_masks = $count_masks + 1;
     }

}

print OUTFILE "	</targets>\n";
print OUTFILE "	</algorithm>\n";
print OUTFILE "</experiment>\n";


close(FILE);
close (OUTFILE);

print "Processing Done. Number of masks $count_masks\n";


