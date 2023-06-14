clear;
addpath('../helical_curve/')

pre='../dcmproj_copd/dcm_000';
name=[pre,'/*.dcm'];
[phi,z]=read_para(name);
sin=read_data(name);
sin=sin(:,:,end:-1:1);

DSD=1050;
DSO=575;
p=35.05;
delt_theta=2*pi/1000;

x_cor=[-256:255]*0.976;y_cor=[-256:255]*0.976;
z_cor=linspace(z(501),z(end-500),513);%%%%copd
x_cor=single(x_cor);y_cor=single(y_cor);
z_cor=single(z_cor);

delt_alpha=1/DSD;
alpha_cor=([1:900]-448.5)*delt_alpha;
w_cor=([1:64]-32.5);
alpha_cor=single(alpha_cor);w_cor=single(w_cor);

theta=[0:length(phi)]*delt_theta;
theta_offset=-pi/2+delt_theta;%%%to rotate the reconstructed image 
usegpu=1;
rf=recon_helical(sin,theta,theta_offset,p,DSD,DSO, ...
    x_cor,y_cor,z_cor,alpha_cor,w_cor,usegpu);
rf=1000*(rf-0.019922)/(0.019922-0.00021);


rmpath('../helical_curve/')