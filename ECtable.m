%This script calculates the expected Euler characteristic in each setting
%using SPM.

%% 1D
ECtablemate_spm_1D = zeros(5, 4);

FWHM = 5:5:25;
u = 1.5:0.5:3;

D = 1
for J = 1:length(u)
    for I = 1:length(FWHM)
        FWHM_vec = FWHM(I)*ones(1, D);
        resel_vec = spm_resels(FWHM_vec,10000, 'B');
%         [~, ~,EEC_spm] = spm_P_RF(1,0,u(J),1,'Z',resel_vec(1:3),1);
        [~, ~,EEC_spm] = spm_P_RF(1,0,u(J),1,'Z',resel_vec,1);
        ECtablemate_spm_1D(I, J) = EEC_spm;
    end
end

ECtablemate_spm_1D
% save('./ECtable.mat', 'ECtablemate_spm_1D')

%% 2D
ECtablemate_spm_2D = zeros(5, 4);

FWHM = 5:5:25;
u = 1.5:0.5:3;

D = 2;
for J = 1:length(u)
    for I = 1:length(FWHM)
        FWHM_vec = FWHM(I)*ones(1, D);
        resel_vec = spm_resels(FWHM_vec,[250,250], 'B');
        [~, ~,EEC_spm] = spm_P_RF(1,0,u(J),1,'Z',resel_vec,1);
        ECtablemate_spm_2D(I, J) = EEC_spm;
    end
end

ECtablemate_spm_2D
save('./ECtable.mat', 'ECtablemate_spm_1D', 'ECtablemate_spm_2D')
%% 3D
ECtablemate_spm_3D = zeros(5, 4);

FWHM = 5:5:25;
u = 1.5:0.5:3;

D = 3;
mask = ones(90,90,90);
for J = 1:length(u)
    for I = 1:length(FWHM)
        FWHM_vec = FWHM(I)*ones(1, D);
        resel_vec = spm_resels_vol(mask, FWHM_vec)';
        [~, ~,EEC_spm] = spm_P_RF(1,0,u(J),1,'Z',resel_vec,1);
        ECtablemate_spm_3D(I, J) = EEC_spm;
    end
end

ECtablemate_spm_3D
save('./ECtable.mat', 'ECtablemate_spm_1D', 'ECtablemate_spm_2D', 'ECtablemate_spm_3D')