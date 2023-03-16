 
clear all
% cureve for potential
x = [ 3, 3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 3.8, 3.9, 4.0, 4.1, 4.2, 4.3, 4.4, 4.5, 4.6, 4.7, 4.8, 4.9, 5, 5.1,];
y0 = [ 430, 304, 213, 72.6, 15.7, 5.43, 2.02, -1.45, -4.67, -5.31, -3.23, -1.32, -0.34, -0.25, -0.12, -0.09, -0.07, -0.02, 0, 0, 0, 0];
y = exp(-0.4036*y0)
x0 = linspace(0, 10, 1000);
figure
%plot(x,y,'o')
hold on
%plot(x0,den(x0))
hold on

 x1=[];
 y1=[];
 x2=[];
 y2=[];
 a1=[];
 b1=[];
 hold on 
 axis([0 10 0 1000]);
 a = 5.8
 for p =1:0.3:10
    %CH1
    u1 = @(x,y) (p*den(-x)+den1(-x)).*(p*den(x-y)+den1(x-y)).*(p*den(2*a+y-x)+den1(2*a+y-x)).*(p*den(x+2*a)+den1(x+2*a)).*(p*den(-y-2*a)+den1(-y-2*a));
    ymin = @(x) x-2*a;
    A = integral2(u1,-2*a,0, ymin, -2*a)
    %LK1
    ymax = @(x) x;
    u2 = @(x,y) (p*den(-x)+den1(-x)).*(p*den(-x)+den1(-x)).*(p*den(x-y)+den1(x-y)).*(p*den(x-y)+den1(x-y)).*(p*den(y+2*a)+den1(y+2*a))
    B = integral2(u2,-2*a,0,-2*a, ymax)
    x1=[x1,p];
    y1=[y1,3*B];
    a1=[a,A]
    b1=[a,B]
    x2=[x2,p];
    y2=[y2,2*A];
        
end
plot(x1,y1,'color',[0, 87, 3]/256, ...
    'LineWidth',1.5,'MarkerSize',1, ...
    'markerfacecolor',[155, 171, 145]/256, ...
     'LineStyle','-');
plot(x2,y2,'color',[100, 0, 3]/256, ...
    'LineWidth',1.5,'MarkerSize',1, ...
    'markerfacecolor',[100, 0, 3]/256, ...
     'LineStyle','-');
        
%% Function of probability density
function m=den(t)
     m = 0.*(t>=0 & t<3.3)+1.*(t>=3.3)+(-1).*(t>=3.9)
    %m= 1+0.000001*t
    %m = 0.*(t>=0 & t<3.4)+(16*(t-3.4)).*(t>=3.4)+(-16*(t-3.5)-0.6).*(t>=4.0)
    %m= 0.0001*t.*(t>=0 & t<3.4)+(1.1*(t-3.4)).*(t>=3.4)+(2*(t-3.5)).*(t>=3.6)+(11*(t-3.6)).*(t>=3.6)+(34*(t-3.7)).*(t>=3.7)+(-30*(t-3.8)).*(t>=3.8)+(-62*(t-3.9)).*(t>=3.9)+(20*(t-4)).*(t>=4.0)+(19*(t-4.1)).*(t>=4.1)+(4.5*(t-4.2)).*(t>=4.2)+(0.3*(t-4.6)+0.12).*(t>=4.6)+(0.1*(t-6)).*(t>=6)
end

function n=den1(t)
     n = 0.*(t>=0 & t<3.9)+(1).*(t>=3.9)
    %m= 1+0.000001*t
    %m = 0.*(t>=0 & t<3.4)+(16*(t-3.4)).*(t>=3.4)+(-16*(t-3.5)-0.6).*(t>=4.0)
    %m= 0.0001*t.*(t>=0 & t<3.4)+(1.1*(t-3.4)).*(t>=3.4)+(2*(t-3.5)).*(t>=3.6)+(11*(t-3.6)).*(t>=3.6)+(34*(t-3.7)).*(t>=3.7)+(-30*(t-3.8)).*(t>=3.8)+(-62*(t-3.9)).*(t>=3.9)+(20*(t-4)).*(t>=4.0)+(19*(t-4.1)).*(t>=4.1)+(4.5*(t-4.2)).*(t>=4.2)+(0.3*(t-4.6)+0.12).*(t>=4.6)+(0.1*(t-6)).*(t>=6)
end