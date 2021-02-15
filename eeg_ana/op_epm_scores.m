function score = op_epm_scores(close1,close2,open1,open2)
% ����߼��Թ� ���űۺͱպϱ�֮���EPM socre
% �ο����� Single Units in the Medial Prefrontal Cortex with
% Anxiety-Related Firing Patterns Are Preferentially
% Influenced by Ventral Hippocampal Activity

A = .25*(abs(close1 - open1) + abs(close1 - open2) + abs(close2 - open1) + abs(close2 - open2));

B = .5*(abs(close1 - close2) + abs(open1 - open2));

score = (A - B)/(A + B);

end