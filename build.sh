#/bin/sh

TAG=`date +%Y%m%d%H%M%S`
PWD=`pwd`


exitCommand() {
	exit
}

runCommand() {
	echo $CMD
	$CMD
	if [ $? -ne 0 ]; then
		echo -e "[FAIL] $CMD"
		exitCommand
	fi 
}

buildProject() {

	#docker
	CMD="docker build -t $PROJECT:$TAG ."
	runCommand

	CMD="docker push $PROJECT:$TAG"
	runCommand

	CMD="docker tag $PROJECT:$TAG $PROJECT:latest"
	runCommand

	CMD="docker push $PROJECT:latest"
	runCommand

}

echo $PWD

PROJECT="registry.cn-beijing.aliyuncs.com/kk/kk-cmake"
buildProject

#exit

echo "[OK] TAG: $TAG"

exitCommand

