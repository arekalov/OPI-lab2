#Variables
REPO_URL="file://$(pwd)/svn/repo"
COMMITS="$(pwd)/svn/data"
CURRENT_USER="red"

#Functions definitions






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
