#!/bin/sh

echo "Cleaning existing classes..."
rm -rf build
mkdir build

echo "Compiling source code and unit tests..."
javac -d build -classpath .:lib/junit-4.12.jar:lib/hamcrest-core-1.3.jar src/main/java/*.java src/test/java/*.java
if [ $? -ne 0 ] ; then echo BUILD FAILED!; exit 1; fi

echo "Running unit tests..."
java -cp build:lib/junit-4.12.jar:lib/hamcrest-core-1.3.jar org.junit.runner.JUnitCore src/test/java/EdgeConnectorTest
if [ $? -ne 0 ] ; then echo TESTS FAILED!; exit 1; fi

echo "Running application..."
java -classpath build:lib/junit-4.12.jar:lib/hamcrest-core-1.3.jar RunEdgeConvert
