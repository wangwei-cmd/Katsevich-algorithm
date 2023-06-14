function rf=backproject_helical(g1,DSD,h,DSO,phi_cor,alpha_cor,w_cor,delt_alpha,delt_theta,...
                                 alpha_star,v_star,w_star,index,Ltheta)
g1=compute_grad_s(g1,delt_alpha,delt_theta);
alpha_cor_shift=alpha_cor+0.5*(alpha_cor(2)-alpha_cor(1));
g1=rebin_cor(g1,DSD,h,DSO,phi_cor,alpha_cor_shift,w_cor);
g1=Htransform_matrix(g1,alpha_cor_shift);
[k_index,k_weight]=solve_k_line(gather(alpha_cor),gather(w_cor),gather(phi_cor),DSD,h,DSO);
% k_index=gpuArray(k_index);k_weight=gpuArray(k_weight);
g1=permute(g1,[2,3,1]);
g1=padarray(g1,[2,2,0],0,'post');
k_index_1=k_index;
k_index_1(k_index==0)=size(g1,2)-1;

g_5=zeros([length(alpha_cor),size(k_index_1,2),Ltheta],'single');
for i=1:size(k_index_1,1)
g_5(i,:,:)=g1(i,k_index_1(i,:),[1:Ltheta]).*(1-k_weight(i,:))+...
    g1(i,k_index_1(i,:)+1,[1:Ltheta]).*(k_weight(i,:));
end
g_5=permute(g_5,[3,1,2]);
g_5=cos(alpha_cor)'.*permute(g_5,[2,1,3]);
g_5=permute(g_5,[2,1,3]);
g1=0;%%clear g1
rf=backproj_cor(g_5,alpha_star,v_star,w_star,alpha_cor,w_cor,index);
