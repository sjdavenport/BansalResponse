%% 2D
FWHM_vec = [5,15,25];
u = 1.5:0.1:5;
Dim = [250,250];

niters = 10000;

store_maxcsize_2D = zeros([length(u), niters, length(FWHM_vec)]);

for I = 1:length(FWHM_vec)
    FWHM = FWHM_vec(I);
    for iter = 1:niters
        iter
        field = noisegen( Dim, 1, FWHM );
        for J = 1:length(u)
            [ ~, ~, sizes]= numOfConComps(field, u(J));
            if isempty(sizes)
                store_maxcsize_2D(J,iter,I) = 0;
            else
                store_maxcsize_2D(J,iter,I) = max(sizes);
            end
        end
    end
end

BRloc = 'C:/Users/12SDa/global/TomsMiniProject/Latex/MyPapers/BansalResponse/BansalResponse/';
save([BRloc,'Figure_4/maxcsizes.mat'], 'store_maxcsize_2D')

%  3D
FWHM_vec = [5,15,25];
u = 1.5:0.1:5;
Dim = [90,90,90];


niters = 10000;

store_maxcsize_3D = zeros([length(u), niters, length(FWHM_vec)]);

for I = 1:length(FWHM_vec)
    FWHM = FWHM_vec(I);
    for iter = 1:niters
        iter
        field = noisegen( Dim, 1, FWHM );
        for J = 1:length(u)
            [ ~, ~, sizes]= numOfConComps(field, u(J));
            if isempty(sizes)
                store_maxcsize_3D(J,iter,I) = 0;
            else
                store_maxcsize_3D(J,iter,I) = max(sizes);
            end
        end
    end
end

BRloc = 'C:/Users/12SDa/global/TomsMiniProject/Latex/MyPapers/BansalResponse/BansalResponse/';
save([BRloc,'Figure_4/maxcsizes.mat'], 'store_maxcsize_2D', 'store_maxcsize_3D')

%%

