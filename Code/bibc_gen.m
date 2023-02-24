function [bibc_matrix]=bibc_gen(linedata,busdata)
num_of_lines=length(linedata(:,2));
num_of_bus=length(busdata(:,1));
from_node=linedata(:,2);
to_node=linedata(:,3);
connect_matrix_lf=sparse(1:num_of_lines, from_node, ones(num_of_lines, 1), num_of_lines, num_of_bus);
connect_matrix_lt=sparse(1:num_of_lines, to_node, ones(num_of_lines, 1), num_of_lines, num_of_bus) ;
connect_matrix_lt_lf=connect_matrix_lf+connect_matrix_lt;
connect_matrix_lt_lf1=connect_matrix_lt_lf'*connect_matrix_lt_lf;
connect_diag_mat=ones(num_of_bus)-eye(num_of_bus);
connect_diag_mat1=connect_matrix_lt_lf1.*connect_diag_mat;
final_connect_mat=triu(connect_diag_mat1);
zero_matrix=zeros(num_of_bus);
zero_matrix1=zero_matrix(:,1);
for ind=1:num_of_bus
    node_order_val(:,ind)=sort([zero_matrix1(1:(num_of_bus-...
        length(graphtraverse(final_connect_mat,ind))));...
        graphtraverse(final_connect_mat,ind)']);
end
node_order_final=node_order_val;
for indr=1:length(node_order_final(1,:))
    for indc=1:length(node_order_final(1,:))
        order_node=node_order_final(indr,indc);
        if (order_node>0)
            bibc_matrix(order_node,indc)=1;
            bibc_matrix_ord(order_node,indc)=order_node;
            
            if order_node==0
                bibc_matrix(indr,indc)=0;
                bibc_matrix_ord(indr,indc)=0;
            end
        end
    end
end
bibc_matrix_ord=bibc_matrix_ord; 

