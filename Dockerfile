# DOCKER-VERSION 1.0.1
FROM iillmaticc/aem-base
MAINTAINER iillmaticc 

# Pulling this from remote quantumdownloads is slow
ONBUILD ADD cq-6.2.jar  /aem/cq-6.2.jar
ONBUILD ADD license.properties /aem/license.properties

# Extracts AEM
ONBUILD WORKDIR /aem
ONBUILD RUN java -Xmx2048M -jar cq-6.2.jar -unpack -r author -p 4502 


# Installs AEM
ONBUILD RUN python aemInstaller.py -i cq-6.2.jar -r author -p 4502

# Add .zip(s) to install post unpacking
ONBUILD RUN mkdir -p /aem/crx-quickstart/install

EXPOSE 4502 8000
ENTRYPOINT ["/aem/crx-quickstart/bin/quickstart"]
