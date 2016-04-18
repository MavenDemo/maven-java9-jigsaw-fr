#!/usr/bin/env bash

\rm -f target src/main/java/bytecode/*.class

clear

run() {
  echo -e "\\033[1m\$ $*\\033[0m"
  $*
}

commentaire() {
  echo ""
  echo -e "\\033[32m# $*\\033[0m"
}

enter() {
  echo -en "\\033[31m[...]\\033[0m"
  read
}

show() {
  #echo -en "\\033[92m"
  $* | pygmentize -l xml
  #echo -en "\\033[0m"
  enter
}

commentaire "JDK 9 classique: mvn package..."
j9
run mvn -V clean package 

enter

commentaire "JDK 9 jigsaw: mvn package..."
jig
run mvn -V clean package

enter

commentaire "JDK 9 jigsaw avec plugin maven-compiler-plugin 3.6-jigsaw-SNAPSHOT..."
run mvn -V -Pjigsaw clean compile
commentaire "ça ne paraît pas fondamentalement différent, pourtant..."

enter

run mvn -V -X -Pjigsaw compile
commentaire "cette fois-ci, on voit apparaître un module path avec des modules automatiques..."

enter

commentaire "et surtout voici l'encapsulation en action..."
run mvn -V -Pjigsaw package

