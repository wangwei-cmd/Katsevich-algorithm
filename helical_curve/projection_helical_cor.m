function pf=projection_helical_cor(img,theta,DSD,DSO,p,cor_alpha,cor_w,cor_x,cor_y,cor_z,usegpu)
nproj=length(theta);
if usegpu
img=gpuArray(img);
cor_alpha=gpuArray(cor_alpha);
cor_w=gpuArray(cor_w);
cor_x=gpuArray(cor_x);
cor_y=gpuArray(cor_y);
cor_z=gpuArray(cor_z);
end
[alpha_cor,w_cor]=meshgrid(cor_alpha,cor_w);
alpha_cor=alpha_cor';
w_cor=w_cor';

rr=sqrt(max(abs(cor_x(:))).^2+max(abs(cor_y(:))).^2);
delt_t=min(abs(cor_x(2)-cor_x(1)),abs(cor_y(2)-cor_y(1)))/2;
tt=[DSO-rr:delt_t:DSO+rr];
tt=repmat(tt',[1,length(cor_alpha),length(cor_w)]);
tt=permute(tt,[2,3,1]);

x0=DSO*cos(theta);
y0=DSO*sin(theta);
% x0=-DSO*sin(theta);
% y0=DSO*cos(theta);
z0=p*theta/2/pi;

[x_cor,y_cor,z_cor]=meshgrid(cor_x,cor_y,cor_z);
pf=zeros(length(cor_alpha),length(cor_w),nproj,'single');
if usegpu
    pf=gpuArray(pf);
end

for i=1:nproj
    tmp_angle=alpha_cor-theta(i);
    xx=-DSD*cos(tmp_angle);
    yy=DSD*sin(tmp_angle);
    zz=w_cor;
    LL=sqrt(DSD^2+w_cor.^2);
    xq=x0(i)+tt.*xx./LL;
    yq=y0(i)+tt.*yy./LL;
    zq=z0(i)+tt.*zz./LL;
    tmp=interp3(x_cor,y_cor,z_cor,img,xq,yq,zq,'linear',0);
%     tmp=interp3(x_cor,y_cor,z_cor,img,xq,yq,zq,'nearest',0);
    pf(:,:,i)=sum(tmp,3)*delt_t;

end
pf=gather(pf);