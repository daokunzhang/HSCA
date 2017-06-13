clear all
data = 'cora';  % 'cora' or 'citeseer' or 'wiki' or 'PubMed'
%% Parameters
k=120;  % dimensions of matrix W and H
lambda = 0.2;   % regularization parameter
textRank = 200; % dimension of text feature, used when preprocessing
mu_ = 0.1; %for cora, citeseer and PubMed, for wiki, mu_ = 0.04
%% Reduce the dimension of text feature from TFIDF matrix
display ('Preprocessing text feature...');
if strcmp(data,'PubMed')==0&&strcmp(data,'wiki')==0   % compute TFIDF matrix for cora and citeseer datasets
    load([data,'/feature.txt']);
    numOfNode = size(feature,1);
    for i=1:size(feature,2)
        if (nnz(feature(:,i)) > 0)
            feature(:,i) = feature(:,i)*log(numOfNode/nnz(feature(:,i)));
        end
    end
    [U,S,V] = svds(feature, textRank);
    text_feature = U * S;
    clear U S V
else
    load([data,'/tfidf.txt']);
    tfidf(:,1) = tfidf(:,1) + 1;
    tfidf(:,2) = tfidf(:,2) + 1;
    tfidf = sparse(tfidf(:,1),tfidf(:,2),tfidf(:,3),max(tfidf(:,1)),max(tfidf(:,2)));
    [U,S,V] = svds(tfidf, textRank);
    text_feature = U * S;
    clear U S V
end
numOfNode = size(text_feature,1);
%% Build matrix M=(A+A*A)/2 
load([data,'/graph.txt']);
display ('Computing matrix M...');
graph(:,1) = graph(:,1) + ones(size(graph(:,1)));
graph(:,2) = graph(:,2) + ones(size(graph(:,2)));
graph = [graph;graph(:,2) graph(:,1)];
graph = sparse(graph(:,1),graph(:,2),ones(size(graph(:,1))),numOfNode,numOfNode);
[rows,cols,vals] = find(graph);
graph = sparse(rows,cols,ones(length(rows),1),numOfNode,numOfNode);

A = graph;
ColFeatures = text_feature;
for i=1:size(graph,1)
    if (norm(graph(i,:))>0)
        graph(i,:) = graph(i,:)/nnz(graph(i,:)) ;
    end
end
g2 = graph * graph;
graph = graph + g2;
graph = graph ./ 2 ;

for i=1:size(ColFeatures,2)
    if (norm(ColFeatures(:,i))>0)
        ColFeatures(:,i) = ColFeatures(:,i)/norm(ColFeatures(:,i));
    end
end

[ W, H ] = HSCA_Solver( sparse(graph), sparse(ColFeatures'), sparse(A), k, mu_, lambda );
features = [W', ColFeatures*H'];
