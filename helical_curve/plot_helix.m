function plot_helix(h,DSO,x,y,z,s_b,s_t)
[x_cor,y_cor,z_cor]=meshgrid(x,y,z);
x_cor=permute(x_cor,[2,1,3]);
y_cor=permute(y_cor,[2,1,3]);
s=[min(s_b(:))-pi:0.1:max(s_t(:))+pi];
x=DSO*cos(s);
y=DSO*sin(s);
z=h*s;
plot3(x,y,z);
N1=5;N2=7;
for i=N1:N2
    for j=N1:N2
        for k=1
            x1=DSO*cos(s_b(i,j,k));
            y1=DSO*sin(s_b(i,j,k));
            z1=h*s_b(i,j,k);
            x2=DSO*cos(s_t(i,j,k));
            y2=DSO*sin(s_t(i,j,k));
            z2=h*s_t(i,j,k);
            hold on; plot3([x1,x_cor(i,j,k),x2],[y1,y_cor(i,j,k),y2],[z1,z_cor(i,j,k),z2]);
        end
    end
end