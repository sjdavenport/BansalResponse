%% Generate paper table using latex_table.m

% Table Prep
firstcolwidth = 6;
othercolwidths = 6;

header(1).names = {'FWHM', 'Cluster Defining Threshold'};
header(1).layout = [firstcolwidth,4*othercolwidths];
header(2).names = {'','1.5', '2.0', '2.5', '3.0'};
header(2).layout = [firstcolwidth,repmat(othercolwidths,1,4)];
hl.hlines = {[0,1],1};
hl.slines = {[0,1,0],[0,1,0,0,0,0]};
hl.alignment = {'c'};

FWHM_vec = (5:5:25)';
Amate = reshape(1:(length(FWHM_vec)*4), length(FWHM_vec), 4);
Bmate = 0.01*ones(length(FWHM_vec), 4);

main.layout = [firstcolwidth,repmat(othercolwidths,1,4)];
main.nonpatdata = {FWHM_vec};
main.nonpatcols = [1];
main.patcols = [2,3,4,5];
main.hlines = {0,0,0,0,1};
main.slines = {[0,1,1,1,1,0]};
main.alignment = {'c'};
main.ndecpts = 2;
main.nonpatndecpts = 0;

global lobal
saveloc = [lobal,'TomsMiniProject/Latex/MyPapers/2020/BansalResponse/Tables/'];

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
    
    main.patdata = {average_number_of_clusters, ' \\pm ', clt_stds, ' (', theory_mate, ')'};
    
    latex_table( main, header, hl, [saveloc,'table_',num2str(D),'D'])
%     latex_table( main, header, hl)
end


