% clear
function [phi,z,pho,d]=read_para(pre)
% pre='./dcmproj_reference/*.dcm';
% pre='./dcmrecon_reference/*.dcm';
pre=dir(pre);
LL=length(pre);
phi=zeros(LL,1);
z=phi;
pho=phi;
d=phi;
% centerx=phi;
% centery=phi; 
% start=3579;%%%%phi(start=0)
parfor i=1:LL
% for i=1:LL
name=[pre(i).folder,'/',pre(i).name];
HEADER = dicominfo(name, 'dictionary','DICOM-CT-PD-dict_v8.txt');
phi(i)=HEADER.DetectorFocalCenterAngularPosition;
z(i)=HEADER.DetectorFocalCenterAxialPosition;
% pho(i)=HEADER.DetectorFocalCenterRadialDistance;
% d(i)=HEADER.ConstantRadialDistance;
% tmp=HEADER.DetectorCentralElement;


% centerx(i)=tmp(1);
% centery(i)=tmp(2);
end