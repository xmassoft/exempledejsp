
FROM registry.redhat.io/jboss-eap-7/eap74-openjdk11-openshift-rhel8
 
ENV DISABLE_EMBEDDED_JMS_BROKER=true
 
COPY target/*.war $JBOSS_HOME/standalone/deployments/
 
# Exponer el puerto por donde responde la aplicación
EXPOSE 8080

