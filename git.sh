# Commands definition

divider() {
    echo "-------------"
}
 
red() {
    git config --local user.name red
    git config --local user.email red@gmail.com
    echo "Change user to RED"
}

blue() { 
    git config --local user.name blue
    git config --local user.email blue@gmail.com
    echo "Change user to BLUE"
}

commit() {
    if [ -z "$1" ]; then
        echo "Error: Commit message required."
        return 1
    fi
    
    rm -rf *
    cp -r ../commits/commit$1/* .
    git add .
    git commit --allow-empty --quiet -m $1
    echo "Commit '$1' on $(git branch --show-current)" 
    divider
}

checkout() {
    if [[ $1 == "-b" ]]; then
        echo "Create '$2' and checkout to it"
        git checkout -b  $2 --quiet
    else 
        echo "Checkout to '$1'"
        git checkout $1 --quiet
    fi 
}

merge() {
    if [ -z "$1" ]; then
        echo "Error: Branch name required."
        return 1
    fi
    
     if git show-ref --verify --quiet "refs/heads/$1"; then
        git merge --strategy=ours --no-edit $1
        echo "Merged $(git branch --show-current) to $1"
    else
        echo "The branch \"$1\" does not exist."
    fi
}

divider() {
    echo "-------------"
}
    

# Init
rm -rf git
mkdir git
cd git
git init

red
checkout -b branch0
commit 0

checkout -b branch1
commit 1

checkout -b branch2
commit 2

checkout branch1
commit 3

checkout branch0
commit 4

checkout -b branch5
commit 5

checkout -b branch6
commit 6

checkout branch0
commit 7

checkout branch5
commit 8

blue
checkout -b branch9
commit 9

red 
checkout -b branch10
commit 10

blue
checkout -b branch11
commit 11

commit 12

red 
checkout branch2
commit 13

checkout branch6
commit 14

commit 15

commit 16

checkout branch10
commit 17

checkout branch11
merge branch10
commit 18

checkout branch6
merge branch11
commit 19

checkout branch0
merge branch6
commit 20

checkout branch5
commit 21

checkout branch1 
commit 22

blue
checkout -b branch23
merge branch1
commit 23

commit 24

red
checkout branch5 
commit 25

blue
checkout -b branch26
commit 26

red 
checkout branch2
commit 27

checkout branch0
commit 28

checkout branch2
commit 29

commit 30

checkout branch5
merge branch2
commit 31

checkout branch0 
commit 32

blue
checkout branch23
commit 33

red
checkout branch5
commit 34

blue
checkout branch26
merge branch5
commit 35

commit 36

checkout branch23
merge branch26
commit 37

checkout branch9
merge branch23
commit 38

red
checkout branch0
merge branch9
commit 39

