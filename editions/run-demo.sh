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
run javac -version src/main/java/bytecode/Display.java 
run java -cp src/main/java bytecode.Display
commentaire "tiens, pour l'instant le JDK 9 produit du bytecode de JRE 8"

enter

commentaire "run avec JRE 8"
j8
run java -cp src/main/java bytecode.Display

commentaire "JDK 8: compile and run..."
\rm -f src/main/java/bytecode/*.class
run javac -version src/main/java/bytecode/Display.java 
run java -cp src/main/java bytecode.Display
commentaire "Vous vous rappelez du source Java 7 qui compilé par le JDK 8 intégrait des APIs Java 8?"
commentaire "Le JDK 9 fait cela avec les concaténations de String..."
