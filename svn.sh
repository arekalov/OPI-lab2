# SVN Commands definition

divider() {
    echo "-------------"
}

red() {
    # Настройка пользователя RED
    svn propset svn:author red . -m "Setting user to RED"
    echo "Change user to RED"
}

blue() {
    # Настройка пользователя BLUE
    svn propset svn:author blue . -m "Setting user to BLUE"
    echo "Change user to BLUE"
}

commit() {
    if [ -z "$1" ]; then
        echo "Error: Commit message required."
        return 1
    fi

    # Добавление файлов и коммит
    svn add . && svn commit -m "$1"
    echo "Commit '$1' on $(basename $(svn info | awk -F': ' '/^URL/ {print $2}'))"
    divider
}

create_branch() {
    if [ -z "$1" ]; then
        echo "Error: Branch name required."
        return 1
    fi

    # Создание ветки
    svn copy ^/trunk ^/branches/"$1" -m "Creating branch $1"
    svn switch ^/branches/"$1"
    echo "Create '$1' and checkout to it"
}

merge() {
    if [ -z "$1" ]; then
        echo "Error: Branch name required."
        return 1
    fi

    # Проверка существования ветки
    if svn info ^/branches/"$1" >/dev/null 2>&1; then
        # Слияние веток
        svn merge ^/branches/"$1" ^/trunk -m "Merge branch $1 to trunk"
        echo "Merged $(basename $(svn info | awk -F': ' '/^URL/ {print $2}')) to $1"
    else
        echo "The branch \"$1\" does not exist."
    fi
}

# Init
svnadmin create svn_repo
svn mkdir file://$(pwd)/svn_repo/trunk -m "Creating trunk"
svn mkdir file://$(pwd)/svn_repo/branches -m "Creating branches"
svn checkout file://$(pwd)/svn_repo/trunk svn_working_copy
cd svn_working_copy

red
create_branch branch0
commit 0

create_branch branch1
commit 1

create_branch branch2
commit 2

svn switch ^/branches/branch1
commit 3

svn switch ^/branches/branch0
commit 4

create_branch branch5
commit 5

create_branch branch6
commit 6

svn switch ^/branches/branch0
commit 7

svn switch ^/branches/branch5
commit 8

blue
create_branch branch9
commit 9

red 
create_branch branch10
commit 10

blue
create_branch branch11
commit 11

commit 12

red 
svn switch ^/branches/branch2
commit 13

svn switch ^/branches/branch6
commit 14

commit 15

commit 16

svn switch ^/branches/branch10
commit 17

svn switch ^/branches/branch11
merge branch10
commit 18

svn switch ^/branches/branch6
merge branch11
commit 19

svn switch ^/branches/branch0
merge branch6
commit 20

svn switch ^/branches/branch5
commit 21

svn switch ^/branches/branch1
commit 22

blue
create_branch branch23
merge branch1
commit 23

commit 24

red
svn switch ^/branches/branch5
commit 25

blue
create_branch branch26
commit 26

red 
svn switch ^/branches/branch2
commit 27

svn switch ^/branches/branch0
commit 28

svn switch ^/branches/branch2
commit 29

commit 30

svn switch ^/branches/branch5
merge branch2
commit 31

svn switch ^/branches/branch0
commit 32

blue
svn switch ^/branches/branch23
commit 33

red
svn switch ^/branches/branch5
commit 34

blue
create_branch branch26
merge branch5
commit 35

commit 36

svn switch ^/branches/branch23
merge branch26
commit 37

svn switch ^/branches/branch9
merge branch23
commit 38

red
svn switch ^/branches/branch0
merge branch9
commit 39

