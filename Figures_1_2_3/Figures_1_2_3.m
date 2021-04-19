% Figures 1-3, comparing BP's expected number of clusters to the truth
% Set FWHM vector
FWHM_vec = 5:5:25;
CDT_vec = [1.5,2,2.5,3];

% Set the location of the repository
repo_loc = 'C:/Users/12SDa/global/TomsMiniProject/Latex/MyPapers/BansalResponse/BansalResponse/';

% Load in data
load([repo_loc, 'BP_table'], 'BP_table');
ECtheory = load([repo_loc,'ECtable.mat']);
ECsims = load([repo_loc,'ECtable_sims.mat']);

for D = 1:3
    MC_mate = mean(ECsims.(['store_clusters', num2str(D), 'D']), 3);
    theory_mate = ECtheory.(['ECtablemate_spm_', num2str(D), 'D']);
    for I = 1:length(CDT_vec)
        h = semilogy(FWHM_vec, BP_table.MCsize{D}(:,I),'-',...
            FWHM_vec, BP_table.ECsize{D}(:,I),'--o',...
            FWHM_vec, MC_mate(:,I), '-', ...
            FWHM_vec, theory_mate(:,I), '--o');
        
        set(h(1:2),'Color',def_col('blue'))
        set(h(3:4),'Color',def_col('red'))
        
        ThickLine(3);
        BigFont(17)
        
%         ylim([0, max([BP_table.MCsize{D}(:,I)', BP_table.ECsize{D}(:,I)', ...
%             MC_mate(:,I)', theory_mate(:,I)'])])
%         if D > 1
%             yticks([0,1,10,100])
%         end
        if CDT_vec(I) > 2.5
            legend({'BP: MC E(# of Clusters)','BP: RFT E(# of Clusters)',...
                'MC E(# of Clusters)','RFT E(# of Clusters)'})
            if D == 2
                ylim([0,50])
            end
        end
        if D > 1
            yticks([1,10,50,100])
        end
        xlabel('Applied FWHM (in voxels)')
        ylabel('Number of clusters')
        title(['Expected Number of Clusters - CDT ' num2str(CDT_vec(I))])
        export_fig([repo_loc, 'Figures_1_2_3/BPcompare_CDT',  num2str(CDT_vec(I)), '_D_', num2str(D)],'-pdf', '-transparent')
    end
end
