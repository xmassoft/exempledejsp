

# Imagen base: Red Hat JBoss EAP 7.4 con OpenJDK 11
FROM registry.redhat.io/jboss-eap-7/eap74-openjdk11-openshift-rhel8

# Copiamos el WAR al directorio de despliegue
COPY target/exempledejsp.war /deployments/

# Exponer el puerto por donde responderá la app (EAP por defecto)
EXPOSE 8080

# La imagen ya define el CMD de inicio, así que no hace falta reescribirlo.


