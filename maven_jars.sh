#!/bin/bash

set -e
set -o pipefail

echo "Starting Heron Maven Jars Process"

echo "Make jar components"
bazel build -c opt --config=ubuntu heron/api/src/java:all
bazel build -c opt --config=ubuntu heron/spi/src/java:all
bazel build -c opt --config=ubuntu storm-compatibility/src/java:all

echo "Get Version Tag"

VERSION_TAG=$(VERSION_TEMPLATE)

echo "Found Version Tag $VERSION_TAG"

mkdir -p jar_release_bundle/$VERSION_TAG
rm -rf jar_release_bundle/$VERSION_TAG/*

BASE_DIR=`pwd`

cd ./release/

echo "Run Maven template for poms ... "

git clean -f -x .
sh ./maven/maven-pom-version.sh $VERSION_TAG

cd $BASE_DIR

echo "Build directories for jars ... "

mkdir jar_release_bundle/$VERSION_TAG/heron-api
mkdir jar_release_bundle/$VERSION_TAG/heron-spi
mkdir jar_release_bundle/$VERSION_TAG/heron-storm

echo "Copy heron-api artifacts ... "
cp ./release/heron-api-$VERSION_TAG.pom ./jar_release_bundle/$VERSION_TAG/heron-api/
cp ./bazel-bin/heron/api/src/java/api-shaded.jar ./jar_release_bundle/$VERSION_TAG/heron-api/heron-api-$VERSION_TAG.jar
cp ./bazel-bin/heron/api/src/java/heron-api-javadoc.zip ./jar_release_bundle/$VERSION_TAG/heron-api/heron-api-$VERSION_TAG-javadoc.jar
cp ./bazel-bin/heron/api/src/java/libapi-java-src.jar ./jar_release_bundle/$VERSION_TAG/heron-api/heron-api-$VERSION_TAG-sources.jar

echo "Copy heron-spi artifacts ... "
cp ./release/heron-spi-$VERSION_TAG.pom ./jar_release_bundle/$VERSION_TAG/heron-spi/
cp ./bazel-bin/heron/spi/src/java/spi-unshaded_deploy.jar ./jar_release_bundle/$VERSION_TAG/heron-spi/heron-spi-$VERSION_TAG.jar
cp ./bazel-bin/heron/spi/src/java/heron-spi-javadoc.zip ./jar_release_bundle/$VERSION_TAG/heron-spi/heron-spi-$VERSION_TAG-javadoc.jar
cp ./bazel-bin/heron/spi/src/java/libheron-spi-src.jar ./jar_release_bundle/$VERSION_TAG/heron-spi/heron-spi-$VERSION_TAG-sources.jar

echo "Copy heron-storm artifacts ... "
cp ./release/heron-storm-$VERSION_TAG.pom ./jar_release_bundle/$VERSION_TAG/heron-storm/
cp ./bazel-bin/storm-compatibility/src/java/heron-storm.jar ./jar_release_bundle/$VERSION_TAG/heron-storm/heron-storm-$VERSION_TAG.jar
cp ./bazel-bin/storm-compatibility/src/java/heron-storm-javadoc.zip ./jar_release_bundle/$VERSION_TAG/heron-storm/heron-storm-$VERSION_TAG-javadoc.jar
cp ./bazel-bin/storm-compatibility/src/java/libstorm-compatibility-java-src.jar ./jar_release_bundle/$VERSION_TAG/heron-storm/heron-storm-$VERSION_TAG-sources.jar


echo "Sign and bundle heron-api artifacts ... "
cd ./jar_release_bundle/$VERSION_TAG/heron-api
gpg -ab heron-api-$VERSION_TAG-javadoc.jar
gpg -ab heron-api-$VERSION_TAG-sources.jar
gpg -ab heron-api-$VERSION_TAG.jar
gpg -ab heron-api-$VERSION_TAG.pom
jar -cvf bundle.jar ./
cd $BASE_DIR

echo "Sign and bundle heron-spi artifacts ... "
cd ./jar_release_bundle/$VERSION_TAG/heron-spi
gpg -ab heron-spi-$VERSION_TAG-javadoc.jar
gpg -ab heron-spi-$VERSION_TAG-sources.jar
gpg -ab heron-spi-$VERSION_TAG.jar
gpg -ab heron-spi-$VERSION_TAG.pom
jar -cvf bundle.jar ./
cd $BASE_DIR

echo "Sign and bundle heron-storm artifacts ... "
cd ./jar_release_bundle/$VERSION_TAG/heron-storm
gpg -ab heron-storm-$VERSION_TAG-javadoc.jar
gpg -ab heron-storm-$VERSION_TAG-sources.jar
gpg -ab heron-storm-$VERSION_TAG.jar
gpg -ab heron-storm-$VERSION_TAG.pom
jar -cvf bundle.jar ./
cd $BASE_DIR

echo "Finished Building jars ... "

tree ./jar_release_bundle/$VERSION_TAG

echo "Exit"
