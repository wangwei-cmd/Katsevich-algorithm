function img=backproj_cor(g_c,alpha_star,v_star,w_star,cor_alpha,cor_w,index)
[ntheta,nx,ny,nz]=size(alpha_star);
[ntheta,nalpha,nw]=size(g_c);
assert(length(cor_alpha)==nalpha);
assert(length(cor_w)==nw);
[alpha_cor,w_cor]=meshgrid(cor_alpha,cor_w);

g5=zeros([nx,ny,nz],'single');
if isgpuarray(g_c)
    g5=gpuArray(g5);
    index=gpuArray(index);
    alpha_star=gpuArray(alpha_star);
    w_star=gpuArray(w_star);
    v_star=gpuArray(v_star);
end

for i=1:ntheta
    tmp=squeeze(g_c(i,:,:));
%     temp1=interp2(alpha_cor,w_cor,tmp',gpuArray(alpha_star(i,:,:,:)),gpuArray(w_star(i,:,:,:)),'linear',0);
%     g5=g5+squeeze(temp1.*gpuArray(index(i,:,:,:))./gpuArray(v_star(i,:,:,:))); 
    temp1=interp2(alpha_cor,w_cor,tmp',(alpha_star(i,:,:,:)),(w_star(i,:,:,:)),'linear',0);
    g5=g5+squeeze(temp1.*index(i,:,:,:)./v_star(i,:,:,:));
end
img=g5/2/pi;
img=gather(img);