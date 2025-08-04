

FROM registry.redhat.io/jboss-eap-7/eap74-openjdk11-openshift-rhel8 as builder

# Instalar Maven (opcional si no está disponible)
USER root
RUN microdnf install -y maven && microdnf clean all

# Copiar proyecto
COPY . /tmp/app
WORKDIR /tmp/app

# Compilar WAR
RUN mvn clean package

# Fase final: copiar el WAR compilado a la imagen de ejecución
FROM registry.redhat.io/jboss-eap-7/eap74-openjdk11-openshift-rhel8

COPY --from=builder /tmp/app/target/exempledejsp.war /deployments/
