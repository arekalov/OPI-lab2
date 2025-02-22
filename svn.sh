#Variables
REPO_URL="file://$(pwd)/svn/repo"
COMMITS="$(pwd)/svn/data"
CURRENT_USER="red"

#Functions definitions
divider() {
    echo "------------"
}

red() {
    CURRENT_USER=red
    echo "Change user to RED"
}

blue() {
    CURRENT_USER=blue
    echo "Change user to BLUE"
}

commit() {
    svn rm * --force 
    cp $COMMITS/$1/* .
    svn add * --force 
    svn commit -m "r$1" --username $CURRENT_USER
    echo "Commit $1"
    divider
}

branch_from_trunk() {
	svn copy $REPO_URL/trunk $REPO_URL/branches/"$1" -m "Add branch$1" --username $CURRENT_USER
    echo "Branch $1 from trunk created"
}

branch() {
    svn copy $REPO_URL/branches/"$1" $REPO_URL/branches/"$2" -m "Add branch$2" --username $CURRENT_USER
    switch $2
    echo "New branch $2 from $1 created"
}

switch() {
	svn switch $REPO_URL/branches/"$1"
    echo "Switched to $1"
}

switch_to_trunk() {
	svn switch $REPO_URL/trunk
    echo "switched to trunk"
}

merge() {
	svn merge --non-interactive $REPO_URL/branches/"$1" 
	svn resolved *
    echo "Merge from $1 to current branch"
}


#Init
rm -rf svn
mkdir svn
cd svn

svnadmin create repo
svn mkdir $REPO_URL/trunk $REPO_URL/branches -m "Init file structure" --username $CURRENT_USER

#Commits files generating
python3 ../file_generator.py $(pwd)/data

#Create working directory
svn checkout $REPO_URL/trunk working_copy
cd working_copy


#Commits
cp $COMMITS/0/* . 
svn commit -m "r0" --username $CURRENT_USER

branch_from_trunk branch1
commit 1

branch branch1 branch2
commit 2

switch branch1
commit 3

switch_to_trunk 
commit 4

branch_from_trunk branch5
commit 5

branch branch5 branch6
commit 6

switch_to_trunk
commit 7

switch branch5
commit 8

blue
branch branch5 branch9
commit 9

red 
branch branch9 branch10
commit 10

blue
branch branch10 branch11
commit 11

commit 12

red
switch branch2
commit 13

switch branch6
commit 14

commit 15

commit 16

switch branch10
commit 17

switch branch11
merge branch10
commit 18

switch branch6
merge branch11
commit 19

switch_to_trunk
merge branch6
commit 20

switch branch5
commit 21

switch branch1
commit 22

blue
branch branch1 branch23
merge branch1
commit 23

commit 24

red 
switch branch5
commit 25

blue
branch branch5 branch26
commit 26

red
switch branch2
commit 27

switch_to_trunk
commit 28

switch branch2
commit 29

commit 30

switch branch5
merge branch2
commit 31

switch_to_trunk
commit 32

blue
switch branch23
commit 33

red 
switch branch5
commit 34

blue
switch branch26
merge branch5
commit 35

commit 36

switch branch23
merge branch26
commit 37

switch branch9
merge branch23
commit 38

red
switch_to_trunk
merge branch9
commit 39

cd ..

