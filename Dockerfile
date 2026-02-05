# FROM payara/server-full:6.2023.12

# COPY target/postgresql.jar /tmp
# COPY target/cargo-tracker.war /tmp
# COPY post-boot-commands.asadmin /opt/payara/config/
FROM payara/server-full:6.2023.12

# Bonne pratique : Mettre le JDBC driver dans le bon dossier Payara
# COPY target/postgresql.jar /opt/payara/appserver/glassfish/domains/domain1/lib/

# Déployer le WAR directement dans autodeploy pour que Payara le démarre automatiquement
COPY target/cargo-tracker.war /opt/payara/appserver/glassfish/domains/domain1/autodeploy/

# Script post-boot (si tu en as besoin)
COPY post-boot-commands.asadmin /opt/payara/config/

