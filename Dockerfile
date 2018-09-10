# DOCKER-VERSION 1.0.1
FROM iillmaticc/aem-base-jre-8
MAINTAINER iillmaticc 

# Pulling this from remote quantumdownloads is slow
ONBUILD ADD cq-6.2.jar  /aem/cq-6.2.jar
ONBUILD ADD license.properties /aem/license.properties

# Extracts AEM
ONBUILD WORKDIR /aem
ONBUILD RUN java -Xmx2048M -jar cq-6.2.jar -unpack -r author -p 4502 

# Installs AEM
ONBUILD RUN ["python", "aemInstaller.py", "-i", "cq-6.2.jar", "-r", "author" "-p", "4502"]

#Replaces the port within the quickstart file with the standard publish port
#ONBUILD RUN cp quickstart quickstart.original
#ONBUILD RUN cat quickstart.original | sed "s|4502|4503|g" > quickstart


EXPOSE 4502 8000
ENTRYPOINT ["/aem/crx-quickstart/bin/quickstart"]
