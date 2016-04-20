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
  $* | pygmentize -l java
  #echo -en "\\033[0m"
  enter
}

commentaire "cette fois-ci, on va builder un code modulaire..."
show cat src/main/java/module-info.java

commentaire "avec maven-sompiler-plugin classique..."
jig
run mvn -V clean package
commentaire "les modules ne sont pas gérés..."

enter

commentaire "avec maven-compiler-plugin 3.6-jigsaw-SNAPSHOT..."
run mvn -V -Pjigsaw clean compile
commentaire "cette fois-ci, les modules sont gérés..."

enter

run mvn -V -X -Pjigsaw compile
commentaire "on voit apparaître un module path avec des modules automatiques..."

enter

commentaire "et on peut tester depuis le classpath des modules..."
enter
run mvn -V -X -Pjigsaw test
commentaire "ça marche, mais trop: les modules ne sont pas vraiment testés..."
commentaire "reste à faire : lancer les tests unitaires avec les modules (nécessite -Xpatch & ...)"

enter

commentaire "pour analyser les dépendances, jdeps est là, avec un maven-jdeps-plugin pour s'y mettre..."
run mvn jdeps:jdkinternals
