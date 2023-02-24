% binary to decimal conversion
function outval=bin2dec_conv(datain,no_of_bit,no_of_data)


if(no_of_data==2)
    data1=datain(1:12);
    posvalin1=reshape(data1,[no_of_bit(1) length(data1)/no_of_bit(1)]).';
    valuein_pso1=bi2de(posvalin1,'left-msb');
    outval1=[valuein_pso1];
    data2=datain(13:end);
    posvalin1=reshape(data2,[no_of_bit(2) length(data2)/no_of_bit(2)]).';
    valuein_pso1=bi2de(posvalin1,'left-msb');
    outval2=[valuein_pso1];
    outval=[outval1;outval2];
    
elseif(no_of_data==3)
    data1=datain(1:18);
    posvalin1=reshape(data1,[no_of_bit(1) length(data1)/no_of_bit(1)]).';
    valuein_pso1=bi2de(posvalin1,'left-msb');
    outval1=[valuein_pso1];
    data2=datain(19:end);
    posvalin1=reshape(data2,[no_of_bit(2) length(data2)/no_of_bit(2)]).';
    valuein_pso1=bi2de(posvalin1,'left-msb');
    outval2=[valuein_pso1];
    outval=[outval1;outval2];
    
elseif(no_of_data==4)
    data1=datain(1:24);
    posvalin1=reshape(data1,[no_of_bit(1) length(data1)/no_of_bit(1)]).';
    valuein_pso1=bi2de(posvalin1,'left-msb');
    outval1=[valuein_pso1];
    data2=datain(25:end);
    posvalin1=reshape(data2,[no_of_bit(2) length(data2)/no_of_bit(2)]).';
    valuein_pso1=bi2de(posvalin1,'left-msb');
    outval2=[valuein_pso1];
    outval=[outval1;outval2];
elseif(no_of_data==1)
    data1=datain(1:no_of_bit(1));
    posvalin1=reshape(data1,[no_of_bit(1) length(data1)/no_of_bit(1)]).';
    valuein_pso1=bi2de(posvalin1,'left-msb');
    outval1=[valuein_pso1];
    data2=datain(no_of_bit(1)+1:end);
    posvalin1=reshape(data2,[no_of_bit(2) length(data2)/no_of_bit(2)]).';
    valuein_pso1=bi2de(posvalin1,'left-msb');
    outval2=[valuein_pso1];
    outval=[outval1;outval2];    
end
% 
