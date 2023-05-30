clear all;
nn=1;

figure 
leg={};
%for i = {'1E-3', '5E-4', '1E-4', '5E-5'};
    %cd(i{:})
    af=dir('C:\Users\41227\Desktop\k0001_l_pullf.txt'); %force file
    ax=dir('C:\Users\41227\Desktop\k0001_l_pullx.txt'); %displacement file
    aff=readmatrix(af(1).name);
    axx=readmatrix(ax(1).name);
    
    subplot(2,2,1)
    plot(smooth(axx(:,2),100),smooth(aff(:,2),100)); %distance vs force
    xlabel('displacement (nm)');ylabel('F (kJ/mol/nm)'); hold on

    subplot(2,2,2)
    plot(smooth(aff(:,1),100),smooth(aff(:,2),100)); %force(t)
    xlabel('t (ps)');ylabel('F (kJ/mol/nm)'); hold on

    subplot(2,2,3)
    plot(smooth(axx(:,1),100),smooth(axx(:,2),100)); %distance(t)
    xlabel('t (ps)');ylabel('displacement (nm)');; hold on



    Ff=aff(:,2);
    lt=sum(~isnan(Ff)); n=floor(lt/2);
    Ff_mean(nn)=nanmean(Ff(n:end));
    v(nn)=str2num(i{:}); 
    leg{nn}=i{:};
    nn=nn+1;
    

    hold on
    %cd ..
   
%end
legend(leg)
subplot(2,2,4)
plot(v,Ff_mean,'.','MarkerSize',20); xlabel('v (m/s)');ylabel('F (kJ/mol/nm)')