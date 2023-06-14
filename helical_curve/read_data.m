function sin=read_data(pre)
pre=dir(pre);
LL=length(pre);

name=[pre(1).folder,'/',pre(1).name];
tmp=single(dicomread(name));
sin=single(zeros([size(tmp,1),size(tmp,2),LL]));
parfor i=1:LL
    name=[pre(i).folder,'/',pre(i).name];
    info=dicominfo(name,'dictionary','DICOM-CT-PD-dict_v8.txt');
%     sin(:,:,i)=single(dicomread(name));
    tmp=single(dicomread(name));
    sin(:,:,i)=tmp*info.RescaleSlope+info.RescaleIntercept;
end

% img=single(zeros(768,768,192));
% img_pre='./dcmrecon_reference/slice_';
% parfor i=1:192
%     img(:,:,i)=single(dicomread([img_pre,num2str(i,'%03d'),'.dcm']));
% end

% fileID = fopen('challenge_reference_860_860_320_0.25_mm_10mat.bin','r');
% B = fread(fileID,'*uint8');
% B=reshape(B,[860,860,320]);
% fclose(fileID);