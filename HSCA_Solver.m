function [ W, H ] = HSCA_Solver( M, T, A, k, mu_, lambda )
% Decompose matrix M as M = W^T * H * T
% M random walk matrix size |V|X|V|
% T text feature ft X |V|
% W low-rank matrix k X |V|
% H low-rank matrix k X ft
ft = size(T,1);
n = size(T,2);
W = rand(k,n);
H = rand(k,ft);
L = sparse(diag(sum(A,2))-A);
maxIter = 1000;
eps_ = 0.01;
for iter = 1:maxIter
    disp('iter:');
    disp(iter);
    W0 = W;
    H0 = H;
    W = Update_For_W( M, W, H, L, T, mu_, lambda, maxIter );
    H = Update_For_H( M, W, H, L, T, mu_, lambda, maxIter );
    Delta_W = W-W0;
    Delta_H = H-H0;
    val = trace(Delta_W*Delta_W')+trace(Delta_H*Delta_H');
    disp('val:');
    disp(val);
    if val < eps_
        break;
    end
end
end

