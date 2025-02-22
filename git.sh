# Commands definition

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
    
    git add .
    git commit --allow-empty -m $1
    echo "Commit $1 on $(git branch --show-current)" 
}

checkout() {
    if [[ $2 == "-b" ]]; then
        git checkout -b $1
        echo "Crate $1 and checkout to $1"
    else 
        git checkout $1
        echo "Checkout to $1"
    fi 
}

merge() {
    if [ -z "$1" ]; then
        echo "Error: Branch name required."
        return 1
    fi
    
     if git show-ref --verify --quiet "refs/heads/$1)"; then
        git merge --no-commit $1
        echo "Merged to $1"
    else
        echo "The branch \"$1\" does not exist."
    fi 
}
    

# Init
rm -rf git
mkdir git
cd git
git init

 
