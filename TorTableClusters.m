% This script tests the setting of Bansal and Perterson with fields on a
% torus
%% 2D
niters = 1000;
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
            
            % Generate a 2D toroidal field
            white_noise = randn(Dim);
            [field,ss] = tor_conv(white_noise, FWHM(I), 2); 
            
            % Ensure the noise is variance 1
            field = field./sqrt(ss); 
            
            % Calculate the number of clusters above the threshold
            store_clusters2D(I,J,iter) = numOfConComps(field, u(J));
        end
    end
end

save('./tor_sims.mat','store_clusters2D')

%% Plot Tor sims
for J = 1:length(u)
    subplot(2,2,J)
    plot(FWHM, mean(store_clusters2D(:,J,:),3))
end
