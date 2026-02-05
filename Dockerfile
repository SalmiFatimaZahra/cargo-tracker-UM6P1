

FROM payara/server-full:6.2023.12

# Déployer le WAR automatiquement
COPY target/cargo-tracker.war /opt/payara/appserver/glassfish/domains/domain1/autodeploy/

# Script post-boot (si tu l’utilises)
COPY post-boot-commands.asadmin /opt/payara/config/

