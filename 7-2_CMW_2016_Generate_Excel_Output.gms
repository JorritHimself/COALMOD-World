***** Output Generation *****
execute_unload "Report.gdx"  timestamp, report, flow;
execute 'gdxxrw.exe i=Report.gdx UpdLinks =3 o=Output/Output_CMW_2016.xlsx @export_xls.txt';
