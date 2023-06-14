clear;
addpath('../helical_curve')

pre='../L109/DICOM-CT-PD_FD/';
name=[pre,'*.dcm'];
[phi,z]=read_para(name);
% z=z-z(1);

sin=read_data(name);
sin=sin(end:-1:1,:,end:-1:1);

DSD=1.0856e+03;
DSO=595;
% p=0.6*64*1.0947/DSD*DSO;
p=23;
DefTimes=2304;
delt_theta=2*pi/DefTimes;
HF=0.0192; %%info.HUCalibrationFactor

x_cor=linspace(-264,247,512)*0.7813;
y_cor=linspace(-260,251,512)*0.7813;
z_cor=z(end)-[99:2:353];
x_cor=single(x_cor);y_cor=single(y_cor);
z_cor=single(z_cor);


delt_alpha=1.2858/DSD;
alpha_cor=([1:736]-369.625)*delt_alpha;
alpha_cor=-alpha_cor(end:-1:1);
w_cor=([1:64]-32.5)*1.0947;
alpha_cor=single(alpha_cor);
w_cor=single(w_cor);

theta=([0:size(phi,1)])*delt_theta;
theta_offset=phi(end)-pi/2;
usegpu=1;
rf=recon_helical(sin,theta,theta_offset,p,DSD,DSO, ...
    x_cor,y_cor,z_cor,alpha_cor,w_cor,usegpu);
rf=1000*(rf-HF)/HF;

rmpath('../helical_curve')