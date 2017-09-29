#!/bin/bash

set -e
set -o pipefail

echo "Start deploy to maven"

DEPLOY_URL="https://oss.sonatype.org/service/local/staging/deploy/maven2/"

echo "Deploying to ... $DEPLOY_URL"

VERSION_TAG=$gitParam

echo "Found Version Tag $VERSION_TAG"

echo "Starting deploy ..."

echo "Deploy Heron Api"

mvn gpg:sign-and-deploy-file -Durl=$DEPLOY_URL -DrepositoryId=ossrh -DpomFile=./jar_release_bundle/$VERSION_TAG/heron-api/heron-api-$VERSION_TAG.pom -Dfile=./jar_release_bundle/$VERSION_TAG/heron-api/heron-api-$VERSION_TAG.jar
mvn gpg:sign-and-deploy-file -Durl=$DEPLOY_URL -DrepositoryId=ossrh -DpomFile=./jar_release_bundle/$VERSION_TAG/heron-api/heron-api-$VERSION_TAG.pom -Dfile=./jar_release_bundle/$VERSION_TAG/heron-api/heron-api-$VERSION_TAG-sources.jar -Dclassifier=sources
mvn gpg:sign-and-deploy-file -Durl=$DEPLOY_URL -DrepositoryId=ossrh -DpomFile=./jar_release_bundle/$VERSION_TAG/heron-api/heron-api-$VERSION_TAG.pom -Dfile=./jar_release_bundle/$VERSION_TAG/heron-api/heron-api-$VERSION_TAG-javadoc.jar -Dclassifier=javadoc

echo "Deploy Heron Spi"

mvn gpg:sign-and-deploy-file -Durl=$DEPLOY_URL -DrepositoryId=ossrh -DpomFile=./jar_release_bundle/$VERSION_TAG/heron-spi/heron-spi-$VERSION_TAG.pom -Dfile=./jar_release_bundle/$VERSION_TAG/heron-spi/heron-spi-$VERSION_TAG.jar
mvn gpg:sign-and-deploy-file -Durl=$DEPLOY_URL -DrepositoryId=ossrh -DpomFile=./jar_release_bundle/$VERSION_TAG/heron-spi/heron-spi-$VERSION_TAG.pom -Dfile=./jar_release_bundle/$VERSION_TAG/heron-spi/heron-spi-$VERSION_TAG-sources.jar -Dclassifier=sources
mvn gpg:sign-and-deploy-file -Durl=$DEPLOY_URL -DrepositoryId=ossrh -DpomFile=./jar_release_bundle/$VERSION_TAG/heron-spi/heron-spi-$VERSION_TAG.pom -Dfile=./jar_release_bundle/$VERSION_TAG/heron-spi/heron-spi-$VERSION_TAG-javadoc.jar -Dclassifier=javadoc

echo "Deploy Heron Storm"

mvn gpg:sign-and-deploy-file -Durl=$DEPLOY_URL -DrepositoryId=ossrh -DpomFile=./jar_release_bundle/$VERSION_TAG/heron-storm/heron-storm-$VERSION_TAG.pom -Dfile=./jar_release_bundle/$VERSION_TAG/heron-storm/heron-storm-$VERSION_TAG.jar
mvn gpg:sign-and-deploy-file -Durl=$DEPLOY_URL -DrepositoryId=ossrh -DpomFile=./jar_release_bundle/$VERSION_TAG/heron-storm/heron-storm-$VERSION_TAG.pom -Dfile=./jar_release_bundle/$VERSION_TAG/heron-storm/heron-storm-$VERSION_TAG-sources.jar -Dclassifier=sources
mvn gpg:sign-and-deploy-file -Durl=$DEPLOY_URL -DrepositoryId=ossrh -DpomFile=./jar_release_bundle/$VERSION_TAG/heron-storm/heron-storm-$VERSION_TAG.pom -Dfile=./jar_release_bundle/$VERSION_TAG/heron-storm/heron-storm-$VERSION_TAG-javadoc.jar -Dclassifier=javadoc

echo "Finish deploy ..."

echo "Exit ..."