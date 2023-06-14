function [s_b,s_t]=solve_pi(x,y,z,h,R,tol,maxiter)
%%%%% reference:
% A FAST ALGORITHM TO COMPUTE THE π-LINE THROUGH POINTS INSIDE A HELIX CYLINDER
x=x/R;
y=y/R;
z=z/R;
[x_cor,y_cor,z_cor]=meshgrid(x,y,z);
x_cor=permute(x_cor,[2,1,3]);
y_cor=permute(y_cor,[2,1,3]);
rho=sqrt(x_cor.^2+y_cor.^2);

% gamma=acos(x_cor./rho);
gamma=acos(complex(x_cor./rho));
gamma=real(gamma);
gamma(y_cor<0)=2*pi-gamma(y_cor<0);
gamma(rho==0)=0;

beta=gamma-z_cor./h;
beta=mod(beta,2*pi);
beta(beta>pi)=beta(beta>pi)-2*pi;
theta=zeros(size(x_cor));
for i=1:maxiter
    t1=cos(theta);
    t2=1-rho.^2.*t1.^2;
    g=theta-rho.*sin(theta).*acos(rho.*t1)./sqrt(t2);
    g1=(1-rho.^2)./((t2).^(3/2)).*(sqrt(t2)-rho.*t1.*acos(rho.*t1));
    theta=theta-(g-beta)./g1;
    theta(theta<-pi)=-pi;
    theta(theta>pi)=pi;
    error=abs(g-beta);
    error=sum(error(:));
    if error<tol
        break;
    end
end
alpha=acos(rho.*cos(theta));
lambda=z_cor./h-rho.*sin(theta).*acos(rho.*cos(theta))./sqrt(1-rho.^2.*cos(theta).^2);
s_b=lambda-alpha;
s_t=lambda+alpha;

% s_b=gather(s_b);
% s_t=gather(s_t);

% error=verify(s_b,s_t,x_cor,y_cor,z_cor,h);
% [nx,ny,nz]=size(x_cor);
% av_angle_error=sum(error(:))/nx/ny/nz
end

function error=verify(s_b,s_t,x_cor,y_cor,z_cor,h)
x1=cos(s_b);
y1=sin(s_b);
z1=h*s_b;
x2=cos(s_t);
y2=sin(s_t);
z2=h*s_t;
ax=x2-x1;
ay=y2-y1;
az=z2-z1;
xx=(x_cor-x1);
xy=(y_cor-y1);
xz=(z_cor-z1);
ttt=(ax.*xx+ay.*xy+az.*xz)./sqrt(ax.^2+ay.^2+az.^2)./sqrt(xx.^2+xy.^2+xz.^2);
error=acosd(complex(ttt));
end








    