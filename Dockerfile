

# Fase de construcción con Maven
FROM maven:3.8.6-openjdk-11 AS builder

# Copiar el código fuente
WORKDIR /app
COPY . .

# Construir el proyecto
RUN mvn clean package

# Fase de ejecución con JBoss EAP 7.4
FROM registry.redhat.io/jboss-eap-7/eap74-openjdk17-openshift

# Configurar usuario y permisos para OpenShift
USER root
RUN chown -R jboss:root /opt/eap && \
    chmod -R ug+rwx /opt/eap

# Copiar el WAR construido al directorio de despliegues de JBoss
COPY --from=builder /app/target/*.war /opt/eap/standalone/deployments/

# Volver al usuario jboss (requerido por OpenShift)
USER jboss

# Puerto por defecto para JBoss
EXPOSE 8080

# Comando para ejecutar JBoss
CMD ["/opt/eap/bin/openshift-launch.sh"]