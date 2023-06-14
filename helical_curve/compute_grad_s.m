function g1=compute_grad_s(pf,delt_alpha,delt_theta)
% delt_theta=theta(2)-theta(1);
pf=permute(pf,[3,2,1]);

d_proj=zeros(size(pf),'single');
d_col=zeros(size(pf),'single');
if isgpuarray(pf)
    d_proj=gpuArray(d_proj);
    d_col=gpuArray(d_col);
end

% d_proj(1:end-1,1:end-1,:)=(pf(2:end,1:end-1,:)-pf(1:end-1,1:end-1,:))/2/delt_theta...
%                          +(pf(2:end,2:end,:)-pf(1:end-1,2:end,:))/2/delt_theta;
% d_col(1:end-1,:,1:end-1)=(pf(1:end-1,:,2:end)-pf(1:end-1,:,1:end-1))/2/delt_alpha...
%                          +(pf(2:end,:,2:end)-pf(2:end,:,1:end-1))/2/delt_alpha;

d_proj(2:end-1,1:end-1,:)=(pf(3:end,1:end-1,:)-pf(1:end-2,1:end-1,:))/4/delt_theta...
                         +(pf(3:end,2:end,:)-pf(1:end-2,2:end,:))/4/delt_theta;
d_col(:,:,1:end-1)=(pf(:,:,2:end)-pf(:,:,1:end-1))/delt_alpha;

g1=d_proj+d_col;
g1=permute(g1,[1,3,2]);

