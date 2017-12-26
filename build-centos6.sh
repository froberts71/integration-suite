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
echo "scl enable python27 bash" >> docker_command.txt;
echo "python bazel_configure.py" >> docker_command.txt;
echo "bazel build -c opt --config=centos scripts/packages:binpkgs" >> docker_command.txt;
echo "bazel build -c opt --config=centos scripts/packages:tarpkgs" >> docker_command.txt;
echo "chown $USERID:$GROUPID bazel-bin/scripts/packages/*" >> docker_command.txt;
echo "mkdir /src/artifacts" >> docker_command.txt;
echo "chown -R $USERID:$GROUPID /src/artifacts" >> docker_command.txt;
echo "cp bazel-bin/scripts/packages/heron-install.sh /src/artifacts/" >> docker_command.txt;
echo "cp bazel-bin/scripts/packages/heron.tar.gz /src/artifacts/" >> docker_command.txt;
