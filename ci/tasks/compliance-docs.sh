#!/bin/sh

inputDir=  outputDir=  versionFile= artifactId=  packaging=

while [ $# -gt 0 ]; do
  case $1 in
    -i | --input-dir )
      inputDir=${PWD}/$2
      shift
      ;;
    -o | --output-dir )
      outputDir=${PWD}/$2
      shift
      ;;
    -a | --artifactId )
      artifactId=$2
      shift
      ;;
    -v | --version-file )
      versionFile=${PWD}/$2
      shift
      ;;
    -p | --packaging )
      packaging=$2
      shift
      ;;
    * )
      echo "Unrecognized option: $1" 1>&2
      exit 1
      ;;
  esac
  shift
done


if [ ! -d "$inputDir" ]; then
  echo "missing input directory!"
  exit 1
fi

if [ ! -d "$outputDir" ]; then
  echo "missing output directory!"
  exit 1
fi

version=`cat $versionFile`
artifactName="${artifactId}-compliance-${version}.${packaging}"

cd ${inputDir}
compliance-masonry get
compliance-masonry docs gitbook LATO

cd ${inputDir}/exports
tar -czf $outputDir/$artifactName *

ls ${outputDir}
