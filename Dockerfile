FROM payara/server-full:6.2023.12
COPY target/postgresql.jar /opt/payara/appserver/glassfish/domains/domain1/lib/
COPY target/cargo-tracker.war /opt/payara/appserver/glassfish/domains/domain1/autodeploy/
COPY post-boot-commands.asadmin /opt/payara/config/

