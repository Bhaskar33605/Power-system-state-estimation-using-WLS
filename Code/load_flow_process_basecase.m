function [finalres]=load_flow_process_basecase(nbus,data_pass_to_loadflow)source_num=[1];[LINEDATA]=linedata_radial_bus(nbus);BUSDATA=busdata_radial_bus(nbus);baseKV=12.66;baseMVA=100;PBASE=baseMVA*1000;VBASE=(baseKV^2)/baseMVA;busdata_value=BUSDATA;linedata_value=LINEDATA;linedata_value(:,4:5)=linedata_value(:,4:5)/VBASE;resistance_val=linedata_value(:,4);reactance_val=linedata_value(:,5);actual_imped=complex(resistance_val,reactance_val); busdata_value(:,2:3)=(busdata_value(:,2:3)/PBASE);imped_value=actual_imped;[bibc_matrix]=bibc_gen(linedata_value,busdata_value);bibc_matrix(source_num,:)=[];bibc_matrix(:,source_num)=[];final_bibc_matrix=bibc_matrix';final_bcbv_matrix=final_bibc_matrix'*diag(actual_imped); final_dlf_matrix=final_bcbv_matrix*final_bibc_matrix;complex_load_d=complex(busdata_value(:,2),busdata_value(:,3));% complex power loadcomplex_load_g=zeros(size(busdata_value,1),1);final_load_matrix=(complex_load_d-complex_load_g);final_load_matrix(length(source_num))=[];initial_volt_value=ones(size(busdata_value,1)-length(source_num),1);% initial bus voltagevoltage_drop_value=initial_volt_value;max_iter=100; for ind_lop=1:max_iter    %backward sweep    inject_current_data=conj(final_load_matrix./voltage_drop_value); % injected current at each bus    IB=final_bibc_matrix*inject_current_data; %get the cumulative injected current flowing through each branch    old_volt=voltage_drop_value;    volt_drop_each=final_dlf_matrix*inject_current_data; %voltage drops along each branch.    voltage_drop_value=initial_volt_value-volt_drop_each;    old_volt1=(old_volt);    new_volt=(voltage_drop_value);    error_volt_tolr=max(abs(old_volt1-new_volt));endfinal_volt_data=[ones(length(source_num),1);voltage_drop_value];locvoltm=find(final_volt_data>1);final_volt_data(locvoltm)=1;from_node=linedata_value(:,2);to_node=linedata_value(:,3);for ind=1:length(from_node)    volt_diff_value(ind,:)=final_volt_data(from_node(ind))-final_volt_data(to_node(ind));endvolt_diff_value1=abs(volt_diff_value);ploss=((volt_diff_value1.^2).*resistance_val)./(abs(imped_value).*abs(imped_value))*10^5; % Each Line Loss in kWsloc1=find(~(isnan(ploss)));qloss=((volt_diff_value1.^2).*reactance_val)./(abs(imped_value).*abs(imped_value))*10^5; % Each Line Loss in kVArloc2=find(~(isnan(qloss)));total_power_lossp=sum(ploss(loc1));total_power_lossq=sum(qloss(loc2));finalvoltage=real(final_volt_data);finalres{1}=total_power_lossp;finalres{2}=total_power_lossp;finalres{3}=total_power_lossq;finalres{4}=finalvoltage;finalres{5}=ploss;