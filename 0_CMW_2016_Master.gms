$title COALMOD-World 1-Stage 2016 version, DIW Berlin

$ontext
+ TITLE +
COALMOD-World 1-Stage 2016 version, DIW Berlin

+ VERSION +
Version 1.0, November 2016.

+ AUTHORS +
Franziska Holz, Clemens Haftendorn, Roman Mendelevitch, Christian von Hirschhausen.

+ LICENSE +
This work is licensed under the MIT License (MIT).

Copyright (c) 2016 Franziska Holz, Clemens Haftendorn, Roman Mendelevitch, Christian von Hirschhausen (all DIW Berlin)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software
and associated documentation files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge, publish, distribute,
sublicense, and/or sell copies of the Software, and to permit persons to whom the Software
is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE
AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For more information on this license, visit
http://opensource.org/licenses/mit-license.php.


+ CITATION +

Whenever you use this code, please refer to http://www.diw.de/coalmod.

As well as to the model documentation:

Holz, F, C. Haftendorn, R. Mendelevitch, and C.v. Hirschhausen. (2016):
"A Model of the International Steam Coal Market(COALMOD-World)", DIW Data Documentation 85. DIW Berlin. Berln, Germany.

+ CONTACT +

We are happy to receive feedback under rmendelevitch@diw.de or fholz@diw.de



*******************************************************

+ REPRODUCTION OF RESULTS IN MODEL DOCUMENTATION +

To obtain results from the model documentation on the comparision between the WEO IEA NPS (stagnation scenario) and the 450ppm (2°C scenario) simply run the model once.

To do so:

1. Open the respective project directory  CMW_2016.gpr (make sure this become the working directory)
2. Open 0_CMW_2016_Master.gms
3. Follow the instruction in the Gams file
4. After you run the model, results can be found in Output\Figures_new.xlsx
5. All results are written as a batch into the Output_CMW_2016.xlsx file



Have fun!

$offtext

$eolcom #
$onempty

********************************************************************************
*************** How to use *****************************************************
********************************************************************************
*All scenario specifications should be made in the scenario file, only!!!!



********************************************************************************
*************** Settings to be set before model run ****************************
********************************************************************************


*include the name of the set file specifying the geographical coverage and the time horizon
$setglobal set_specs 1_CMW_2016_Sets


*include the name of the data input file excluding .xlsx
$setglobal input_data Input_data_NPS_2050

*Specify the purpose of the run. Choose between calibration, normal_use
$setglobal purpose calibration

********************************************************************************
*************** No modifications below this point!!!****************************
*************** Please go to Scenario file 4_CMW_2016_Scenario.gms *************
********************************************************************************


********************************************************************************
*************** Basic Model ****************************************************
********************************************************************************

*** Include Sets ***   choose the basic coverage in terms of regional and time coverage
$Include %set_specs%


*** Include basic Parameters - Load from Excel input file ***
$batinclude 2_CMW_2016_Parameters_Data.gms  %input_data%


*** Include basic Variables ***
$Include 3_CMW_2016_Variables.gms

*** Include Scenario ***
$Include Calibration/4_CMW_2016_Scenario_calibration.gms

*** Include basic Equations ***
$Include 5_CMW_2016_Equations.gms


*** execute basic Model ***
$batinclude Calibration/6_CMW_2016_MCP_calibration.gms  %purpose%



$iftheni.purpose %purpose% == normal_use
********************************************************************************
************** Scenario runs ***************************************************
********************************************************************************
$Include 4_CMW_2016_Scenario.gms
*** Include basic Equations ***




********************************************************************************
*************** Generate Output ************************************************
********************************************************************************
$include 7-2_CMW_2016_Generate_Excel_Output.gms

$endif.purpose




