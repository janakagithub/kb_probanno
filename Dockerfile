FROM kbase/kbase:sdkbase.latest
MAINTAINER KBase Developer
# -----------------------------------------
# In this section, you can install any system dependencies required
# to run your App.  For instance, you could place an apt-get update or
# install line here, a git checkout to download code, or run any other
# installation scripts.

# RUN apt-get update

# download an inifile reader
RUN cpanm -i Config::IniFiles
# download a sequence IO module
RUN cpanm -i Bio::SeqIO
RUN cpanm -i UUID::Random

RUN apt-get -y install nano
# -----------------------------------------

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda2-5.0.0.1-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh


RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean

ENV PATH /opt/conda/bin:$PATH



RUN cd /kb/dev_container/modules && \
    git clone https://github.com/mmundy42/ProbAnno-Standalone.git  && \
    cd ProbAnno-Standalone && \

    echo 'export PATH=/kb/dev_container/modules/ProbAnno-Standalone:$PATH' >> /kb/dev_container/modules/ProbAnno-Standalone/deploy.cfg && \
    echo 'data_dir=/kb/dev_container/modules/ProbAnno-Standalone/data' >> /kb/dev_container/modules/ProbAnno-Standalone/deploy.cfg && \

  	sed -i "s|search_program_path=/local/local_webservices/probanno/ProbAnno-Standalone/bin/usearch|search_program_path=/kb/dev_container/modules/ProbAnno-Standalone/usearch10.0.240_i86linux32|g" /kb/dev_container/modules/ProbAnno-Standalone/deploy.cfg && \

  	sed -i "s|log_dir=/local/local_webservices/probanno/logs/ms-probanno|log_dir=/kb/dev_container/modules/ProbAnno-Standalone/logs|g" /kb/dev_container/modules/ProbAnno-Standalone/deploy.cfg && \

  	sed -i "s|work_dir=/local/local_webservices/probanno/tmp|work_dir=/kb/module/work/tmp |g" /kb/dev_container/modules/ProbAnno-Standalone/deploy.cfg



COPY ./ /kb/module


RUN mkdir -p /kb/module/work
RUN chmod -R a+rw /kb/module

WORKDIR /kb/module

RUN make all
COPY /data/usearch10.0.240_i86linux32 /kb/dev_container/modules/ProbAnno-Standalone

RUN chmod 777 /kb/dev_container/modules/ProbAnno-Standalone/usearch10.0.240_i86linux32 && \
    cd /kb/dev_container/modules/ProbAnno-Standalone/data && \
    curl -o PROTEIN.udb http://bioseed.mcs.anl.gov/~janakae/ProbAnnoData/PROTEIN.udb && \
    curl -o OTU_FID_ROLE http://bioseed.mcs.anl.gov/~janakae/ProbAnnoData/OTU_FID_ROLE



ENTRYPOINT [ "./scripts/entrypoint.sh" ]

CMD [ ]
