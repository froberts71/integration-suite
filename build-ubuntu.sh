USERID=$(id -u $USER)
GROUPID=$(id | awk 'BEGIN { FS = "[=(]" } ; { print $4 }')
GIT_TAG=$gitParam

echo "export USERID=$USERID" > docker_command.txt
echo "export GROUPID=$GROUPID" >> docker_command.txt;
echo "export HERON_BUILD_HOST=ci-server-01" >> docker_command.txt;
echo "export HERON_BUILD_USER=release-agent1" >> docker_command.txt;
echo "export HERON_BUILD_VERSION=${GIT_TAG}" >> docker_command.txt;
echo "export USER=build-server" >> docker_command.txt;
echo "cd /src" >> docker_command.txt;
echo "python bazel_configure.py" >> docker_command.txt;
echo "bazel build -c opt --config=ubuntu scripts/packages:binpkgs" >> docker_command.txt;
echo "bazel build -c opt --config=ubuntu scripts/packages:tarpkgs" >> docker_command.txt;
echo "chown $USERID:$GROUPID bazel-bin/scripts/packages/*" >> docker_command.txt;
echo "mkdir /src/artifactss" >> docker_command.txt;
echo "chown -R $USERID:$GROUPID /src/artifacts" >> docker_command.txt;
echo "cp bazel-bin/scripts/packages/heron-api-install.sh /src/artifacts/" >> docker_command.txt;
echo "cp bazel-bin/scripts/packages/heron-client-install.sh /src/artifacts/" >> docker_command.txt;
echo "cp bazel-bin/scripts/packages/heron-tools-install.sh /src/artifacts/" >> docker_command.txt;
echo "cp bazel-bin/scripts/packages/heron-api.tar.gz /src/artifacts/" >> docker_command.txt;
echo "cp bazel-bin/scripts/packages/heron-core.tar.gz /src/artifacts/" >> docker_command.txt;
echo "cp bazel-bin/scripts/packages/heron-client.tar.gz /src/artifacts/" >> docker_command.txt;
echo "cp bazel-bin/scripts/packages/heron-tools.tar.gz /src/artifacts/" >> docker_command.txt;
