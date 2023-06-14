function [k_index,weight]=solve_k_line(cor_alpha,cor_w,cor_phi,DSD,h,DSO)
nalpha=length(cor_alpha);
nphi=length(cor_phi);
nw=length(cor_w);
[alpha_cor,phi_cor]=meshgrid(cor_alpha,cor_phi);
alpha_cor=alpha_cor';
phi_cor=phi_cor';
w_phi=DSD*h/DSO*(phi_cor.*cos(alpha_cor)+phi_cor./tan(phi_cor).*sin(alpha_cor));
w_phi(phi_cor==0)=DSD*h/DSO*sin(alpha_cor(phi_cor==0));
weight=zeros([nalpha,nw],'single');
% weight=gpuArray(weight);
k_index=weight;
for i=1:nalpha
    if cor_alpha(i)>=0
        for j=1:nw
            for k=1:nphi-1
                if w_phi(i,k)<=cor_w(j)&&cor_w(j)<=w_phi(i,k+1)
                    weight(i,j)=(cor_w(j)-w_phi(i,k))/(w_phi(i,k+1)-w_phi(i,k));
                    k_index(i,j)=k;
%                     g_5(:,i,j)=(1-weight).*g4(:,i,k_index)+weight.*g4(:,i,k_index+1);
                    break;
                end
            end
        end
    end
    if cor_alpha(i)<0
        for j=1:nw 
            for k=nphi-1:-1:1
                if w_phi(i,k)<=cor_w(j)&&cor_w(j)<=w_phi(i,k+1)
                    weight(i,j)=(cor_w(j)-w_phi(i,k))/(w_phi(i,k+1)-w_phi(i,k));
                    k_index(i,j)=k;
%                     g_5(:,i,j)=(1-weight).*g4(:,i,k_index)+weight.*g4(:,i,k_index+1);
                    break;
                end
            end
        end
    end
end  