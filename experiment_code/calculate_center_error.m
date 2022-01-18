clc;
clear;
close all;

addpath('.\utils\');
addpath('.\sequence_evaluation_config\');
seqs = config_sequence('test_set');

i = 1;
seq = seqs{i};

data_path = '.\tracking_results\';
TransT_predp = [data_path 'TransT_tracking_result\' seq '.txt'];
M_CoTransT_predp = [data_path 'M-CoTransT_tracking_result\' seq '.txt'];
anno_rectp = ['.\annos\' seq '.txt'];

TransT_pred = dlmread(TransT_predp);
M_CoTransT_pred = dlmread(M_CoTransT_predp);
anno_rect = dlmread(anno_rectp);

len = length(TransT_pred);
%search region
search_gt = anno_rect(1:len-1,:);
search_T = TransT_pred(2:len,:);
search_M = M_CoTransT_pred(2:len,:);

%TransT&anno_rect
[aveErrCoverage_TransT, aveErrCenter_TransT,errCoverage_TransT, errCenter_TransT] = ...
    calcSeqErrRobust(search_T, search_gt);

%M-CoTransT%anno_rect
[aveErrCoverage_M, aveErrCenter_M,errCoverage_M, errCenter_M] = ...
    calcSeqErrRobust(search_M, search_gt);

%for average
err_T = 0;
err_M = 0;
or_T = 0;
or_M = 0;
s=0;
list_s = [];

for i = 1:280
    seq = seqs{i};

    data_path = '.\tracking_results\';
    TransT_predp = [data_path 'TransT_tracking_result\' seq '.txt'];
    M_CoTransT_predp = [data_path 'M-CoTransT_tracking_result\' seq '.txt'];
    anno_rectp = ['.\annos\' seq '.txt'];

    TransT_pred = dlmread(TransT_predp);
    M_CoTransT_pred = dlmread(M_CoTransT_predp);
    anno_rect = dlmread(anno_rectp);

    len = length(TransT_pred);
    %search region
    search_gt = anno_rect(1:len-1,:);
    search_T = TransT_pred(2:len,:);
    search_M = M_CoTransT_pred(2:len,:);

    %TransT&anno_rect
    [aveErrCoverage_TransT, aveErrCenter_TransT,errCoverage_TransT, errCenter_TransT] = ...
        calcSeqErrRobust(search_T, search_gt);

    %M-CoTransT%anno_rect
    [aveErrCoverage_M, aveErrCenter_M,errCoverage_M, errCenter_M] = ...
        calcSeqErrRobust(search_M, search_gt);
    
    err_T = err_T + aveErrCenter_TransT;
    err_M = err_M + aveErrCenter_M;
    
    or_T = or_T + aveErrCoverage_TransT;
    or_M = or_M + aveErrCoverage_M;
    
    if aveErrCenter_TransT > aveErrCenter_M
        %seq
        s = s+1;
        list_s = [list_s;i];
    end
end
err_T = err_T/280;
err_M = err_M/280;
or_T = or_T/280;
or_M = or_M/280;


[err_T,err_M]
[or_T,or_M]
s