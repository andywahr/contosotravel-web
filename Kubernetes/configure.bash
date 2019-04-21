rg=$1
sub=$2
namePrefix=$3
pathToDeploy=$4
buildId=$5
deployName=$6
containerName=$7
serviceName=$8

pwsh ./configure.ps1 -rg $rg -sub $sub -namePrefix $namePrefix -pathToDeploy $pathToDeploy $buildId $deployName $containerName $serviceName
