%% 3D
FWHM = 25;
u = 1.5:0.1:5;
Dim = [90,90,90];

store_ACcurve3D = zeros([length(u), niters]);

niters = 1000;

for iter = 1:niters
    iter
    field = noisegen( Dim, 1, FWHM);
    for J = 1:length(u)
        store_ACcurve3D(J,iter) = numOfConComps(field, u(J));
    end
end

%%
store_ACcurve3D  = store_clusters3D;
save('./ACcurve.mat', 'store_ACcurve3D')

%%
temp = load('./ACcurve.mat', 'store_ACcurve3D');
store_ACcurve3D = temp.store_ACcurve3D;

avnoclusters = mean(store_ACcurve3D, 2);

%%%% Theory estimation
ECtheory = zeros(1, length(u));

FWHM = 25;
u = 1.5:0.1:5;

D = 3;
mask = ones(90,90,90);
for J = 1:length(u)
    FWHM_vec = FWHM*ones(1, D);
    resel_vec = spm_resels_vol(mask, FWHM_vec)';
    [~, ~,EEC_spm] = spm_P_RF(1,0,u(J),1,'Z',resel_vec,1);
    ECtheory(J) = EEC_spm;
end

%%
std_quant = 0.95;
normquant = std_quant + (1-std_quant)/2;
niters = size(store_ACcurve3D,2);
clt_std_curve = sqrt(var(store_ACcurve3D, 0, 2))*norminv(normquant)/sqrt(niters);

set(0,'defaultAxesFontSize', 13);
% plot(u, avnoclusters)
errorbar(u(1:end-5), avnoclusters(1:end-5), 2*clt_std_curve(1:end-5), 'linewidth', 2)
hold on
plot(u(1:end-5), ECtheory(1:end-5))
legend('Average number of clusters', 'Theoretical EC prediction')
set(gcf, 'position', [0,0,700,500] )
title('Comparing theory and simulation for D = 3, FWHM = 25')
xlabel('Cluster Defining Threshold')
ylabel('Expected number of clusters')
export_fig('./Figure_2.pdf', '-transparent')

%%
plot(u, ECtheory)
plot(u, avnoclusters)

%%
plot(u, ECtheory - avnoclusters')
ylim([-0.4,0.4])
title('The difference between the average number of clusters and the EEC')
xlabel('CDT')
ylabel('Difference')
