clc, clear
name=input('Please enter the name of the puzzle file you wish to solve: ','s');
fprintf('\n')
load(name)

%Removes all zeros and replaces them with empty spaces, then displays the puzzle
displaypuzzle=string(puzzle);
for rows = 1:9
    empty = find(displaypuzzle(rows,:)=="0");
    displaypuzzle(rows,empty)="";
end
fprintf('ENTERED PUZZLE: \n-------------------------------\n')
fprintf('|%2s%3s%3s |%2s%3s%3s |%2s%3s%3s |\n|%2s%3s%3s |%2s%3s%3s |%2s%3s%3s |\n|%2s%3s%3s |%2s%3s%3s |%2s%3s%3s |\n-------------------------------\n',displaypuzzle')

puzzle=string(puzzle);

%Assigns potential numbers 1-9 for each empty space for each row
for row = 1:9
    empty = find(puzzle(row,:)=="0");
    puzzle(row,empty)="";
    for number = string(1:9)
        if all(puzzle(row,:)~=number)
            if puzzle(row,empty)==""
                puzzle(row,empty)=number;
            else
                puzzle(row,empty)=puzzle(row,empty)+number;
            end
        end
    end
end

%Assigns a counter to prevent infinite while loops
count=0;
while any(any(strlength(puzzle(:,:))>1))==1 && count<300
    %Begins deleting numbers from the potential lists in each column
    for col=1:9
        %Condition 1: deletes numbers if a single space contains that number
        numbersize=zeros(9,9);
        for number=string(1:9)
            if any(puzzle(:,col)==number)
                for col2=1:9
                    for row =1:9
                        numbersize(row,col2)=(strlength(puzzle(row,col2))>1);
                    end
                end
                undeter=find(numbersize(:,col)==1);
                undeter=undeter';
                puzzle(undeter,col)=erase(puzzle(undeter,col),number);
            end
        end
        
        %Condition 2: makes a space equal to that number if it is the only
        %space with that potential value
        for number=string(1:9)
            repnums=zeros(9,1);
            for rowofcol=1:9
                repnums(rowofcol,col)=contains(puzzle(rowofcol,col),number);
            end
            x=find(repnums(:,col)==1);
            if length(x)==1
                puzzle(x,col)=number;
            end
        end
        
        %Condition 3: if any two numbers are two numbers long and are
        %identical to each other, those two numbers are deleted from every
        %other space in that dimension
        doublenums=zeros(9,1);
        for rowofcol=1:9
            doublenums(rowofcol,col)=strlength(puzzle(rowofcol,col))==2;
        end
        y=find(doublenums(:,col)==1);
        if length(y)==2 && puzzle(y(1),col)==puzzle(y(2),col)
            rowstoerase=string([1 2 3 4 5 6 7 8 9]);
            rowstoerase=erase(rowstoerase,string(y));
            rowstoerase=double(rowstoerase);
            while any(isnan(rowstoerase))
                lines=find(isnan(rowstoerase));
                rowstoerase(lines(2))=[];
                rowstoerase(lines(1))=[];
            end
            z=split(puzzle(y(1),col),'');
            puzzle(rowstoerase,col)=erase(puzzle(rowstoerase,col),z(2));
            puzzle(rowstoerase,col)=erase(puzzle(rowstoerase,col),z(3));
        end
    end
    
    %Goes through each block by first turning the block into a column vector
    for w=3:3:9 %row
        for l=3:3:9 %column
            block=puzzle((w-2):w,(l-2):l);
            
            %Condition 1: deletes numbers if a single space contains that number
            for number=string(1:9)
                undeterblock=zeros(3,3);
                for col=1:3
                    for row =1:3
                        undeterblock(row,col)=(strlength(block(row,col))>1);
                    end
                end
                undeterblockrow1=find(undeterblock(1,:)==1);
                undeterblockrow2=find(undeterblock(2,:)==1);
                undeterblockrow3=find(undeterblock(3,:)==1);
                if any(any(block==number))
                    block(1,undeterblockrow1)=erase(block(1,undeterblockrow1),number);
                    block(2,undeterblockrow2)=erase(block(2,undeterblockrow2),number);
                    block(3,undeterblockrow3)=erase(block(3,undeterblockrow3),number);
                end
            end
            puzzle((w-2):w,(l-2):l)=block;
            
            %Condition 2: makes a space equal to that number if it is the only
            %space with that potential value
            numsinblock=[block(1) block(2) block(3) block(4) block(5) block(6) block(7) block(8) block(9)]';
            for number=string(1:9)
                repnums=zeros(9,1);
                for rowofcol=1:9
                    repnums(rowofcol,:)=contains(numsinblock(rowofcol,:),number);
                end
                x=find(repnums(:,:)==1);
                if length(x)==1
                    block(x)=number;
                end
            end
            puzzle((w-2):w,(l-2):l)=block;
            
            %Condition 3: if any two numbers are two numbers long and are
            %identical to each other, those two numbers are deleted from every
            %other space in that dimension
            doublenums2=zeros(9,1);
            for rowsofcol=1:9
                doublenums2(rowsofcol,:)=strlength(numsinblock(rowsofcol,:))==2;
            end
            y=find(doublenums2(:,:)==1);
            if length(y)==2 && numsinblock(y(1),:)==numsinblock(y(2),:)
                rowstoerase=string([1 2 3 4 5 6 7 8 9]);
                rowstoerase=erase(rowstoerase,string(y));
                rowstoerase=double(rowstoerase);
                while any(isnan(rowstoerase))
                    lines=find(isnan(rowstoerase)==1);
                    rowstoerase(lines(2))=[];
                    rowstoerase(lines(1))=[];
                end
                z=split(numsinblock(y(1),:),'');
                numsinblock(rowstoerase,:)=erase(numsinblock(rowstoerase,:),z(2));
                numsinblock(rowstoerase,:)=erase(numsinblock(rowstoerase,:),z(3));
            end
            if length(y)==3 && numsinblock(y(1),:)==numsinblock(y(3),:)
                rowstoerase=string([1 2 3 4 5 6 7 8 9]);
                m=string([y(1),y(3)]);
                rowstoerase=erase(rowstoerase,string(m));
                rowstoerase=double(rowstoerase);
                while any(isnan(rowstoerase))
                    lines=find(isnan(rowstoerase)==1);
                    rowstoerase(lines(2))=[];
                    rowstoerase(lines(1))=[];
                end
                z=split(numsinblock(y(1),:),'');
                numsinblock(rowstoerase,:)=erase(numsinblock(rowstoerase,:),z(2));
                numsinblock(rowstoerase,:)=erase(numsinblock(rowstoerase,:),z(3));
            end
            if length(y)==3 && numsinblock(y(2),:)==numsinblock(y(3),:)
                rowstoerase=string([1 2 3 4 5 6 7 8 9]);
                m=string([y(2) y(3)]);
                rowstoerase=erase(rowstoerase,string(m));
                rowstoerase=double(rowstoerase);
                while any(isnan(rowstoerase))
                    lines=find(isnan(rowstoerase)==1);
                    rowstoerase(lines(2))=[];
                    rowstoerase(lines(1))=[];
                end
                z=split(numsinblock(y(2),:),'');
                numsinblock(rowstoerase,:)=erase(numsinblock(rowstoerase,:),z(2));
                numsinblock(rowstoerase,:)=erase(numsinblock(rowstoerase,:),z(3));
            end
            block1=reshape(numsinblock,3,3);
            puzzle((w-2):w,(l-2):l)=block1;
        end
    end
    
    %Goes through each row and deletes non-potential values
    for row=1:9
        numbersize=zeros(9,9);
        
        %Condition 1: deletes numbers if a single space contains that number
        for number=string(1:9)
            for row2=1:9
                for col2 =1:9
                    numbersize(row2,col2)=(strlength(puzzle(row2,col2))>1);
                end
            end
            undeter=find(numbersize(row,:)==1);
            if any(puzzle(row,:)==number)
                puzzle(row,undeter)=erase(puzzle(row,undeter),number);
            end
        end
        
        %Condition 2: makes a space equal to that number if it is the only
        %space with that potential value
        for number=string(1:9)
            repnums=zeros(1,9);
            for colofrow=1:9
                repnums(row,colofrow)=contains(puzzle(row,colofrow),number);
            end
            x=find(repnums(row,:)==1);
            if length(x)==1
                puzzle(row,x)=number;
            end
        end
        
        %Condition 3: if any two numbers are two numbers long and are
        %identical to each other, those two numbers are deleted from every
        %other space in that dimension
        doublenums=zeros(1,9);
        for colofrow=1:9
            doublenums(row,colofrow)=strlength(puzzle(row,colofrow))==2;
        end
        y=find(doublenums(row,:)==1);
        if length(y)==2 && puzzle(row,y(1))==puzzle(row,y(2))
            colstoerase=string([1 2 3 4 5 6 7 8 9]);
            colstoerase=erase(colstoerase,string(y));
            colstoerase=double(colstoerase);
            while any(isnan(colstoerase))
                columns=find(isnan(colstoerase));
                colstoerase(columns(2))=[];
                colstoerase(columns(1))=[];
            end
            z=split(puzzle(row,y(1)),'');
            puzzle(row,colstoerase)=erase(puzzle(row,colstoerase),z(2));
            puzzle(row,colstoerase)=erase(puzzle(row,colstoerase),z(3));
        end
        
    end
    
    %Adds to the counter
    count=count+1;
end

%If count reaches 300, the while loop will stop executing. The puzzle is
%assumed unsolvable.
if count>=300
    fprintf('The puzzle could not be solved. \n')
else
    %Reverts the puzzle back into a double matrix and displays the solved
    %values in the sudoku format.
    puzzle=double(puzzle);
    
    fprintf('\n')
    fprintf('SOLVED PUZZLE: \n--------------------------------\n')
    fprintf('| %i  %i  %i  | %i  %i  %i | %i  %i  %i |\n| %i  %i  %i  | %i  %i  %i | %i  %i  %i |\n| %i  %i  %i  | %i  %i  %i | %i  %i  %i |\n--------------------------------\n',puzzle')
end
