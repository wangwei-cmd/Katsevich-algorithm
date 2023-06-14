function g3=Htransform_matrix(g3,u_cor)
L=size(g3,2);
% [nbeta,nu]=size(g3);
delt_u=u_cor(2)-u_cor(1);

h_matrix=makefilter_matrix(u_cor);
if isgpuarray(g3)
    h_matrix=gpuArray(h_matrix);
end
g3=pagemtimes(h_matrix,permute(g3,[2,1,3]))*delt_u;
g3=permute(g3,[2,1,3]);

% h_k=makefilter(u_cor);
% g3=permute(g3,[2,1,3]);
% for i=1:size(g3,3)
% g3(:,:,i)=imfilter(g3(:,:,i),h_k(end:-1:1)');
% end
% g3=permute(g3,[2,1,3])*delt_u;

% %%the following implementation will exhaust GPU-memory.
% g4=padarray(permute(g3,[2,1,3]),[L-1,0,0],'post');
% % % g4=imfilter(g4,h_k(end:-1:1)','circular');
% g4=ifft(fft(g4),fft(circshift(h_k',L)));
% g4=real(g4)*delt_u;
% g4=g4(1:L,:,:);
% g4=permute(g4,[2,1,3]);

% h_k=makefilter(u_cor);
% g3=permute(g3,[2,1,3]);
% g4=padarray(gather(g3),[L-1,0,0],'post');
% for i=1:size(g4,3)
%     tmp=real(ifft(fft(gpuArray(g4(:,:,i))).*fft(circshift(h_k',L))));
%     g3(:,:,i)=tmp(1:L,:);
% end
% g3=permute(g3,[2,1,3])*delt_u;

function h_k=makefilter(u_cor)
% u_cor=[-rDu:1:rDu]*delt_u;
delt_u=u_cor(2)-u_cor(1);
L=length(u_cor);
uu=[-L+1:L-1]*delt_u-0.5*delt_u;
b=1/2/delt_u;
sin_u=sin(uu);
h_k=hilbert_fun(b,sin_u);
% h_k=u_cor./sin_u.*hilbert_fun(b,u_cor);
h_k(isnan(h_k))=0;



function [h_matrix,h_k]=makefilter_matrix(u_cor)
% u_cor=[-rDu:1:rDu]*delt_u;
delt_u=u_cor(2)-u_cor(1);
L=length(u_cor);
uu=[-L+1:L-1]*delt_u-0.5*delt_u;
b=1/2/delt_u;
sin_u=sin(uu);
h_k=hilbert_fun(b,sin_u);
% h_k=u_cor./sin_u.*hilbert_fun(b,u_cor);
h_k(isnan(h_k))=0;
h_matrix=zeros([L,L],'single');
for i=1:L
    h_matrix(i,:)=h_k(i+L-1:-1:i);
end

function h_t=hilbert_fun(b,t)
h_t=(1-cos(2*pi*b*t))./(pi*t);
% h_t=1/pi./t;
h_t(t==0)=0;
L=length(h_t);
fht=fft(h_t);
% filter='ram-lak';
filter='hamming';
% filter='hann';
switch filter
    case 'ram-lak'
        % %         Do nothing
    case 'hamming'
        window=fftshift(hamming(L))';
        h_t=real(ifft(fht.*window(1:end)));
    case 'hann'
        window=fftshift(hanning(L))';
        h_t=real(ifft(fht.*window(1:end)));
%     case 'hamming'
%         window=fftshift(hamming(L+1))';
%         h_t=real(ifft(fht.*window(1:end-1)));
%     case 'hann'
%         window=fftshift(hanning(L+1))';
%         h_t=real(ifft(fht.*window(1:end-1)));

%%%%the following two freq are not valid
%     case 'shepp-logan'
%         % be careful not to divide by 0:
%         freq=fftfreq(L);
%         freq=freq(2:end)*pi;
%         window=sin(freq)/freq;
%         F=fht;
%         F(2:end)=fht(2:end).*window;
%         h_t=real(ifft(F));
%     case 'cosine'
%         freq=linspace(0,pi,L+1);
%         window=sin(freq(1:end-1));
%         h_t=real(ifft(fht.*window));

end


function f=fftfreq(n)
if mod(n,2)==0
    f=[[0:n/2-1],-[n/2:-1:1]];
else
    f=[[0:(n-1)/2],-[(n-1)/2:-1:1]];
end




