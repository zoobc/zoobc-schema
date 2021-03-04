#!/usr/bin/env bash
protoc -I${PWD} ${PWD}/model/*.proto --go_out=plugins=grpc:$GOPATH/src
protoc -I${PWD} -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis --grpc-gateway_out=logtostderr=true:${GOPATH}/src ${PWD}/service/*.proto --swagger_out ${PWD} --go_out=plugins=grpc:$GOPATH/src && swagger mixin service/*.swagger.json > documentation.swagger.json

# this script expects a copyright.txt file containing the license in the format you want it to be added to the source code, in the same directory where this script is (the project root)
# NOTE: copyright.txt must have an empty new line at the bottom, otherwise it will cut the first line of every file it updates :)
# please change the -name parameter from *.go to whatever is the file extension to search in current and all sub directories
# and update the list of excluded dirs too, in case there are
OLDPATH="${PWD}"
MODELPATH="${PWD}/../model"
SERVICEPATH="${PWD}/../service"
COPYRIGHT_FILE="copyright_template_for_compiled_files.txt"
cd $MODELPATH
for i in $(find . -name '*.go');
do
  if ! grep -q Copyright $i
  then
    cat "${OLDPATH}/${COPYRIGHT_FILE}" $i >$i.new && mv $i.new $i
  fi
done
cd $SERVICEPATH
for i in $(find . -name '*.go');
do
  if ! grep -q Copyright $i
  then
    cat "${OLDPATH}/${COPYRIGHT_FILE}" $i >$i.new && mv $i.new $i
  fi
done
cd $OLDPATH
