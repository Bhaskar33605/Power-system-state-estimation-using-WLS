function dataoutx2=limit_chk_process2(nbus,datain,upper_lmt,lower_lmt,...
                                        upper_lmt1,lower_lmt1,...
                                        data_pass_to_loadflow)



no_of_dg_place=data_pass_to_loadflow{12};
if(size(datain,2)>size(datain,1))
    datain=datain.';
end
if(no_of_dg_place==2)
datain1=datain(1:2);
datain2=datain(3:4);
end
if(no_of_dg_place==3)
datain1=datain(1:3);
datain2=datain(4:6);
end
if(no_of_dg_place==4)
datain1=datain(1:4);
datain2=datain(5:8);
end

if(no_of_dg_place==1)
datain1=datain(1);
datain2=datain(2);
end

upper_cond=datain1>upper_lmt;
lower_cond=datain1<lower_lmt;
        dataout1=(datain1.*(~(upper_cond+lower_cond)))+...
                            upper_lmt.*upper_cond+lower_lmt.*lower_cond;
                        
                        
upper_cond=datain2>upper_lmt1;
lower_cond=datain2<lower_lmt1;
        dataout2=(datain2.*(~(upper_cond+lower_cond)))+...
                            upper_lmt1.*upper_cond+lower_lmt1.*lower_cond;

                        
                        
                        


rangeval=lower_lmt:upper_lmt;                        
if(length(unique(dataout1))==length(dataout1))
               dataoutm1=dataout1;

else
        uniquedata=unique(dataout1);
        lenadd=length(dataout1)-length(uniquedata);
        memchk=(~ismember(rangeval,dataout1));
        newdata=rangeval(memchk).';
        dataoutm1=[uniquedata ;newdata(randperm(length(newdata),lenadd))];
end
dataoutm2=dataout2;
     


dataoutx2=[dataoutm1;dataoutm2];


