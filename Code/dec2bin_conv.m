function data_out=dec2bin_conv(data_inm,no_of_bit,nodat)



if(nodat==1)
    
    data_in=data_inm(1);
    data_out1=de2bi(data_in.',no_of_bit(1),'left-msb').';
    
    data_in=data_inm(2:end);
    data_out2=de2bi(data_in.',no_of_bit(2),'left-msb').';
   data_out=[data_out1(:) ;data_out2(:)] ;
   
elseif(nodat==2)
    
    data_in=data_inm(1:2);
    data_out1=de2bi(data_in.',no_of_bit(1),'left-msb').';
    
    data_in=data_inm(3:end);
    data_out2=de2bi(data_in.',no_of_bit(2),'left-msb').';
   data_out=[data_out1(:) ;data_out2(:)] ;
   
elseif(nodat==3)
    
    data_in=data_inm(1:3);
    data_out1=de2bi(data_in.',no_of_bit(1),'left-msb').';
    
    data_in=data_inm(4:end);
    data_out2=de2bi(data_in.',no_of_bit(2),'left-msb').';
   data_out=[data_out1(:) ;data_out2(:)] ;
  
elseif(nodat==4)
    
    data_in=data_inm(1:4);
    data_out1=de2bi(data_in.',no_of_bit(1),'left-msb').';
    
    data_in=data_inm(5:end);
    data_out2=de2bi(data_in.',no_of_bit(2),'left-msb').';
   data_out=[data_out1(:) ;data_out2(:)] ;

   
end
     
