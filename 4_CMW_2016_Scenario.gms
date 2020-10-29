********************************************************************************
*************** Scenario Assumptions *******************************************
********************************************************************************

*Scenario variation set
Set stepM /1*2/;


*useful parameter to store initial value and allow parameter variation
parameter
store1(*,*)
store2(*,*,*)
store3(*,*,*);


*start year of treatment shock
*tsyear=2020;

* fix all values before shock to prohibit anticipation
*fix(a)$(a.val<tsyear)=yes;



*** LOOP ***
$include 6_CMW_2016_MCP.gms
loop(stepM,
$Setglobal modrun stepM


* Variation of scenario parameter
if (stepM.val>1,

execute "gdxxrw.exe Input_Data/Input_data_450ppm_2050.xlsx UpdLinks =3 o=input_data.gdx  @Input_data.txt"
execute_load   "input_data.gdx"   p_ref, y_ref, epsi     ;


b(a,c)        =  (1/epsi(c,a))*(p_ref(c,a)/y_ref(c,a));
DemInter(a,c) =  p_ref(c,a)*(1-1/epsi(c,a));

);


solve COALMOD_World_MCP_scenario using mcp;



* Output with report collection *
$batinclude 7-1_CMW2s_2016_output_report.gms

);
