CDT = [1.5 2.0 2.5 3.0];
SamD=[
  5 336.36 0.1 353.79  288.06 0.08 315  151.9 0.07 171.14  55.17 0.05 64.35
  10 55.97 0.04 56.19  44.81 0.03 45.77  23.25 0.03 23.93  8.46 0.02 8.8
  15 20.59 0.02 20.57  15.47 0.02 15.61  7.77 0.02 7.89  2.79 0.01 2.84
  20 10.52 0.02 10.49  7.47 0.01 7.52  3.66 0.01 3.69  1.29 0.01 1.31
  25 6.41 0.01 6.39  4.35 0.01 4.36  2.08 0.01 2.08  0.73 0.01 0.72];
BanD=[
   5 259.6 1.14 168.9 265.8 1.04 168.9 175.2 0.78 96 35.8 0.62 37 
  10 47.18 1.12 23.8 55.9 0.96 23.8 33.1 0.46 13.5 0.5 0.08 5.2 
  15 45.8 1.13 11.7 35.1 1.32 11.7 32.1 0.68 6.6 0.5 0.10 2.5 
  20 116.5 3.46 14 109 1.67 14 27 0.66 8 2.2 0.29 3 
  25 200.4 3.72 18.3 97.1 3.0 18.3 42.2 0.78 10.4 3 0.30 4];


Sam.f   = repmat([SamD(:,1);NaN],[length(CDT),1]);
nFWHM=5;
tmp=repmat(CDT,[nFWHM+1,1]);
Sam.cdt = tmp(:);
Ban=Sam;
Sam.EnMC  = [SamD(:,2);NaN;SamD(:,5);NaN;SamD(:,8);NaN;SamD(:,11);NaN];
Sam.SDnMC = [SamD(:,3);NaN;SamD(:,6);NaN;SamD(:,9);NaN;SamD(:,12);NaN];
Sam.EEC   = [SamD(:,4);NaN;SamD(:,7);NaN;SamD(:,10);NaN;SamD(:,13);NaN];

Ban.EnMC  = [BanD(:,2);NaN;BanD(:,5);NaN;BanD(:,8);NaN;BanD(:,11);NaN];
Ban.SDnMC = [BanD(:,3);NaN;BanD(:,6);NaN;BanD(:,9);NaN;BanD(:,12);NaN];
Ban.EEC   = [BanD(:,4);NaN;BanD(:,7);NaN;BanD(:,10);NaN;BanD(:,13);NaN];

h=semilogy(Ban.f,Ban.EnMC,'-',Ban.f,Ban.EEC,'--',...
               Sam.f,Sam.EnMC,'-',Sam.f,Sam.EEC,'--');
ThickLine(3)
BigFont
% set(h(1:2),'color',def_col('red'))
% set(h(3:4),'color',def_col('blue'))
% legend({'Bansal: MC E(Size)','Bancal: RFT E(Size)',...
%         'MC E(Size)','RFT E(Size)'})
% xlabel('FWHM')
% ylabel('Number of clusters')
% title('Expected Number of Clusters')
% export_fig('BansalSizeCDTall','-pdf')

for i=1:length(CDT)
    cdt=CDT(i)

    I = Sam.cdt==cdt;
    Lines = str2mat('-','-.','--',':');
    Col=get(gca,'colororder');
    h=semilogy(Ban.f(I),Ban.EnMC(I),'-',Ban.f(I),Ban.EEC(I),'--o',...
               Sam.f(I),Sam.EnMC(I),'-',Sam.f(I),Sam.EEC(I),'--o');
    ThickLine(3)
    BigFont
    set(h(1:2),'Color',Col(1,:))
    set(h(3:4),'Color',Col(2,:))
    if CDT(i) > 2.5
        legend({'BP: MC E(Cluster Size)','Bansal: RFT E(Cluster Size)',...
            'MC E(Cluster Size)','RFT E(Cluster Size)'})
    end
    xlabel('Applied FWHM (per voxel)')
    ylabel('Number of clusters')
    title(['Expected Number of Clusters - CDT ' num2str(cdt)])
    export_fig(['BansalSizeCDT' num2str(cdt)],'-pdf')
end
    


