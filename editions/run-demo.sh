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

commentaire "JDK 9 EA classique..."
j9
run java -version
run java -fullversion

enter

commentaire "JDK 9 EA Jigsaw..."
jig
run java -version
run java -fullversion

enter

clear

commentaire "JDK 9 classique: compile and run..."
j9
run javac -version src/main/java/bytecode/Display*.java 
run java -showversion -cp src/main/java bytecode.Display2
commentaire "Pour l'instant (build 113), le JDK 9 produit du bytecode de JRE 8 (52.0)"
commentaire "Remarquez la nouvelle API jdk.Version"

enter

commentaire "Opportunisme: run avec JRE 8"
j8
run java -cp src/main/java bytecode.Display
commentaire "Les banales concaténations de String ont changé de méthode."
commentaire "Les classes générées sont inutilisables avec un JRE 8."
commentaire "(il faut dire que ce n'était pas fait pour...)"

enter

commentaire "JDK 8: compile and run..."
\rm -f src/main/java/bytecode/*.class
run javac -version src/main/java/bytecode/Display.java 
run java -showversion -cp src/main/java bytecode.Display
