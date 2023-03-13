% cureve for potential
x = [ 3, 3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 3.8, 3.9, 4.0, 4.1, 4.2, 4.3, 4.4, 4.5, 4.6, 4.7, 4.8, 4.9, 5, 5.1,];
y0 = [ 430, 304, 213, 72.6, 15.7, 5.43, 2.02, -1.45, -4.67, -5.31, -3.23, -1.32, -0.34, -0.25, -0.12, -0.09, -0.07, -0.02, 0, 0, 0, 0];
y = exp(-0.4036*y0)
%p = polyfit(x,y,12);

x1 = linspace(0, 10, 1000);
%y1 = polyval(p,x1);
figure
plot(x,y,'o')
hold on
plot(x1,den(x1))
hold on

u = @(x,y) 1+0.0001*x;
for a =3.7:0.2:6.8
    %CH1
    u1 = @(x,y) den(-x).*den(x-y).*den(2*a+y-x).*den(x+2*a).*den(-y-2*a);
    ymin = @(x) x-2*a;
    A = integral2(u1,-2*a,0, ymin, -2*a)
    %LK1
    ymax = @(x) x;
    u2 = @(x,y) den(-x).*den(-x).*den(x-y).*den(x-y).*den(y+2*a)
    B = integral2(u2,-2*a,0,-2*a, ymax)
    %LK2
    ymin = @(x) x;
    u3 = @(x,y) den(y-x).*den(-y).*den(y-x).*den(-y).*den(x+2*a)
    C = integral2(u3,-2*a,0, ymin,0)
    %LK3
    u4 = @(x,y) den(-x).*den(y).*den(x-y+2*a).*den(-x).*den(y)
    ymax = @(x) x+2*a;
    D = integral2(u4,-2*a, 0, 0,ymax)
    %CH2
    u5 = @(x,y) den(-x).*den(x+2*a).*den(y-x-2*a).*den(2*a-x).*den(y)
    ymin = @(x) x+2*a;
    E = integral2(u5,-2*a,0,ymin,2*a)
    %E = abs(integral2(u5,-2*a,0,ymin,2*a),'Method','iterated')
        % with more tolerance
    
end
plot(a,(A+E)/(C+D+E),'color',[0, 87, 3]/256, ...
    'LineWidth',1.5,'MarkerSize',1, ...
    'markerfacecolor',[155, 171, 145]/256, ...
     'LineStyle','-');
        
%% Function of probability density
function m=den(t)
    %m= 0.*(t>=0 & t<3.4)+(2*(t-3.4)).*(t>=3.4)+(-2*(t-3.9)).*(t>=3.9)
    m= 1+0.000001*t
    %m= 0.*(t>=0 & t<3.4)+(16*(t-3.4)).*(t>=3.4)+(-16*(t-3.5)-0.6).*(t>=4.0)
    %m= 0.0001*t.*(t>=0 & t<3.4)+(1.1*(t-3.4)).*(t>=3.4)+(2*(t-3.5)).*(t>=3.6)+(11*(t-3.6)).*(t>=3.6)+(34*(t-3.7)).*(t>=3.7)+(-30*(t-3.8)).*(t>=3.8)+(-62*(t-3.9)).*(t>=3.9)+(20*(t-4)).*(t>=4.0)+(19*(t-4.1)).*(t>=4.1)+(4.5*(t-4.2)).*(t>=4.2)+(0.3*(t-4.6)+0.12).*(t>=4.6)+(0.1*(t-6)).*(t>=6)
end

