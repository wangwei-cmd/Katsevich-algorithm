function rf=recon_helical(sin,theta,theta_offset,p,DSD,DSO,x_cor,y_cor,z_cor, ...
                          alpha_cor,w_cor,usegpu)
h=p/2/pi;
delt_alpha=alpha_cor(2)-alpha_cor(1);
delt_theta=theta(2)-theta(1);
rFOV=max(abs(x_cor(:))); 
half_fan=asin(rFOV/DSO);
delt_phi=delt_alpha*4;
rDphi=ceil((pi/2+half_fan)/delt_phi);
phi_cor=[-rDphi:1:rDphi]*delt_phi+0.25*delt_phi;

tol=1e-3; 
maxiter=100;

if usegpu
    alpha_cor=gpuArray(alpha_cor);w_cor=gpuArray(w_cor);phi_cor=gpuArray(phi_cor);
    x_cor=gpuArray(x_cor);y_cor=gpuArray(y_cor);z_cor=gpuArray(z_cor);
end

z_cor_rec=z_cor+h*theta_offset; %rotate some angles 
t1=zeros(length(z_cor_rec),1);
t2=zeros(length(z_cor_rec),1);
rf=zeros(length(x_cor),length(y_cor),length(t1),'single');
for i=1:length(t1)
% for i=1:2
[s_b,s_t]=solve_pi(x_cor,y_cor,z_cor_rec(i),h/DSO,DSO,tol,maxiter);
s_min=min(min(s_b));s_max=max(max(s_t));
t1(i)=squeeze(floor((s_min-theta(1)-theta_offset)/delt_theta))+1;
t2(i)=squeeze(ceil((s_max-theta(1)-theta_offset)/delt_theta))+1;
t_need=theta(t1(i):t2(i))+theta_offset;
Lt(i)=length(t_need);
ind=index_theta(s_b,s_t,t_need,usegpu);
[alpha_s,v_s,w_s]=compue_alpha_v_w(DSO,DSD,h,t_need,x_cor,y_cor,z_cor_rec(i),usegpu);
sin_need=sin(:,:,[t1(i):t2(i)]);
if usegpu
   sin_need=gpuArray(sin_need);
end
rf(:,:,i)=backproject_helical(sin_need,DSD,h,DSO,phi_cor,...
          alpha_cor,w_cor,delt_alpha,delt_theta,alpha_s,v_s,w_s,ind,Lt(i));
i
end