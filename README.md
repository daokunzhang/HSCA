# Code for ICDM-2016 paper "Homophily, Structure, and Content Augmented Network Representation Learning"

The main program is start.m.

# Dataset Description

Cora contains 2, 708 machine learning papers from seven classes and 5, 429 links between them. The links are citation relationships between the documents. Each document is described by a binary vector of 1, 433 dimensions indicating the presence of the corresponding word.

Citeseer contains 3, 312 publications from six classes and 4, 732 links between them. Similar to Cora, the links are citation relationships between the documents and each paper is described by a binary vector of 3, 703 dimensions.

Wiki contains 2, 405 documents from 19 classes and 17, 981 links between them. Each document is described by a 4, 973-dimensional TF-IDF vector.

PubMed contains 19, 717 papers from 3 classes and 44, 338 links between them. Each paper is describled by a 500-dimensional TF-IDF feature vector.

graph.txt: 
Each line contains two paper Ids which indicates the citation relationship between them. ID begins from 0.

group.txt: 
Each line contains two numbers: Paper Id and Group Id. For Cora and Citeseer, group Id begins from 0; For Wiki, group Id begins from 1.

feature.txt for Cora and Citeseer: 
This is the Paper-Word relationship matrix. Each line contains a binary vector of 1, 433 dimensions indicating the presence of the corresponding word.

tfidf.txt for Wiki and PubMed: 
This is the TFIDF matrix of Wiki and PubMed dataset. Each line contains a document/paper Id, feature Id and the corresponding feature value.

The evaulation for learned representations with multi-class node classification is carried out by utilizing the corresonding part of the project of the paper IJCAI 2015, "Network Representation Learning with Rich Text information". The code for the IJCAI 2015 paper is given at https://github.com/albertyang33/TADW.