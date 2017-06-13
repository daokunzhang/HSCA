function [ res ] = Update_For_W( M, W, H, L, T, mu_, lambda, maxIter )
k = size(W,1);
n = size(W,2);
W = W';
w = W(:);
HT = H*T;
G = W*(HT*HT')-M*HT'+mu_*(L*W)+lambda*W;
r = - G(:);
d = r;
eps_ = 1.0e-12;
for iter = 1:maxIter
    D = reshape(d,n,k);
    HD = D*(HT*HT')+mu_*(L*D)+lambda*D;
    Hd = HD(:);
    r2 = r'*r;
    alpha = r2/(d'*Hd);
    w = w + alpha*d;
    r = r - alpha*Hd;
    beta = (r'*r)/r2;
    d = r + beta*d;
    if r'*r<eps_
        break;
    end
end
res = reshape(w,n,k);
res = res';
end

