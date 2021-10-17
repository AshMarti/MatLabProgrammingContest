                    THE BASIC IDEA OF SUDOKUSOLVER.MAT:

This program is designed to solve traditional sudoku puzzles.
It uses pre-created matrix files with a variable titled 'puzzle' and solves
the puzzle that has been created in this file. These puzzles are created by 
creating a 9 x 9 matrix with each row represnting a row of the puzzle and a 
column representing a column of the puzzle. Each puzzle consists of numbers
1 through 9 filled in the correct row and column as the original puzzle,
and zeros in the spaces determined to be empty. The program will solve for 
the numbers that should fill in these spaces. 
Below is the matrix of 'sudoku1.mat' with zeros showing empty spaces.

puzzle =

     5     0     0     0     1     0     0     0     4
     2     7     4     0     0     0     6     0     0
     0     8     0     9     0     4     0     0     0
     8     1     0     4     6     0     3     0     2
     0     0     2     0     3     0     1     0     0
     7     0     6     0     9     1     0     5     8
     0     0     0     5     0     3     0     1     0
     0     0     5     0     0     0     9     2     7
     1     0     0     0     2     0     0     0     3

This would create a puzzle that looks like this on a sudoku board.

-------------------------------
| 5       |    1    |       4 |
| 2  7  4 |         | 6       |
|    8    | 9     4 |         |
-------------------------------
| 8  1    | 4  6    | 3     2 |
|       2 |    3    | 1       |
| 7     6 |    9  1 |    5  8 |
-------------------------------
|         | 5     3 |    1    |
|       5 |         | 9  2  7 |
| 1       |    2    |       3 |
-------------------------------

                     HOW SUDOKU PUZZLES ARE SOLVED:

Sudoku puzzles are solved by determining which number between 1 to 9 
belongs in each empty space on the board. Each row of the puzzle must have 
the numbers 1 to 9 occuring only once. Similarly, each column of the puzzle
must also contain the numbers 1 to 9, with each number occuring only once 
per column. This is also true for the 9 blocks of the puzzle (which can be 
seen on the board but not in the matrix); each block must have the numbers 
1 to 9, but each number may only appear once.

                       HOW TO INITIATE THE PROGRAM:

At the onset of the program, you will be prompted to enter the name of a 
sudoku file to upload. Included with the supporting files should be four 
solveable sudoku puzzles with the titles 'sudoku1.mat', 'sudoku2.mat',
'sudoku3.mat', and 'sudoku4.mat'. Please ensure that you type the file name
correctly, with no spaces or spelling mistakes. You also do not need to
include any apostrophes, however the file type ('.mat') is needed. 
For example: 

Please enter the name of the puzzle file you wish to solve: sudoku1.mat

This will proceed to open the file titled 'sudoku1.mat'. 
If the program is desired to be tested with a different puzzle than the 
four that are included, the user can create a new file with a single matrix
titled 'puzzle' that is a 9 x 9 matrix with zeros placed in any empty 
spaces. Assuming that the puzzle matrix is created properly and that the 
entered puzzle is solvable, that puzzle can be solved by entering it's file
name into the program when prompted by the input.
Please see the above example matrix to see how any new puzzle matrices 
should be formatted. 

                   HOW THE PROGRAM SOLVES THE PUZZLE:

After the file to be opened is determined, the program will display the 
entered puzzle in a board as shown above. (When creating a new puzzle 
matrix, please check to make sure this board matches that which you used to
create the puzzle matrix.) The program will then begin to solve for the 
empty spaces within the board (or the zeros of the matrix).

First, each row of the puzzle is analyzed, and all zeros of that row are
replaced with a string vector of potential correct answers for that space 
on the board. It will not change any spaces where a single number of 1 to 9
is located, and these pre-existing numbers will not be included in the list
of potential numbers in the spaces of that row. For example:

Original puzzle row vector:
5       0         0         0       1      0          0        0       4

New puzzle row vector with potential numbers for each space in the row:
"5"  "236789"  "236789"  "236789"  "1"  "236789"  "236789"  "236789"  "4"

The program then enters a while loop, which will run until each space in 
the board only has a single number in it. Once all but one of the numbers 
within a space have been deleted, this remaining number is seen as the 
correct number for that space, and is not deleted but instead can be used 
to delete that number from other spaces in the same row, column, and block.
The first dimension the program will begin deleting potential number in is 
the column. Using the lists of potential numbers determined from each row, 
the program will check to see if any spaces within a column contain a 
single number, and then delete that number from every other space within 
the column. This will repeat with numbers 1 to 9 for each column, and then 
repeat for each column. 
The program will then repeat this process with each block of numbers. 
First, it will reconstruct the portion of the matrix that belongs in that 
block into a 1 by 9 matrix. The program then repeats a similar checking 
process as described above, deleting any numbers that appear as singular, 
"correct" answers from the lists of potential numbers. Once finished, the 
program passes the block back into the original puzzle, maintaining any 
changes it made. This process is repeated for each of the nine blocks 
present in the puzzle. 
Next, the program runs the above process through each row of code again, 
deleting any numbers that appear as single numbers from the lists of 
potential numbers within that row. 
The program then repeats the entire process again, starting with columns, 
and continuing until only a single number per block remains.

This simple process was able to solve the easiest of sudoku puzzles, 
however, difficulty was met when a hard sudoku puzzle was entered.

The puzzle was then modified to identify when only a single space within a 
dimension of the puzzle could be a specific number, and then delete all 
other possible numbers from that dimension. For example:

"236789"  "4"  "123567"  "579"  "2"  "6"  "246789"  "5"  "456789"

The third column in this row is the only space in this row that can have a 
value of 1, so that space takes on the single value of 1.

"236789"  "4"    "1"     "579"  "2"  "6"  "246789"  "5"  "456789"

However, the program still was unable to solve the some difficult process,
so another system of determining correct values was added.
Now at each of the steps, the puzzle also checks to see if any two spaces 
within that dimension of the puzzle have only two potential numbers that 
are the same. This would mean that these two numbers could only be in those
two spaces; one in one space and the other in the other space. For example:     

"28"  "28"  "358"	"1"	 "2358"	 "6"  "4"  "7"  "9"

Since two of the sapces are only two numbers in length and identical to 
each other, the numbers they contain (in this example, 2 and 8) will be 
deleted from every other space in the matrix.

"28"  "28"   "35"	"1"	  "35"	  "6"  "4"  "7"  "9"

This process can also work for a dimension in which three spaces are two 
numbers in length but only two of the spaces are identical. In this
circumstance, the program will compare the first and second spaces, then 
the first and third spaces, and then the second and third spaces to 
determine which two are identical and then delete those two numbers from 
all the other spaces within that dimension. For example: 

"49"  "49"  "5"  "478"  "1"  "78"  "67"  "267"  "3"

The identical numbers are 4 and 9, even though a third space with only two
values exists. These are then deleted from all other numbers.

"49"  "49"  "5"  "78"  "1"  "78"  "67"  "267"  "3"

During the next while loop, if the 4 and 9 varibales are resolved, the 
program will compare the two identical 7 and 8 spaces and delete these two 
numbers from all other spaces.

However, some entered puzzles still are not sovable by these rules, so the 
program has a counter to track how many while loops it executes. If the 
counter reaches 300 tries of the while loop without reaching a point where
all spaces in the matrix only contain one number, it is assumed that no 
more correct values are being determined and the puzzle displays a message 
indicating that the puzzle could not be solved.

However, if the puzzle is able to be solved within 300 trials, the program
will print the final number matrix in a board similar to the one that was 
first diplayed. Here is the final output for 'sudoku1.mat':

--------------------------------
| 5  9  3  | 6  1  2 | 7  8  4 |
| 2  7  4  | 3  5  8 | 6  9  1 |
| 6  8  1  | 9  7  4 | 2  3  5 |
--------------------------------
| 8  1  9  | 4  6  5 | 3  7  2 |
| 4  5  2  | 8  3  7 | 1  6  9 |
| 7  3  6  | 2  9  1 | 4  5  8 |
--------------------------------
| 9  2  7  | 5  4  3 | 8  1  6 |
| 3  4  5  | 1  8  6 | 9  2  7 |
| 1  6  8  | 7  2  9 | 5  4  3 |
--------------------------------
