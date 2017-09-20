export USER=build-server
cd /src
python bazel_configure.py
bazel build -c opt --config=ubuntu scripts/packages:binpkgs
chown 1000:1000 bazel-bin/scripts/packages/heron-api-install.sh
chown 1000:1000 bazel-bin/scripts/packages/heron-client-install.sh
chown 1000:1000 bazel-bin/scripts/packages/heron-tools-install.sh
mkdir /src/artifacts
chown -R 1000:1000 /src/artifacts
bazel-bin/scripts/packages/heron-api-install.sh /src/artifacts/
bazel-bin/scripts/packages/heron-client-install.sh /src/artifacts/
bazel-bin/scripts/packages/heron-tools-install.sh /src/artifacts/