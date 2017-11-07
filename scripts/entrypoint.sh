#!/bin/bash

. /kb/deployment/user-env.sh

python ./scripts/prepare_deploy_cfg.py ./deploy.cfg ./work/config.properties

if [ -f ./work/token ] ; then
  export KB_AUTH_TOKEN=$(<./work/token)
fi

if [ $# -eq 0 ] ; then
  sh ./scripts/start_server.sh
elif [ "${1}" = "test" ] ; then
  echo "Run Tests"
  make test
elif [ "${1}" = "async" ] ; then
  sh ./scripts/run_async.sh
elif [ "${1}" = "init" ] ; then
  echo "Initialize module"
  echo "downloading OTU files"
  cd data


  #cd /data/rdata
  curl -o PROTEIN.udb http://bioseed.mcs.anl.gov/~janakae/ProbAnnoData/PROTEIN.udb
  curl -o usearch10.0.240_i86linux32 http://bioseed.mcs.anl.gov/~janakae/ProbAnnoData/usearch10.0.240_i86linux32
  curl -o OTU_FID_ROLE http://bioseed.mcs.anl.gov/~janakae/ProbAnnoData/OTU_FID_ROLE
  #ln -s /rdata/PROTEIN.udb

  #ln -s /data/rdata/OTU_FID_ROLE
  #ln -s /data/rdata/PROTEIN.udb
  #ln -s /data/rdata/usearch10.0.240_i86linux32

  cp usearch10.0.240_i86linux32 /kb/dev_container/modules/ProbAnno-Standalone
  chmod 777 /kb/dev_container/modules/ProbAnno-Standalone/usearch10.0.240_i86linux32

  if [ -d "/data" ]; then
    touch __READY__
  else
    echo "Init failed"
  fi


elif [ "${1}" = "bash" ] ; then
  bash
elif [ "${1}" = "report" ] ; then
  export KB_SDK_COMPILE_REPORT_FILE=./work/compile_report.json
  make compile
else
  echo Unknown
fi
