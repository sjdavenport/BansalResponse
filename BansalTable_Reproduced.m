%% All of the elements needed to reproduce the table
theory = load('./ECtable.mat');
sims = load('./ECtable_sims');

std_quant = 0.95;
for D = 1:3
    theory_mate = theory.(['ECtablemate_spm_',num2str(D),'D']);
    sim_data = sims.(['store_clusters',num2str(D),'D']);
    average_number_of_clusters = mean(sim_data,3);
        
    niters = size(sim_data,3);
    normquant = std_quant + (1-std_quant)/2;
    clt_stds = sqrt(var(sim_data, 0, 3))*norminv(normquant)/sqrt(niters);
end