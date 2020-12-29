% This script reproduces (correctly!) the table from Bansal 2018.

niters = 1000;

% The script as written takes a couple of hours to run. This can be
% shortened by either running things in parallel (which is very easy to do
% here) or by decreases the number of iterations: niters, above. Of course
% the 3D section is what takes the longest.

%% 1D
FWHM = 5:5:25;
u = 1.5:0.5:3;
Dim = 10000;

store_clusters1D = zeros([length(FWHM), length(u), niters]);

for I = 1:length(FWHM)
    I
    for J = 1:length(u)
        J
        for iter = 1:niters
            if mod(iter,100) == 0
                iter
            end
            field = noisegen( Dim, 1, FWHM(I));
            store_clusters1D(I,J,iter) = numOfConComps(field, u(J));
        end
    end
end

save('./ECtable_sims.mat', 'store_clusters1D')

%% 2D
FWHM = 5:5:25;
u = 1.5:0.5:3;
Dim = [250,250];

store_clusters2D = zeros([length(FWHM), length(u), niters]);

for I = 1:length(FWHM)
    I
    for J = 1:length(u)
        J
        for iter = 1:niters
            if mod(iter,100) == 0
                iter
            end
            field = noisegen( Dim, 1, FWHM(I));
            store_clusters2D(I,J,iter) = numOfConComps(field, u(J));
        end
    end
end

save('./ECtable_sims.mat', 'store_clusters1D', 'store_clusters2D')

%% 3D
FWHM = 5:5:25;
u = 1.5:0.5:3;
Dim = [90,90,90];

store_clusters3D = zeros([length(FWHM), length(u), niters]);

for I = 1:length(FWHM)
    I
    for J = 1:length(u)
        J
        for iter = 1:niters
            if mod(iter,100) == 0
                iter
            end
            field = noisegen( Dim, 1, FWHM(I));
            store_clusters3D(I,J,iter) = numOfConComps(field, u(J));
        end
    end
end

save('./ECtable_sims.mat', 'store_clusters3D', 'store_clusters2D', 'store_clusters1D')
