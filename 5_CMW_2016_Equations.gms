
Equations
         PKKT_x_Dom(a,f,c)       derivative of the producer problem with respect to inland sales
         PKKT_y_Exp(a,f,e)       derivative of the producer problem with respect to sales to the exporter
         PKKT_Pinv(a,f)          derivative of the producer problem with respect to investemts in production
         PKKT_Tinv_c(a,f,c)      derivative of the producer problem with respect to investments in domestic inland transport
         PKKT_Tinv_e(a,f,e)      derivative of the producer problem with respect to investments in export inland transport
         PKKT_Prod(a,f)          production capacity constraint of producer
         PKKT_Pmax(a,f)          restiction of maximal production capacity addition per year
         PKKT_Res(f)             reserve constraint of producer
         PKKT_Tcap_c(a,f,c)      transport constraint of producer f to consumption node c
         PKKT_Tcap_e(a,f,e)      transport constraint of producer f to exporter e
         intercept(a,f)          intercept endogenous variation equation dependent on production
         DS(a,sea)               inverse demand function for consumers with port
         DL(a,land)              inverse demand function for consumers only reachable by land
         EKKT_z(a,e,sea)         derivative of the exporters problem with repect to exported quantities to one importer
         EKKT_Einv(a,e)          derivative of the exporters problem with respect to investemts in export capacity
         EKKT_Exp(a,e)           export capacity constraint of exporter
         EKKT_Emax(a,e)          restriction of maximal export capacity addition pro (plength) year
         MCC(a,e)                market clearing condition between producers and exporter
         EKKT_China(a)           Chinese export restriction

;





***********PRODUCERS***********
PKKT_x_Dom(a,f,c)$(DomProd(f,c) AND NOT fix(a))..
                                 (1/(1 + r(f)))**(year(a)-2010) * (
                                 -p_c(a,c)
                                 -CournotPowerP(a,f,c)*b(a,c)*x(a,f,c)
                                 + kfs(f)* mc_int(a,f)
                                 + kfs(f)**2 *mc_slp_start(f)*( sum(cc$DomProd(f,cc),x(a,f,cc))+ sum(ee$ExProd(f,ee),y(a,f,ee)))
                                 + kfs(f)*trans_c(f,c) )
                                 + kfs(f)*alpha_p(a,f)
                                 + sum(aa$(ORD(aa) > ORD(a)), kfs(f)*alpha_p(aa,f)*mc_int_var(f))
                                 + plength*kfs(f)*alpha_res(f) - (plength/2*kfs(f)*alpha_res(f))$(ord(a)=1)
                                 - (plength/2*kfs(f)*alpha_res(f))$(ord(a)=card(a))
                                 + kfs(f)*alpha_tc(a,f,c)
                                 =g= 0;


PKKT_y_Exp(a,f,e)$(ExProd(f,e) AND NOT fix(a))..
                                 (1/(1 + r(f)))**(year(a)-2010) * (
                                 -p_e(a,e)
                                 + kfs(f)* mc_int(a,f)
                                 + kfs(f)**2 *mc_slp_start(f)*( sum(cc$DomProd(f,cc),x(a,f,cc)) + sum(ee$ExProd(f,ee),y(a,f,ee)))
                                 + kfs(f)*trans_e(f,e,a) )
                                 + kfs(f)*alpha_p(a,f)
                                 + sum(aa$(ORD(aa) > ORD(a)), kfs(f)*alpha_p(aa,f)*mc_int_var(f))
                                 + plength*kfs(f)*alpha_res(f) - (plength/2*kfs(f)*alpha_res(f))$(ord(a)=1)
                                 - (plength/2*kfs(f)*alpha_res(f))$(ord(a)=card(a))
                                 + kfs(f)*alpha_te(a,f,e)
                                 =g= 0 ;

PKKT_Pinv(a,f)$(NOT fix(a))..   (1/(1 + r(f)))**(year(a)-2010) * CPinv(f)/plength
                                 - sum(aa$(ORD(aa) > ORD(a)), alpha_p(aa,f))
                                 + alpha_Pinv(a,f) =g= 0 ;



PKKT_Tinv_c(a,f,c)$(DomProd(f,c) AND NOT fix(a))..
                                 (1/(1 + r(f)))**(year(a)-2010) * CTinv_c(f,c)/plength
                                 - sum(aa$(ORD(aa) > ORD(a)), alpha_tc(aa,f,c))
                                 =g= 0 ;



PKKT_Tinv_e(a,f,e)$(ExProd(f,e) AND NOT fix(a))..
                                 (1/(1 + r(f)))**(year(a)-2010) * CTinv_e(f,e)/plength
                                 - sum(aa$(ORD(aa) > ORD(a)), alpha_te(aa,f,e))
                                 =g= 0 ;


PKKT_Prod(a,f)$(NOT fix(a))..    PCap(f)
                                 + sum(aa$(ORD(aa) < ORD(a)), Pinv(aa,f))
                                 - sum(aa$(ORD(aa) < ORD(a)),
                                        ( sum(c$DomProd(f,c),kfs(f)*x(aa,f,c))+ sum(e$ExProd(f,e),kfs(f)*y(aa,f,e)) )
                                         * mc_int_var(f)
                                        )
                                 - (sum(c$DomProd(f,c),kfs(f)*x(a,f,c))
                                 + sum(e$ExProd(f,e),kfs(f)*y(a,f,e))) =g= 0 ;



PKKT_Pmax(a,f)$(NOT fix(a))..        Pmaxinv(f) - Pinv(a,f) =g= 0;


PKKT_Res(f)..                    res(f)
                                  - sum (a$(1 < ORD(a)),
                                 (  sum(c$DomProd(f,c),kfs(f)*x(a,f,c))
                                    + sum(e$ExProd(f,e),kfs(f)*y(a,f,e))
                                    + sum(c$DomProd(f,c),kfs(f)*x(a-1,f,c))
                                    + sum(e$ExProd(f,e),kfs(f)*y(a-1,f,e)))*plength/2 )
                                  =g= 0;


PKKT_Tcap_c(a,f,c)$(DomProd(f,c) AND NOT fix(a))..
                                 tcap_c(f,c)
                                 + sum(aa$(ORD(aa) < ORD(a)), Tinv_c(aa,f,c))
                                 - kfs(f)*x(a,f,c) =g= 0;


PKKT_Tcap_e(a,f,e)$(ExProd(f,e) AND NOT fix(a))..
                                 tcap_e(f,e)
                                 + sum(aa$(ORD(aa) < ORD(a)), Tinv_e(aa,f,e))
                                 - kfs(f)*y(a,f,e) =g= 0;


******ENDOGENOUS*COSTS******

intercept(a,f)$(NOT fix(a))..     mc_int(a,f) =e= mc_int_start(f,a)
                                  +  sum(aa$(ORD(aa) < ORD(a)),((  sum(c$DomProd(f,c),kfs(f)*x(aa,f,c))+ sum(e$ExProd(f,e),kfs(f)*y(aa,f,e)) )
                                  * mc_slp_start(f) * mc_int_var(f) ))  ;


***********DEMAND***********
DS(a,sea)$(NOT fix(a))..          p_c(a,sea) - ( DemInter(a,sea) + b(a,sea)*( sum(f$DomProd(f,sea),x(a,f,sea))
                                  +  sum(e,z(a,e,sea)) ) ) =e= 0 ;


DL(a,land)$(NOT fix(a))..         p_c(a,land) - ( DemInter(a,land) + b(a,land)*( sum(f$DomProd(f,land),x(a,f,land)))
                                  ) =e= 0;


***********EXPORTERS***********
EKKT_z(a,e,sea)$(NOT fix(a))..    (1/(1 + r_e(e)))**(year(a)-2010) * ( -p_c(a,sea) -CournotPowerE(a,e,sea)*b(a,sea)*z(a,e,sea)
                                  + p_e(a,e) + kes(e)* searate(a,e,sea) + kes(e)*fee_port(e) )
                                  + kes(e)*mu_e(a,e) + theta(e,sea)*pi_CHN(a)*kes(e)
                                  =g= 0;

EKKT_Einv(a,e)$(NOT fix(a))..    (1/(1 + r_e(e)))**(year(a)-2010) *
                                  CEinv(e)/plength
                                  - sum(aa$(ORD(aa) > ORD(a)), mu_e(aa,e))
                                  + mu_Einv(a,e)
                                  =g= 0 ;


EKKT_Exp(a,e)$(NOT fix(a))..      Ecap(e)
                                  + sum(aa$(ORD(aa) < ORD(a)), Einv(aa,e))
                                  - sum(sea,kes(e)*z(a,e,sea)) =g= 0  ;


EKKT_Emax(a,e)$(NOT fix(a))..     Emaxinv(e) - Einv(a,e) =g= 0;


***********ADDITIONAL EQUATIONS***********
MCC(a,e)$(NOT fix(a))..           sum(f$ExProd(f,e),y(a,f,e)) - sum(sea,z(a,e,sea)) =e= 0;


***********POLITICAL RESTRICTIONS***********
EKKT_China(a)$(NOT fix(a))..      China_lic(a) - sum(NoChina,kes('E_CHN')*z(a,'E_CHN',NoChina)) =g= 0;







