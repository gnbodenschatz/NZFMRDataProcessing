function [ ] = ScanCondenser( Scans )
%ImPAv Imports .lvm files, condenses them one .mat variable file and then
%processes them by performing post averaging. 
%   [ ] = ScanCondenser( Scans ), where scans is the number of scans and
%   the output is the 'Variables.mat' file.
Field(4096,Scans)=0;
AvgI(4096,Scans)=0;
AvgQ(4096,Scans)=0;
AvgIf(4096,Scans)=0;
AvgQf(4096,Scans)=0;
IndI(4096,Scans)=0;
IndQ(4096,Scans)=0;
IndIf(4096,Scans)=0;
IndQf(4096,Scans)=0;
DerI(4096,Scans)=0;
IntI(4096,Scans)=0;
DerQ(4096,Scans)=0;
IntQ(4096,Scans)=0;
startscan = 1;
    for i=startscan:Scans;
        scan=i
        filename = sprintf('data%d.lvm',i);
        delimiter = '\t';
        startRow = 25;
        formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';
        fileID = fopen(filename,'r');
        textscan(fileID, '%[^\n\r]', startRow-1, 'ReturnOnError', false);
        dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'ReturnOnError', false);
        fclose(fileID);
        Field(:,i-startscan+1)=dataArray{:,1};%Field(:,i) = field;
        AvgI(:,i-startscan+1)=dataArray{:,2};%AvgI(:,i) = avgI;
        AvgQ(:,i-startscan+1)=dataArray{:,3};%AvgQ(:,i) = avgQ;
        AvgIf(:,i-startscan+1) = dataArray{:, 4};%AvgIf(:,i) = avgIf;
        AvgQf(:,i-startscan+1) = dataArray{:, 5};%AvgQf(:,i) = avgQf;
        IndI(:,i-startscan+1) = dataArray{:, 6};%IndI(:,i) = indI;
        IndQ(:,i-startscan+1) = dataArray{:, 7};%IndQ(:,i) = indQ;
        IndIf(:,i-startscan+1) = dataArray{:, 8};%IndIf(:,i) = indIf;
        IndQf(:,i-startscan+1) = dataArray{:, 9};%IndQf(:,i) = indQf;
        DerI(:,i-startscan+1) = dataArray{:, 10};%DerI(:,i) = derI;
        IntI(:,i-startscan+1) = dataArray{:, 11};%IntI(:,i) = intI;
        DerQ(:,i-startscan+1) = dataArray{:, 12};%DerQ(:,i) = derQ;
        IntQ(:,i-startscan+1) = dataArray{:, 13};%IntQ(:,i) = intQ;
        clearvars filename delimiter startRow formatSpec fileID dataArray ans;  
    end
clearvars scan intQ intI indQf indQ indIf indI i field derQ derI avgQf...
    avgQ avgIf avgI;
    for i=startscan:(Scans-1)
        deleting=i;
        fname=sprintf('data%d.lvm',i);
        delete(fname);
    end
save Variables.mat AvgI AvgIf AvgQ AvgQf DerI DerQ Field IndI IndIf IndQ IndQf IntI IntQ;
clearvars i deleting Scans fname;
end