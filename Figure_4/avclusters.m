%% 3D
FWHM_vec = [5,15,25];
u = 1.5:0.1:5;
Dim = [90,90,90];

niters = 1000;

store_ACcurve3D = zeros([length(u), niters, length(FWHM_vec)]);

for I = 1:length(FWHM_vec)
    FWHM = FWHM_vec(I);
    for iter = 1:niters
        iter
        field = noisegen( Dim, 1, FWHM );
        for J = 1:length(u)
            store_ACcurve3D(J,iter,I) = numOfConComps(field, u(J));
        end
    end
end

BRloc = 'C:/Users/12SDa/global/TomsMiniProject/Latex/MyPapers/BansalResponse/BansalResponse/';
save([BRloc,'Figure_4/ACcurve.mat'], 'store_ACcurve3D')

%%
temp = load([BRloc,'Figure_4/ACcurve.mat'], 'store_ACcurve3D');
store_ACcurve3D = temp.store_ACcurve3D;

%%%% Theory estimation
ECtheory = zeros(length(FWHM_vec), length(u));

FWHM_vec = [5,15,25];
u = 1.5:0.1:5;

D = 3;
mask = ones(90,90,90);
for I = 1:length(FWHM_vec)
    FWHM = FWHM_vec(I);
    for J = 1:length(u)
        FWHM3d = FWHM*ones(1, D);
        resel_vec = spm_resels_vol(mask, FWHM3d)';
        [~, ~,EEC_spm] = spm_P_RF(1,0,u(J),1,'Z',resel_vec,1);
        ECtheory(I,J) = EEC_spm;
    end
end

%%
std_quant = 0.95;
normquant = std_quant + (1-std_quant)/2;
niters = size(store_ACcurve3D,2);
clt_std_store = sqrt(var(store_ACcurve3D, 0, 2))*norminv(normquant)/sqrt(niters);

for I = 1:length(FWHM_vec)
    clf
    FWHM = FWHM_vec(I); 
    clt_std_curve = squeeze(clt_std_store(:,:,I));
    avnoclusters = mean(store_ACcurve3D(:,:,I), 2);
    
    % plot(u, avnoclusters)
    errorbar(u(1:end-5), avnoclusters(1:end-5), 2*clt_std_curve(1:end-5), 'linewidth', 2)
    hold on
    plot(u(1:end-5), ECtheory(I, 1:end-5))
    legend('Average number of clusters', 'Theoretical EC prediction')
    set(gcf, 'position', [0,0,700,500] )
    title(['Comparing theory and simulation for D = 3, FWHM = ', num2str(FWHM)])
    xlabel('Cluster Defining Threshold')
    ylabel('Expected number of clusters')
    BigFont(15);
    export_fig([BRloc, 'Figure_4/Figure_4_FWHM_', num2str(FWHM),'.pdf'], '-transparent')
end
%%
plot(u, ECtheory)
plot(u, avnoclusters)

%%
plot(u, ECtheory - avnoclusters')
ylim([-0.4,0.4])
title('The difference between the average number of clusters and the EEC')
xlabel('CDT')
ylabel('Difference')
