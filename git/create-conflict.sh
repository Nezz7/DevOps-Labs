directory=git-demo-$(date +%s)
mkdir $directory
cd $directory
# INIT 
git init
# COMMIT A
echo "Line 1" > A.txt
git add A.txt
git commit -m "A: add A.txt"
# COMMIT B
echo "Line 2" > B.txt
git add B.txt
git commit -m "B: add B.txt"
# BRANCH feature-a
git checkout -b feature-a
# COMMIT D
echo "feature a" >> A.txt
git add .
git commit -m "D: modify A.txt"
# BRANCH Main
git checkout main
# COMMIT C
echo "main" > A.txt
git add .
git commit -m "C: modify A.txt"
git checkout feature-a
