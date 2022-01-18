%by Runqing Zhang
clc;
close all;
clear;

output_path = 'G:\TransT\M-CoTransT\supplement\demo';
LaSOT_dataset_path = 'G:\LaSOTTest\zip\';      % LaSOT test dataset file path
res_ours_path = 'G:\TransT\M-CoTransT\LaSOT\'; % results txt file path

seqs = config_sequence('test_set');          %load seqs list

for i = 1:280
    seq = seqs{i};
    tem_seq_path = [LaSOT_dataset_path seq '\'];
    
    tem_rect_path = [res_ours_path seq '.txt'];
    tem_rect = dlmread(tem_rect_path);
    
    seq_len = length(tem_rect);
    for f = 1:seq_len
        rect = tem_rect(f,:);
        im_num = num2str(f,'%08d');
        im_path = [tem_seq_path,'\img\',im_num,'.jpg'];
        im = imread(im_path);
        
        imshow(im);
        hold on;
        rectangle('Position',rect,'LineWidth',5,'Edgecolor','r','LineStyle','-');%ºìÉ«
        im_tem = getframe;
        drawnow;
        hold off;
        
        %save img
        im_save_path = [output_path, im_num, '.jpg'];
        draw_fig = im_tem.cdata;
        imwrite(draw_fig, im_save_path);
    end
    
end